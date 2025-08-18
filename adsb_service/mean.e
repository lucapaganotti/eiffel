note
	description: "Summary description for {MEAN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MEAN

inherit
	MEAN_CONSTANTS
	undefine
		out
	end
	LOG_PRIORITY_CONSTANTS
	undefine
		out
	end
	CURL_EXTERNALS
	undefine
		out
	end

create
	make

feature {NONE} -- Initialization

	make (hexid: STRING)
			-- Initialization for `Current'.
		do
			create transponder.make_from_string (hexid)
			create source.make
			create target.make
			create type.make_from_string (overflight)
			create pos.make (0)
			create last_logged.make_now

			create auth_token.make
			create tracks_path.make_empty
			create routes_url.make_empty
			create routes_url2.make_empty

			create ref_arpt.make_empty

			create airline.make
		end

feature -- Access

	addr: STRING
			--
		do
			Result := transponder.addr
		end

	transponder:   TRANSPONDER             -- assign set_transponder
	callsign:      detachable STRING       assign set_callsign
	source:        AIRPORT                 -- assign set_source
	target:        AIRPORT                 -- assign set_target
	type:          STRING                  -- assign set_ype
	pos:           ARRAYED_LIST[POSITION]
	ref_pos:       detachable POSITION
	ground_speed:  DOUBLE                  assign set_ground_speed
	track_angle:   DOUBLE                  assign set_track_angle
	vertical_rate: INTEGER                 assign set_vertical_rate
	last_logged:   DATE_TIME               assign set_last_logged
	ref_arpt:      STRING                  assign set_reference_airport
	alerted:       INTEGER                 assign set_alerted
	emergency:     INTEGER                 assign set_emergency
	squawk:        INTEGER                 assign set_squawk
	on_ground:     BOOLEAN                 assign set_on_ground

	airline:       AIRLINE                 assign set_airline

    auth_token:    AUTH_TOKEN
	tracks_path:   STRING
	routes_url:    STRING
	routes_url2:   STRING

	logger:        detachable LOG_LOGGING_FACILITY

	is_routed: BOOLEAN
			--
		do
			Result := not source.icao.is_equal ("N.A.") or not target.icao.is_equal ("N.A.")
		end

	is_directed: BOOLEAN
			--
		do
			Result := source.icao = ref_arpt or target.icao = ref_arpt
		end

	is_alerted: BOOLEAN
			--
		do
			Result := alerted /= 0
		end

	has_emergency, is_in_emergency: BOOLEAN
			--
		do
			Result := emergency /= 0
		end

	was_globally_position_decoded: BOOLEAN
			--
		do
			Result := attached ref_pos
		end

feature -- Commands

	set_callsign (cs: detachable STRING)
			--
		do
			callsign := cs
		end

	set_ground_speed (gs: DOUBLE)
			--
		do
			ground_speed := gs
		end

	set_track_angle (ta: DOUBLE)
			--
		do
			track_angle := ta
		end

	set_vertical_rate (vr: INTEGER)
			--
		do
			vertical_rate := vr
		end

	set_last_logged (ll: DATE_TIME)
			--
		do
			last_logged := ll
		end

	set_auth_token (t: AUTH_TOKEN)
			--
		do
			auth_token := t
		end

	set_tracks_path (p: STRING)
			--
		do
			tracks_path := p
		end

	set_routes_url (u: STRING)
			--
		do
			routes_url := u
		end

	set_routes_url2 (u: STRING)
			--
		do
			routes_url2 := u
		end

	set_reference_airport (a: STRING)
			--
		do
			ref_arpt := a
		end

	set_alerted (a: INTEGER)
			--
		do
			alerted := a
		end

	set_emergency (e: INTEGER)
			--
		do
			emergency := e
		end

	set_squawk (s: INTEGER)
			--
		do
			squawk := s
		end

	set_on_ground (og: BOOLEAN)
			--
		do
			on_ground := og
		end

	set_airline (a: AIRLINE)
			--
		require
			a_attached: attached a
		do
			airline := a
		ensure
			airline_set: airline = a
		end

	set_logger (l: LOG_LOGGING_FACILITY)
			--
		do
			logger := l
		end

	write: BOOLEAN
			-- write `Current' as a json object
		local
			l_filename: STRING
			l_mtext:    STRING
			l_f:        PLAIN_TEXT_FILE
		do
			if pos.count > 0 and then (source.icao.is_equal (ref_arpt) or target.icao.is_equal (ref_arpt)) then
				l_filename := make_file_name
				if l_filename.is_empty then
					Result := false
				else
					create l_mtext.make_empty
					l_mtext.append ("{")
					l_mtext.append ("%"A%":%"" + addr + "%",")
					l_mtext.append ("%"CS%":")
					if attached {STRING} callsign as l_cs then
						if not l_cs.is_empty then
							l_mtext.append ("%"" + l_cs + "%",")
						else
							l_mtext.append ("%"N.A.%",")
						end
					else
						l_mtext.append ("%"N.A.%",")
					end
					l_mtext.append ("%"S%":")
					if not source.icao.is_empty then
						l_mtext.append (source.icao)
					else
						l_mtext.append("%"N.A.%"")
					end
					l_mtext.append (",")
					l_mtext.append ("%"D%":")
					if not target.icao.is_empty then
						l_mtext.append (target.icao)
					else
						l_mtext.append ("%"N.A.%"")
					end
					l_mtext.append (",")
					l_mtext.append ("%"AT%":")
					if not type.is_empty then
						l_mtext.append (type)
					else
						l_mtext.append ("%"N.A.%"")
					end
					 l_mtext.append (",")
					l_mtext.append ("%"POS%": [")
					from
						pos.start
					until
						pos.after
					--across pos as p --all  end
					loop
						l_mtext.append ("{")
						l_mtext.append ("%"X%":" + pos.item.x.out + ",")
						l_mtext.append ("%"Y%":" + pos.item.y.out + ",")
						l_mtext.append ("%"Z%":" + pos.item.z.out + ",")
						l_mtext.append ("%"T%":%"" + pos.item.t.out + "%",")
						l_mtext.append ("%"GS%":" + ground_speed.out + ",")
						l_mtext.append ("%"TA%":" + track_angle.out + ",")
						l_mtext.append ("%"VR%":" + vertical_rate.out)
						l_mtext.append ("}")
						if not pos.islast then
							l_mtext.append (",")
						end
						--pos.forth
					end

					l_mtext.append ("]")

					l_mtext.append ("}")

					create l_f.make_open_read_append (l_filename)
					l_f.put_string (l_mtext)
					l_f.put_new_line
					l_f.flush
					l_f.close
				end
			else
				Result := false
			end
		end

	scan
			--
		local
			first: POSITION
			last:  POSITION
		do
			if is_directed and then pos.count > 0 then
				first := pos.first
				last  := pos.last

				if first.z > last.z and then first.z - last.z > 200 then
					type := arrival
				elseif first.z < last.z and then last.z - first.z > 200 then
					type := departure
				end
			end
		end

