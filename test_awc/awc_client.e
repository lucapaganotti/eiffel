note
	description: "test_awc application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	AWC_CLIENT

inherit
	ARGUMENTS_32
	EXCEPTIONS
	AWC_CONSTANTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			l_idx:        INTEGER
			l_client:     DEFAULT_HTTP_CLIENT
			l_session:    HTTP_CLIENT_SESSION
			l_ctx:        HTTP_CLIENT_REQUEST_CONTEXT
			l_path:       STRING
			l_metar:      METAR
			l_metar_data: METAR_DATA
			l_parser:     XML_STANDARD_PARSER
				-- httpparam?dataSource=metars&requestType=retrieve&format=xml&stationString=$ARPT_ICAO_CODE$&hoursBeforeNow=3&mostRecent=true
		do
			-- create airport icao
			create airport_icao.make_empty
			-- create query string
			create query.make_from_string (standard_metar_query)

			-- XML parser
			create xml_parser_factory
			xml_parser := xml_parser_factory.new_standard_parser

			l_idx := index_of_word_option ("a")
			if l_idx > 0 then
				-- set airport icao
				airport_icao := argument (l_idx + 1).out
				-- substitute airport icao in query string
				query.replace_substring_all ("$ARPT_ICAO_CODE$", airport_icao)
			else
				io.put_string ("Missing required parameter: airport_ICAO_code --> dying%N")
				io.put_string (usage)
				die (0)
			end

			l_parser := xml_parser_factory.new_standard_parser
			create l_metar.make
			create l_ctx.make
			create l_client
			create l_path.make_from_string (query)
			l_session := l_client.new_session (current_dataserver)
			l_session.set_timeout (10)
			if attached l_session.get (l_path, l_ctx) as l_response then
				if not l_response.error_occurred then
					if attached l_response.body as l_body then
						print (l_body.out)
						l_metar.set_body (l_body)
						l_metar.set_parser (l_parser)
						l_metar.parse
					end
				end
			else
				print ("ERROR: interface not available%N")
			end

			l_session.close
		end

feature -- METAR

	retrieve_metar: STRING
			--
		do
			create result.make_empty
		end

feature -- Helpers

	usage: STRING
			-- Usage message.
		do
			Result := "Test AWC METAR service%N"
			Result := Result + "usage: test_awc -a <airport_ICAO_code>%N"
			Result := Result + "  <airportICAO_code> is as written i.e. LIMC%N"
			Result := Result + "    This parameter is required%N%N"
		end

feature -- Constants

	current_dataserver: STRING = "https://aviationweather.gov/adds/dataserver_current/"
			-- Current AWC data server

	dataserver_1_3: STRING = "https://aviationweather.gov/adds/dataserver1_3/"
			-- AWC data server version 1.3

feature {NONE} -- Implementation

	xml_parser_factory: XML_PARSER_FACTORY
            -- Global xml parser factory
	xml_parser:  XML_STANDARD_PARSER
			-- Global XML parser
	airport_icao: STRING
			-- Reference airport ICAO code
	query: STRING
			-- Query string

end
