note
	description: "[
					Description for {METAR}.
					
					<METAR>
					  <raw_text>
					    LIMC 101020Z 03006KT 010V070 9999 BKN030 20/12 Q1018 NOSIG
					  </raw_text>
					  <station_id>LIMC</station_id>
					  <observation_time>2019-09-10T10:20:00Z</observation_time>
					  <latitude>45.62</latitude>
					  <longitude>8.72</longitude>
					  <temp_c>20.0</temp_c>
					  <dewpoint_c>12.0</dewpoint_c>
					  <wind_dir_degrees>30</wind_dir_degrees>
					  <wind_speed_kt>6</wind_speed_kt>
					  <visibility_statute_mi>6.21</visibility_statute_mi>
					  <altim_in_hg>30.059055</altim_in_hg>
					  <quality_control_flags>
					    <no_signal>TRUE</no_signal>
					  </quality_control_flags>
					  <sky_condition sky_cover="BKN" cloud_base_ft_agl="3000"/>
					  <flight_category>MVFR</flight_category>
					  <metar_type>METAR</metar_type>
					  <elevation_m>211.0</elevation_m>
					</METAR>
				]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	METAR

inherit
	XML_CALLBACKS
	undefine
		out
	end
	AWC_XML_METAR_TAGS
	undefine
		out
	end

create
	make,
	make_with_body,
	make_with_body_and_parser