feature -- Implementation

	make_file_name : STRING
			--
		do
			create Result.make_empty
			if pos.count > 0 then
				-- can write somethig to file
				Result.append (tracks_path)
				Result.append ("/" + pos[1].t.formatted_out ("yyyy[0]mm[0]dd"))
				Result.append (".json")
			end
		end

feature {ADSB_RAW_CLIENT} -- CPR - Compact Position Reporting

	even_msg_data: detachable AIRBORNE_POSITION_ME_SEGMENT_DATA
	odd_msg_data:  detachable AIRBORNE_POSITION_ME_SEGMENT_DATA

	globally_unambiguous_decoding
			--
		local
			first, second: AIRBORNE_POSITION_ME_SEGMENT_DATA
		do
			if attached {AIRBORNE_POSITION_ME_SEGMENT_DATA} even_msg_data as l_e and then attached {AIRBORNE_POSITION_ME_SEGMENT_DATA} odd_msg_data as l_o then
				-- can try to decode
				if l_e.reception_time > l_o.reception_time then
					first  := l_e
					second := l_o
				elseif l_o.reception_time > l_e.reception_time then
					first  := l_o
					second := l_e
				end

			else
				do_log (log_debug, "Can't decode CPR messages as one of them is not attached")
			end
		end

feature -- IO

	out: STRING
			--
		do
			create Result.make_empty

			Result.append (addr + " ")
			if attached {STRING} callsign as l_cs then
				Result.append (l_cs + " ")
			else
				Result.append ("NA ")
			end
			Result.append (source.icao + " " + target.icao)
			Result.append (" " + type)
		end

feature {NONE}	-- Logging

	do_log(level: INTEGER msg: STRING)
			--
		do
			if attached {LOG_LOGGING_FACILITY} logger as l_logger then
				if level = log_alert then
					l_logger.write_alert (msg)
				elseif level = log_critical then
					l_logger.write_critical (msg)
				elseif level = log_debug then
					l_logger.write_debug (msg)
				elseif level = log_emergency then
					l_logger.write_emergency (msg)
				elseif level = log_error then
					l_logger.write_error (msg)
				elseif level = log_information then
					l_logger.write_information (msg)
				elseif level = log_notice then
					l_logger.write_notice (msg)
				elseif level = log_warning then
					l_logger.write_warning (msg)
				else
					l_logger.write_information (msg)
				end
			end
		end


feature {ADSB_CLIENT}  -- Routes

	retrieve_route_sft
			--
		local
			curl_handle: POINTER
			postfields:  STRING
			res:         INTEGER
			slist:       POINTER
			useragent:   STRING
			data:        CURL_STRING
			jp:          JSON_PARSER
			easy:        CURL_EASY_EXTERNALS
		do
			create data.make_empty
			create postfields.make_empty
			create useragent.make_empty
			useragent := "adsb service"

			create easy

			if attached {STRING} callsign as l_cs then

				postfields := "[%"" + l_cs + "%"]"

				if is_api_available then

					curl_handle := easy.init

					if not curl_handle.is_default_pointer then
						easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_url, routes_url + "/CheckFlightRoute")
						slist := slist_append (slist, "Accept:")
						slist := slist_append (slist, "Content-Type: application/json")
						slist := slist_append (slist, "Authorization: Bearer " + auth_token.token)
						easy.setopt_slist (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_httpheader, slist)
						easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_postfields, postfields)
						easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_ssl_verifypeer, 0)
						easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_ssl_verifyhost, 0)
						easy.setopt_string  (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_useragent, useragent)
						easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_fresh_connect,  1)
						easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_forbid_reuse,   1)
						easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_buffersize, 1024)
						easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_connect_timeout, 2)
						easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_timeout, 5)
						easy.set_write_function (curl_handle)
						easy.setopt_curl_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_writedata, data)

						res := easy.perform (curl_handle)

						if res /= {CURL_CODES}.curle_ok then
							do_log (Log_error, "cURL error " + res.out)
						else
							do_log (Log_information, "auth token request response: " + data)
							if not data.is_empty then
								create jp.make_with_string (data)
								jp.parse_content
								if not jp.has_error and jp.is_parsed then
									if jp.is_valid and then attached jp.parsed_json_value as jv then
										if
											attached {JSON_ARRAY} jv as j_array
										then
											if attached {JSON_OBJECT} j_array.i_th (1) as j_object then
												if attached {JSON_STRING} j_object.item ("from") as j_from and then
											       attached {JSON_STRING} j_object.item ("to") as j_to then
												    source.set_icao (j_from.item)
												    target.set_icao (j_to.item)
												else
													source.set_icao ("N.A.")
													target.set_icao ("N.A.")
												end
											else
												source.set_icao ("N.A.")
												target.set_icao ("N.A.")
											end
										else
											source.set_icao ("N.A.")
											target.set_icao ("N.A.")
										end


									end
								else
									from jp.errors.start
									until jp.errors.after
									loop
										-- put_line
									end
								end
								--logger.write_information("auth token: " + auth_token)
							else
								source.set_icao ("N.A.")
								target.set_icao ("N.A.")
							end
						end
					end
				end

				easy.cleanup (curl_handle)
			else

			end
		end

	retrieve_route
			--
		local
			curl_handle: POINTER
			postfields:  STRING
			res:         INTEGER
			slist:       POINTER
			useragent:   STRING
			data:        CURL_STRING
			mp:          CELL[detachable ANY]
			status_code: INTEGER
			jp:          JSON_PARSER
			easy:        CURL_EASY_EXTERNALS
			url:         STRING
		do
			create data.make_empty
			create postfields.make_empty
			create useragent.make_empty
			useragent := "adsb service"

			create easy
			create url.make_empty

			if attached {STRING} callsign as l_cs then
				if easy.is_api_available then

					curl_handle := easy.init

					if not curl_handle.is_default_pointer then
						url := routes_url2 + "/callsign/" + l_cs
						--url := "https://www.adsbdb.com"
						easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_url, url)
						slist := slist_append (slist, "Accept: */*")
						--slist := slist_append (slist, "Accept-Encoding: gzip, deflate, br")
						slist := slist_append (slist, "Content-Type: application/json")
						slist := slist_append (slist, "it-IT,it;q=0.9,en-US;q=0.8,en;q=0.7")

						--slist := slist_append (slist, "Content-Length: 0")
						--slist := slist_append (slist, "Authorization: Bearer " + auth_token.token)
						easy.setopt_slist (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_httpheader, slist)
						--easy.setopt_string (curl_handle, curlopt_postfields, postfields)
						easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_ssl_verifypeer, 0)
						easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_ssl_verifyhost, 0)
						easy.setopt_string  (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_useragent, useragent)
						easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_fresh_connect,  1)
						easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_forbid_reuse,   1)
						easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_buffersize, 1024)
						easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_connect_timeout, 2)
						easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_timeout, 5)
						--easy.setopt_integer (curl_handle, curlopt_followlocation, 1)
						--easy.setopt_integer (curl_handle, curlopt_maxredirs, 50)
						easy.set_write_function (curl_handle)
						easy.setopt_curl_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_writedata, data)

						res := easy.perform (curl_handle)

						if res /= {CURL_CODES}.curle_ok then
							do_log (Log_error, "cURL error " + res.out)
						else
							-- get curl status code
							create mp.put (Void)
							res := easy.getinfo (curl_handle, {CURL_INFO_CONSTANTS}.curlinfo_response_code, mp)
							if attached {INTEGER_32} mp.item as c then
								status_code := c
							end

							do_log (log_information, "HTTP status code " + status_code.out)

							if status_code = 200 then
								create jp.make_with_string (data)
								jp.parse_content
								if not jp.has_error and jp.is_parsed then
									if jp.is_valid and then attached jp.parsed_json_object as jv then
										if attached {JSON_OBJECT} jv.item ("response") as j_response then
											if attached {JSON_OBJECT} j_response.item ("flightroute") as j_route then
											   if attached {JSON_OBJECT} j_route.item ("origin")      as j_origin      and then
												  attached {JSON_OBJECT} j_route.item ("destination") as j_destination then
														if attached {JSON_STRING} j_origin.item ("icao_code") as j_origin_icao then
															source.set_icao (j_origin_icao.item)
														else
															source.set_icao ("N.A.")
														end
														if attached {JSON_STRING} j_destination.item ("icao_code") as j_destination_icao then
															target.set_icao (j_destination_icao.item)
														else
															target.set_icao ("N.A.")
														end
												else
													source.set_icao ("N.A.")
											    	target.set_icao ("N.A.")
											    end
											else
												source.set_icao ("N.A.")
											    target.set_icao ("N.A.")
											end
										else
											source.set_icao ("N.A.")
										    target.set_icao ("N.A.")
										end
									else
										do_log (Log_error, "Unable to parse response " + data)
									end
								end