feature {NONE} -- Initialization

	internal_init
			-- `Current' features initialization.
		do
			create observation_time.make_now
			create station.make_empty
			create raw_text.make_empty
			create flight_category.make_empty
			create metar_type.make_empty

			-- `XML_CALLBACKS' features
			create current_tag.make_empty
			create content.make_empty
		end

	make
			-- Initialization for `Current'.
		do
			internal_init
		end

	make_with_body (a_body: like body)
			-- Initialization for `Current'.
		require
			a_body_attached: attached a_body
		do
			internal_init
			body := a_body
		end

	make_with_body_and_parser (a_body: like body; a_parser: like parser)
			-- Inizialization for `Current'.
		require
			a_body_attached:   attached a_body
			a_parser_attached: attached a_parser
		do
			internal_init
			body   := a_body
			parser := a_parser
			parse
		end


feature -- Access

	raw_text:                STRING
			-- Raw METAR string

	station:                 STRING
			-- Station identifier - ICAO code

	observation_time:        DATE_TIME
			-- Observation date time

	latitude:                DOUBLE
			--Station latitude

	longitude:               DOUBLE
			-- Station longitude

	elevation:               DOUBLE
			-- Station elevation

	temperature_c:           DOUBLE
			-- Temperature

	dew_point_c:             DOUBLE
			-- Dew point

	wind_dir_degrees:        INTEGER
			-- Wind direction in degrees

	wind_speed_kt:           INTEGER
			-- Wind speed in knots

	visibility_statute_mile: DOUBLE
			-- Visibility statute miles

	altimetry_in_hg:         DOUBLE
			-- Altimetry in Hg mm

	-- quality contro flags TO BE DONE

	-- sky condition TO BE DONE

	flight_category:         STRING
			-- Flight category

	metar_type:              STRING
			-- METAR type

	body:                    detachable STRING
			-- XML raw text

	parser:                  detachable XML_STANDARD_PARSER
			-- XML standard parser.


feature -- Measurement

feature -- Status report

	out: STRING
			--
		do
			Result := raw_text
		end

feature -- Status setting

	set_raw_text (a_text: like raw_text)
			-- Raw METAR string
		do
			raw_text := a_text
		end

	set_station (a_station: like station)
			-- Station identifier - ICAO code
		do
			station := a_station
		end

	set_observation_time (a_time: like observation_time)
			-- Observation date time
		do
			observation_time := a_time
		end

	set_latitude (a_latitude: like latitude)
			--Station latitude
		do
			latitude := a_latitude
		end

	set_longitude (a_longitude: like longitude)
			-- Station longitude
		do
			longitude := a_longitude
		end

	set_elevation (a_elevation: like elevation)
			-- Station elevation
		do
			elevation := a_elevation
		end

	set_temperature_c (a_temperature: like temperature_c)
			-- Temperature
		do
			temperature_c := a_temperature
		end

	set_dew_point_c (a_dew_point: like dew_point_c)
			-- Dew point
		do
			dew_point_c := a_dew_point
		end

	set_wind_dir_degrees (a_dir: like wind_dir_degrees)
			-- Wind direction in degrees
		do
			wind_dir_degrees := a_dir
		end

	set_wind_speed_kt (a_speed: like wind_speed_kt)
			-- Wind speed in knots
		do
			wind_speed_kt := a_speed
		end

	set_visibility_statute_mile (a_visibility: like visibility_statute_mile)
			-- Visibility statute miles
		do
			visibility_statute_mile := a_visibility
		end

	set_altimetry_in_hg (a_altimetry: like altimetry_in_hg)
			-- Altimetry in Hg mm
		do
			altimetry_in_hg := a_altimetry
		end

	set_flight_category (a_category: like flight_category)
			-- Flight category
		do
			flight_category := a_category
		end

	set_metar_type (a_type: like metar_type)
			-- METAR type
		do
			metar_type := a_type
		end

	set_body (a_body: like body)
			-- XML body
		require
			a_body_attached: attached a_body
		do
			body := a_body
		end

	set_parser (a_parser: like parser)
			-- XML parser
		require
			a_parser_attached: attached a_parser
		do
			parser := a_parser
		end

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

	parse
        	-- Parse XML message
        require
        	body_attached:   attached body
        	parser_attached: attached parser
        do
        	if attached parser as l_parser then
        		l_parser.set_callbacks (Current)
	            set_associated_parser (l_parser)
	            if attached body as l_body then
	            	l_parser.parse_from_string (l_body)
	            else
					-- log error
	            end
	            l_parser.reset
	        else

        	end
        end

feature -- Conversion

feature -- XML callbacks

	on_start
			--
		do
			io.put_string ("{XML_CALLBACKS}.on_start%N")
		end

	on_finish
			--
		do
			io.put_string ("{XML_CALLBACKS}.on_finish%N")
		end

	on_xml_declaration (a_version: READABLE_STRING_32; an_encoding: detachable READABLE_STRING_32; a_standalone: BOOLEAN)
			--
		do
			io.put_string ("{XML_CALLBACKS}.on_xml_declaration%N")
			io.put_string ("version   : " + a_version + "%N")
			if attached an_encoding as encoding then
				io.put_string ("encoding  : " + encoding + "%N")
			else
				io.put_string ("encoding  : Void%N")
			end
			if a_standalone then
				io.put_string ("standalone: true%N")
			else
				io.put_string ("standalone: false%N")
			end
		end

	on_error (a_message: READABLE_STRING_32)
			--
		do
			io.put_string ("{XML_CALLBACKS}.on_error%N")
			io.put_string ("message: " + a_message + "%N")
		end

	on_processing_instruction (a_name, a_content: READABLE_STRING_32)
			--
		do
			io.put_string ("{XML_CALLBACKS}.on_processing_instruction%N")
			io.put_string ("name:    " + a_name + "%N")
			io.put_string ("content: " + a_content + "%N")
		end

	on_comment (a_content: READABLE_STRING_32)
			--
		do
			io.put_string ("{XML_CALLBACKS}.on_commen%N")
			io.put_string ("content: " + a_content + "%N")
		end

	on_start_tag (a_namespace, a_prefix: detachable READABLE_STRING_32; a_local_part: READABLE_STRING_32)
			--
		do

			io.put_string ("{XML_CALLBACKS}.on_start_tag%N")
			if attached a_namespace as namespace then
				io.put_string ("namespace: " + namespace + "%N")
			else
				io.put_string ("namespace: Void%N")
			end
			if attached a_prefix as pref then
				io.put_string ("prefix:    " + pref + "%N")
			else
				io.put_string ("prefix:    Void%N")
			end
			io.put_string ("local part: " + a_local_part + "%N")
			current_tag := a_local_part
		end

	on_attribute (a_namespace, a_prefix: detachable READABLE_STRING_32; a_local_part, a_value: READABLE_STRING_32)
			--
		do
			io.put_string ("{XML_CALLBACKS}.on_attribute%N")
			if attached a_namespace as namespace then
				io.put_string ("namespace: " + namespace + "%N")
			else
				io.put_string ("namespace: Void%N")
			end
			if attached a_prefix as pref then
				io.put_string ("prefix:    " + pref + "%N")
			else
				io.put_string ("prefix:    Void%N")
			end
			io.put_string ("local part: " + a_local_part + "%N")
			io.put_string ("value:      " + a_value + "%N")
		end

	on_start_tag_finish
			--
		do
			io.put_string ("{XML_CALLBACKS}.on_start_tag_finish%N")
		end

	on_end_tag (a_namespace, a_prefix: detachable READABLE_STRING_32; a_local_part: READABLE_STRING_32)
			--
		do
			if attached current_tag as tag then
				tag.wipe_out
			end
			io.put_string ("{XML_CALLBACKS}.on_end_tag%N")
			if attached a_namespace as namespace then
				io.put_string ("namespace: " + namespace + "%N")
			else
				io.put_string ("namespace: Void%N")
			end
			if attached a_prefix as pref then
				io.put_string ("prefix:    " + pref + "%N")
			else
				io.put_string ("prefix:    Void%N")
			end
			io.put_string ("local part: " + a_local_part + "%N")
		end

	on_content (a_content: READABLE_STRING_32)
			--
		local
			l_tidx:     INTEGER
			l_zidx:     INTEGER
			l_content:  STRING
		do
			io.put_string ("{XML_CALLBACKS}.on_content%N")
			io.put_string ("content: " + a_content + "%N")

			if attached current_tag as tag then
				if tag.is_equal (metar_tag) then
					io.put_string ("Found tag " + metar_tag + "%N")
				elseif tag.is_equal (raw_text_tag) then
					raw_text := a_content
					io.put_string ("Found tag " + raw_text_tag + " with value --> " + raw_text + "%N")
				elseif tag.is_equal (station_id_tag) then
					station := a_content
					io.put_string ("Found tag " + station_id_tag + " with value --> " + station + "%N")
				elseif tag.is_equal (observation_time_tag) then
					l_content := a_content
					l_tidx := l_content.index_of ('T', 1)
					if l_tidx > 0 then
						l_content := l_content.substring (1, l_tidx - 1) + " " + l_content.substring (l_tidx + 1, l_content.count)
					end
					l_zidx := l_content.index_of ('Z', 1)
					if l_zidx > 0 then
						l_content := l_content.substring (1, l_zidx - 1) + " " + l_content.substring (l_zidx + 1, l_content.count)
					end
					if l_tidx /= 0 and l_zidx /= 0 then
						observation_time.make_from_string (l_content, "yyyy-[0]mm-[0]dd hh:[0]mi:[0]ss")
						io.put_string ("Found tag " + station_id_tag + " with value --> " + observation_time.formatted_out ("yyyy-[0]-mm[0]dd hh:[0]mi:[0]ss") + "%N")
					end
				elseif tag.is_equal (latitude_tag) then
					latitude := a_content.to_double
					io.put_string ("Found tag " + latitude_tag + " with value --> " + latitude.out + "%N")
				elseif tag.is_equal (longitude_tag) then
					longitude := a_content.to_double
					io.put_string ("Found tag " + longitude_tag + " with value --> " + longitude.out + "%N")
				elseif tag.is_equal (temp_c_tag) then
					temperature_c := a_content.to_double
					io.put_string ("Fount tag " + temp_c_tag + " with value --> " + temperature_c.out + "%N")
				elseif tag.is_equal (dew_point_c_tag) then
					dew_point_c := a_content.to_double
					io.put_string ("Fount tag " + dew_point_c_tag + " with value --> " + dew_point_c.out + "%N")
				elseif tag.is_equal (wind_dir_degrees_tag) then
					wind_dir_degrees := a_content.to_integer
					io.put_string ("Fount tag " + wind_dir_degrees_tag + " with value --> " + wind_dir_degrees.out + "%N")
				elseif tag.is_equal (wind_speed_kt_tag) then
					wind_speed_kt := a_content.to_integer
					io.put_string ("Fount tag " + wind_speed_kt_tag + " with value --> " + wind_speed_kt.out + "%N")
				elseif tag.is_equal (visibility_statute_mi_tag) then
					visibility_statute_mile := a_content.to_double
					io.put_string ("Fount tag " + visibility_statute_mi_tag + " with value --> " + visibility_statute_mile.out + "%N")
				elseif tag.is_equal (altim_in_hg_tag) then
					altimetry_in_hg := a_content.to_double
					io.put_string ("Fount tag " + altim_in_hg_tag + " with value --> " + altimetry_in_hg.out + "%N")
				elseif tag.is_equal (quality_control_flags_tag) then
					-- TO BE DONE
				elseif tag.is_equal (qcf_no_signal_tag) then
					-- TO BE DONE
				elseif tag.is_equal (sky_condition_tag) then
					-- TO BE DONE
				elseif tag.is_equal (flight_category_tag) then
					flight_category := a_content
					io.put_string ("Fount tag " + flight_category_tag + " with value --> " + flight_category + "%N")
				elseif tag.is_equal (metar_type_tag) then
					metar_type := a_content
					io.put_string ("Fount tag " + metar_type_tag + " with value --> " + metar_type + "%N")
				elseif tag.is_equal (elevation_m_tag) then
					elevation := a_content.to_double
					io.put_string ("Fount tag " + elevation_m_tag + " with value --> " + elevation.out + "%N")
				end
			end
		end

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	current_tag: detachable STRING
			-- Used by `XML_CALLBACKS' inherited features
	content:     detachable STRING
			-- Used by `XML_CALLBACKS' inherited features

invariant
	invariant_clause: True -- Your invariant here

end