--								{
--								    "response": {
--								        "flightroute": {
--								            "callsign": "VOE2957",
--								            "callsign_icao": "VOE2957",
--								            "callsign_iata": "2957",
--								            "airline": {
--								                "name": "Volotea",
--								                "icao": "VOE",
--								                "iata": null,
--								                "country": "Spain",
--								                "country_iso": "ES",
--								                "callsign": null
--								            },
--								            "origin": {
--								                "country_iso_name": "FR",
--								                "country_name": "France",
--								                "elevation": 505,
--								                "iata_code": "SXB",
--								                "icao_code": "LFST",
--								                "latitude": 48.538299560546875,
--								                "longitude": 7.628230094909668,
--								                "municipality": "Strasbourg",
--								                "name": "Strasbourg Airport"
--								            },
--								            "destination": {
--								                "country_iso_name": "FR",
--								                "country_name": "France",
--								                "elevation": 26,
--								                "iata_code": "BIA",
--								                "icao_code": "LFKB",
--								                "latitude": 42.55270004272461,
--								                "longitude": 9.48373031616211,
--								                "municipality": "Bastia/Poretta",
--								                "name": "Bastia-Poretta Airport"
--								            }
--								        }
--								    }
--								}
							end

						end
					end

					easy.cleanup (curl_handle)

				end
			end
		end

end
