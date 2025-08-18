note
	description: "{METAR_LEXER} METAR is an International specification by WMO and ICAO organizations."
	author: "Luca Paganotti"
	date: "$Date$"
	revision: "$Revision$"

class
	METAR_LEXER

inherit
	SCANNING
	rename
		make as make_scanning
	redefine
		begin_analysis, end_analysis, do_a_token
	end
	WEATHER_CODES
	undefine
		is_equal, copy
	end
	CLOUD_COVERAGE_CODES
	undefine
		is_equal, copy
	end
	WMO_CLOUD_TYPES
	undefine
		is_equal, copy
	end
	METAR_MESSAGE_TYPE
	undefine
		is_equal, copy
	end
	RUNWAY_CONDITION_CODES
	undefine
		is_equal, copy
	end
	BRAKING_ACTION_CODES
	undefine
		is_equal, copy
	end

create
	make

feature {NONE} -- Initialization

		-- METAR LBBG 041600Z 12012MPS 090V150 1400 R04/P1500N R22/P1500U +SN BKN022 OVC050 M04/M07 Q1020 NOSIG 8849//91=

	make
			--
		do
			test_string         := "METAR LBBG 041600Z 12012MPS 090V150 1400 R04/P1500N R22/P1500U +SN BKN022 OVC050 M04/M07 Q1020 NOSIG 8849//91="
			test_string         := "METAR ALMG 071800Z 34004KT 9999 SCT017 FEW023CB 33/25 Q1008="
			test_string         := "METAR AYMH 290900Z VRB03KT 9999 SCT005 19/17 Q1019="
			test_string         := "METAR AYNZ 290900Z 10010KT 9999 HZ BKN100 27/23 Q1009="
			test_string         := "METAR ANYN 272300Z 36005KT 9999 FEW020 BKN100 29/24 Q1011="

			--                                                                                                                          1         1
			--                      0         1         2         3         4         5         6         7         8         9         0         1
			--                      012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
			test_string         := "METAR LOXT 081250Z 24017KT 8000 -RA FEW012ST BKN018ST OVC040SC FEW040TCU 15/14 Q1008 TEMPO RA RMK TCU N/ OVC="
			stored_grammar_file := "/home/buck/dev/eiffel/adsb_service/metar/stored_metar_grammar"
			grammar_file        := "/home/buck/dev/eiffel/adsb_service/metar/metar_grammar_original"
			metar_example_file  := "/home/buck/dev/eiffel/adsb_service/metar/metar_example"
			create wind_dir.make_empty
			create wind_speed_unit.make_empty
			create runway_code.make_empty
			create tendency.make_empty
			create visual_range_unit.make_empty
			make_scanning
			distinguish_case
			keywords_distinguish_case

			build (stored_grammar_file, grammar_file)

			analyze (metar_example_file)
		end

feature {NONE} -- Token types

    unknown:               INTEGER = -1
	start_tag:	           INTEGER =  1
	wind:                  INTEGER =  2
	wind_spanning:         INTEGER =  3
	runway_visual_range:   INTEGER =  4
	present_weather:       INTEGER =  5
	sky_cover:             INTEGER =  6
	temperature_dew_point: INTEGER =  7
	altimeter_setting:     INTEGER =  8
	nosig:                 INTEGER =  9
	runway_condition:      INTEGER = 10
	cavok:                 INTEGER = 11
	trend_forecast:        INTEGER = 12
	supplementary_info:    INTEGER = 13
	--airport_icao:          INTEGER = 14
	issuance_time:         INTEGER = 14
	prevailing_visibility: INTEGER = 15

	is_last:               BOOLEAN

feature -- From {SCANNING}

	begin_analysis
			-- Initialize lexical analysis.
			-- This default version of the procedure
			-- simply prints header information.
			-- It may be redefined in descendants
			-- for specific processing.
		do
			--debug ("lex_output")
				io.new_line
				io.new_line
				io.put_string ("--------------- LEXICAL ANALYSIS: ----")
				io.new_line
				io.new_line
			--end
		end

	end_analysis
			-- Terminate lexical analysis.
			-- This default version of the procedure
			-- does nothing.
			-- It may be redefined in descendants
			-- for specific processing.
		do
			--debug ("lex_output")
				io.new_line
				io.new_line
				io.put_string ("--------------- LEXICAL ANALYSIS: ENDED")
				io.new_line
				io.new_line
			--end
		end

	do_message_type_token (token: TOKEN)
			-- Handle message start tag
		do
			if token.string_value.is_equal (metar_message_type) then
				io.put_string (metar_type_description)
			elseif token.string_value.is_equal (speci_message_type) then
				io.put_string (speci_type_description)
			elseif token.string_value.is_equal (auto_message_type) then
				io.put_string (auto_type_description)
			else
				io.put_string (unknown_type_description)
			end
			io.put_new_line
		end

--	do_airport_icao_token (token: TOKEN)
--			  --
--		do
--			io.put_string ("Airport ICAO: " + token.string_value)
--			io.put_new_line
--		end

	do_issuance_time_token (token: TOKEN)
			--
		local
			-- timestamp
			day_of_month:               INTEGER
			hour:                       INTEGER
			minute:                     INTEGER
			is_zulu:                    BOOLEAN
		do
			day_of_month := token.string_value.substring (1, 2).to_integer
			hour         := token.string_value.substring (3, 4).to_integer
			minute       := token.string_value.substring (5, 6).to_integer
			if token.string_value.tail (1).is_equal ("Z") then
				is_zulu := True
			end
			io.put_string ("Day of month: " + day_of_month.out)
			io.put_new_line
			io.put_string ("Hour:         " + hour.out)
			io.put_new_line
			io.put_string ("Minute:       " + minute.out)
			io.put_new_line
			io.put_string ("ZULU time:    " + is_zulu.out)
			io.put_new_line
		end

	do_wind_token (token: TOKEN)
			--
		do
			if token.string_value.has ('G') then
				wind_gust := True
			end
			wind_dir         := token.string_value.substring (1, 3)
			wind_speed       := token.string_value.substring (4, 5).to_integer
			if wind_gust then
				-- 18012G22KT 150V240
				if token.string_value.substring (7, 9).is_integer then
					wind_gust_speed := token.string_value.substring (7, 9).to_integer
					wind_speed_unit  := token.string_value.substring (10, token.string_value.count)
				else
					wind_gust_speed := token.string_value.substring (7, 8).to_integer
					wind_speed_unit  := token.string_value.substring (9, token.string_value.count)
				end
			else
				wind_speed_unit  := token.string_value.substring (6, token.string_value.count)
			end

			io.put_string ("Wind direction: " + wind_dir)
			io.put_new_line
			io.put_string ("Wind speed:     " + wind_speed.out)
			io.put_new_line
			io.put_string ("Speed unit:     " + wind_speed_unit)
			io.put_new_line
			if wind_gust then
				io.put_string ("Wind gusts at:  " + wind_gust_speed.out)
				io.put_new_line
			end
		end

	do_wind_spanning_token (token: TOKEN)
			--
		do
			wind_spanning_from := token.string_value.substring (1, 3).to_integer
			wind_spanning_to   := token.string_value.substring (5, 7).to_integer
			io.put_string ("Wind direction from: " + wind_spanning_from.out + " degrees")
			io.put_new_line
			io.put_string ("Wind direction to:   " + wind_spanning_to.out + " degrees")
			io.put_new_line
		end

	do_prevailing_visibility_token (token: TOKEN)
			--
		do
			io.put_string ("Prevailing visibility: ")
			if token.string_value.is_equal ("9999") then
				io.put_string ("10 kilometers visibility or greater")
			else
				io.put_string (token.string_value)
			end
			io.put_new_line
		end

	do_runway_visual_range_token (token: TOKEN)
			--
		local
			variability: BOOLEAN
		do
			if token.string_value.has ('L') or token.string_value.has ('R') or token.string_value.has ('C') then
				runway_code    := token.string_value.substring (2, 4)
				visual_range   := token.string_value.substring (7, 10).to_integer
			else
				runway_code    := token.string_value.substring (2, 3)
				visual_range   := token.string_value.substring (6, 9).to_integer
			end
			if token.string_value.has_substring ("FT") then
				visual_range_unit := "FT"
			elseif token.string_value.has ('M') then
				visual_range_unit := "M"
			end
			if token.string_value.has ('V') then
				variability := True
			end
			tendency         := token.string_value.tail (1)

			io.put_string ("Runway_code:   " + runway_code)
			io.put_new_line
			io.put_string ("Visual range:  " + visual_range.out + " m")
			io.put_new_line
			if variability then
				io.put_string ("Variability with ")
			end
			io.put_string ("tendency: " + tendency)
			io.put_new_line
		end

	do_present_weather (token: TOKEN)
			--
		local
			intensity:       STRING
			presence:        BOOLEAN
			descriptor:      STRING
			phenomenon:      STRING
		do
			--snow_presence := True
			if token.string_value.has ('+') then
				intensity := "Heavy"
			elseif token.string_value.has ('-') then
				intensity := "Light"
			elseif token.string_value.has_substring ("VC") then
				intensity := "Vicinity"
			else
				intensity := "Moderate"
			end

			-- descriptor
			--"BC" | "BL" | "DR" | "FZ" | "MI" | "PR" | "SH" | "TS"
			if token.string_value.has_substring ("BC") then
				descriptor := "Patches"
			elseif token.string_value.has_substring ("BL") then
				descriptor := "Blowing"
			elseif token.string_value.has_substring ("DR") then
				descriptor := "Low drifting"
			elseif token.string_value.has_substring ("FZ") then
				descriptor := "Freezing"
			elseif token.string_value.has_substring ("MI") then
				descriptor := "Shallow"
			elseif token.string_value.has_substring ("PR") then
				descriptor := "Partial"
			elseif token.string_value.has_substring ("SH") then
				descriptor := "Shower(s)"
			elseif token.string_value.has_substring ("TS") then
				descriptor := "Thunderstorm"
			end

			-- phenomenon
			-- ["DZ" | "GR" | "GS" | "IC" | "PL" | "RA" | "SG" | "SN" | "UP"])(["BR" | "DU" | "FG" | "FU" | "HZ" | "SA" | "VA"]) (["DS" | "FC" | "PO" | "SQ" | "SS"])
			if token.string_value.has_substring ("DZ") then
				phenomenon := "Drizzle"
			elseif token.string_value.has_substring ("GR") then
				phenomenon := "Hail"
			elseif token.string_value.has_substring ("GS") then
				phenomenon := "Small Hail and/or Snow pellets"
			elseif token.string_value.has_substring ("IC") then
				phenomenon := "Ice crystals"
			elseif token.string_value.has_substring ("PL") then
				phenomenon := "Ice pellets"
			elseif token.string_value.has_substring ("RA") then
				phenomenon := "Rain"
			elseif token.string_value.has_substring ("SG") then
				phenomenon := "Snow grains"
			elseif token.string_value.has_substring ("SN") then
				phenomenon := "Snow"
			elseif token.string_value.has_substring ("UP") then
				phenomenon := "Unknown precipitation"
			elseif token.string_value.has_substring ("BR") then
				phenomenon := "Mist"
			elseif token.string_value.has_substring ("DU") then
				phenomenon := "Widespread dust"
			elseif token.string_value.has_substring ("FG") then
				phenomenon := "Fog"
			elseif token.string_value.has_substring ("FU") then
				phenomenon := "Smoke"
			elseif token.string_value.has_substring ("HZ") then
				phenomenon := "Haze"
			elseif token.string_value.has_substring ("SA") then
				phenomenon := "Sand"
			elseif token.string_value.has_substring ("VA") then
				phenomenon := "Volcanic ash"
			elseif token.string_value.has_substring ("DS") then
				phenomenon := "Duststorm"
			elseif token.string_value.has_substring ("FC") then
				phenomenon := "Funnel clouds"
			elseif token.string_value.has_substring ("PO") then
				phenomenon := "Dust/Sand whirls"
			elseif token.string_value.has_substring ("SQ") then
				phenomenon := "Squall(s)"
			elseif token.string_value.has_substring ("SS") then
				phenomenon := "Sandstorm"
			end

			io.put_string (intensity)
			if attached {STRING} descriptor as l_d then
				io.put_string (" " + l_d)
			end
			if attached {STRING} phenomenon as l_p then
				io.put_string (" " + l_p)
			end
			io.put_new_line
		end

	do_sky_cover_token (token: TOKEN)
			--
		local
			-- cloud layer
			cl_type:                    STRING
			cloud_ceiling:              INTEGER
			cloud_type:                 STRING
		do
			cl_type       := token.string_value.substring (1, 3)
			-- SKC" | "NCD" | "CLR" | "NSC" | "FEW" | "SCT" | "BKN" | "OVC"
			if cl_type.is_equal ("SKC") then
			    io.put_string ("Sky clear")
			elseif cl_type.is_equal ("NCD") then
				io.put_string ("Nil cloud detected")
			elseif cl_type.is_equal ("CLR") then
				io.put_string ("No clouds below 12000 ft")
			elseif cl_type.is_equal ("NSC") then
				io.put_string ("No significatnt cloud")
			elseif cl_type.is_equal ("FEW") then
				io.put_string ("Few ")
			elseif cl_type.is_equal ("SCT") then
				io.put_string ("Scattered ")
			elseif cl_type.is_equal ("BKN") then
				io.put_string ("Broken ")
			elseif cl_type.is_equal ("OVC") then
				io.put_string ("Overcast ")
			end
			cloud_ceiling := token.string_value.substring (4, 6).to_integer
			if token.string_value.count > 6 then
				cloud_type := token.string_value.substring (7, token.string_value.count)
			else
				cloud_type := ""
			end

			io.put_string ("cloud layer at ")
			io.put_string ((cloud_ceiling * 100).out + " feet")
			if not cloud_type.is_empty then
				io.put_new_line
				if cloud_type.is_equal (cloud_type_cb) then
					io.put_string ("cloud type: " + cloud_type_meaning_cb)
				elseif cloud_type.is_equal (cloud_type_sc) then
					io.put_string ("cloud type: " + cloud_type_meaning_sc)
				elseif cloud_type.is_equal (cloud_type_st) then
					io.put_string ("cloud type: " + cloud_type_meaning_st)
				elseif cloud_type.is_equal (cloud_type_tcu) then
					io.put_string ("cloud type: " + cloud_type_meaning_tcu)
				elseif cloud_type.is_equal (cloud_type_vv) then
					io.put_string ("cloud type: " + cloud_type_meaning_vv)
				else
					io.put_string ("cloud type: " + "unknown")
				end
			end
			io.put_new_line
		end

	do_temperature_token (token: TOKEN)
			--
		local
			-- temperature and dew point
			t_values:                   LIST[STRING]
			saturation_vapour_pressure: DOUBLE
			actual_vapour_pressure:     DOUBLE
		do
			t_values     := token.string_value.split ('/')
			if t_values.at (1).at (1).is_equal ('M') then
				-- temperature is negative
				temperature := t_values.at (1).substring (2,3).to_integer * -1
			else
				temperature := t_values.at (1).to_integer
			end
			if t_values.at (2).at (1).is_equal ('M') then
				-- dew_point is negative
				dew_point := t_values.at (2).substring (2, 3).to_integer * -1
			else
				dew_point := t_values.at (2).to_integer
			end
			io.put_string ("Temperature:      " + temperature.out)
			io.put_new_line
			io.put_string ("Dew point:        " + dew_point.out)
			io.put_new_line

			saturation_vapour_pressure := 6.112 * {DOUBLE_MATH}.exp ((17.67 * temperature) / (temperature + 243.2))
			actual_vapour_pressure     := 6.112 * {DOUBLE_MATH}.exp ((17.67 * dew_point) / (dew_point + 243.2))
			relative_humidity          := actual_vapour_pressure / saturation_vapour_pressure * 100.0
			io.put_string ("Relative humidity " + relative_humidity.out)
			io.put_new_line
		end

	do_altimeter_setting_token (token: TOKEN)
			--
		do
			qnh := token.string_value.at (1).is_equal ('Q')
			if qnh then
				hpa := token.string_value.substring (2, token.string_value.count).to_integer
			elseif token.string_value.at (1).is_equal ('A') then
				hpa := {DOUBLE_MATH}.ceiling (token.string_value.substring (2, token.string_value.count).to_integer * 33.86389).ceiling
			end
			io.put_string ("hPa: " + hpa.out)
			io.put_new_line
		end

	do_nosig_token (token: TOKEN)
			--
		do
			io.put_string ("NOSIG")
			io.put_new_line
		end

	do_runway_condition_token (token: TOKEN)
			--
		local
			coating:                    INTEGER
			covering:                   INTEGER
			thickness:                  STRING
			brake_index:                INTEGER
		do
			if token.string_value.has ('R') or token.string_value.has ('L') or token.string_value.has ('C') then
				runway_code    := token.string_value.substring (1, 3)
				coating        := token.string_value.substring (4, 4).to_integer
				covering       := token.string_value.substring (5, 5).to_integer
				thickness      := token.string_value.substring (6, 7)
				brake_index    := token.string_value.substring (8, 9).to_integer
			else
				runway_code    := token.string_value.substring (1, 2)
				coating        := token.string_value.substring (3, 3).to_integer
				covering       := token.string_value.substring (4, 4).to_integer
				thickness      := token.string_value.substring (5, 6)
				brake_index    := token.string_value.substring (7, 8).to_integer
			end
			io.put_string ("Runway condition: ")
			io.put_new_line
			io.put_string ("Runway code: " + runway_code)
			io.put_new_line
			io.put_string ("Coating:     " + coating.out)
			io.put_new_line
			io.put_string ("Covering:    " + covering.out)
			io.put_new_line
			io.put_string ("Thickness:   " + thickness.out)
			io.put_new_line
			io.put_string ("Brake index: " + brake_index.out)
			io.put_new_line
		end

	do_cavok_token (token: TOKEN)
			--
		do
			io.put_string ("Ceiling and visibiity OK")
			io.put_new_line
		end

	do_trend_forecast_token (token: TOKEN)
			--
		do
			io.put_string ("--------------- TREND/FORECAST SECTION ----")
			io.put_new_line

			if token.string_value.has_substring ("PROB") then
				io.put_string ("With probability ")
				-- TODO read a two digits probability
			elseif token.string_value.has_substring ("BECMG") then
				io.put_string ("Becoming")
			elseif token.string_value.has_substring ("TEMPO") then
				io.put_string ("Temporary condition")
			end
			io.put_new_line
		end

	do_supplementary_info_token (token: TOKEN)
			--
		local
			op_type: STRING
			runway:  STRING
			tk:      STRING
			tkn:     TOKEN
		do
			io.put_string ("--------------- SUPPLEMENTARY INFO SECTION ----")
			io.put_new_line

			if token.string_value.has_substring ("RE") then
				io.put_string ("Recent weather")
			elseif token.string_value.has_substring ("WS") then
				io.put_string ("Windshear")
				-- TODO op type and runway
				if token.string_value.has_substring ("TKOF") then
					op_type := "Take off"
				elseif token.string_value.has_substring ("LDG") then
					op_type := "Landing"
				end
				if attached {STRING} op_type as l_t then
					if l_t.is_equal ("Take off") then
						runway := token.string_value.substring (9, token.string_value.count)
					elseif l_t.is_equal ("Landing") then
						runway := token.string_value.substring (8, token.string_value.count)
					end
					io.put_string (" for " + l_t + "(s)")
				end
				if attached {STRING} runway as l_r then
					io.put_string (" via " + runway)
				end
			elseif token.string_value.has_substring ("RMK") then
				io.put_string ("Remarks")
				create tk.make_empty
				tk.copy (token.string_value)
				if tk.has_substring ("SLP") then
					io.put_string ("Sea level pressure")
					tk.replace_substring_all ("SLP", "")
				end
				if tk.has_substring ("WIND") then
					io.put_string ("Wind conditions for ")
					tk.replace_substring_all ("WIND", "")
				end
				if tk.has_substring ("RWY") then
					io.put_string ("runway")
					tk.replace_substring_all ("RWY", "")
				end

				if attached {LEXICAL} analyzer as l_a then
					from l_a.get_token
					until l_a.last_token.type = -1
					loop

						if l_a.last_token.type /= 0 then
							io.put_string (l_a.last_token.string_value)
							io.put_new_line
						end
						l_a.get_token
					end
				end
			end
			io.put_new_line
		end

	do_a_token (read_token: TOKEN)
			-- Handle `read_token'.
			-- This default version of the procedure
			-- simply prints information on `read_token'.
			-- It may be redefined in descendants
			-- for specific processing.
		local
			type:                       INTEGER
			value:                      STRING
		do
			--debug ("lex_output")
				type  := read_token.type
				value := read_token.string_value
				if read_token.keyword_code /= -1 then
					io.put_string ("Keyword:  ")
					io.put_string (value)
					io.put_string (" Code: ")
					io.put_integer (read_token.keyword_code)
					io.new_line
				elseif type /= 0 then
					if type /= -1 then
						io.put_string ("Token type ")
						io.put_integer (type)
						io.put_string (": ")
						io.put_string (value)
						io.new_line

						if is_last_token (read_token) then
							io.put_string ("This is the last token: " + value)
							io.put_new_line
						end

						inspect type
						when start_tag then
							do_message_type_token (read_token)
						--when airport_icao then
						--	do_airport_icao_token (read_token)
						when issuance_time then
							do_issuance_time_token (read_token)
						when wind then
							do_wind_token (read_token)
						when wind_spanning then
							do_wind_spanning_token (read_token)
						when prevailing_visibility then
							do_prevailing_visibility_token (read_token)
						when runway_visual_range then
							do_runway_visual_range_token (read_token)
						when present_weather then
							do_present_weather (read_token)
						when sky_cover then
							do_sky_cover_token (read_token)
						when temperature_dew_point then
							do_temperature_token (read_token)
						when altimeter_setting then
							do_altimeter_setting_token (read_token)
						when nosig then
							do_nosig_token (read_token)
						when runway_condition then
							do_runway_condition_token (read_token)
						when cavok then
							do_cavok_token (read_token)
						when trend_forecast then
							do_trend_forecast_token (read_token)
						when supplementary_info then
							do_supplementary_info_token (read_token)
						else
							if not is_last and type /= unknown then
								io.put_string ("Unknown METAR token")
								io.put_new_line
							end
						end
						io.put_new_line
					end
				end
			--end
		end

feature -- Status

	is_last_token (token: TOKEN): BOOLEAN
			--
		local
			l_sz: INTEGER
		do
			l_sz := token.string_value.count
			if token.string_value.at (l_sz).is_equal ('=') then
				is_last := True
				token.string_value.remove (l_sz)
				Result := True
			end
		end

feature -- Access

	test_string:          STRING

	grammar_file:         STRING
	stored_grammar_file:  STRING
	metar_example_file:   STRING

	temperature:          INTEGER
	dew_point:            INTEGER
	wind_dir:             STRING
	wind_speed:           INTEGER
	wind_speed_unit:      STRING
	wind_gust:            BOOLEAN
	wind_gust_speed:      INTEGER
	wind_spanning_from:   INTEGER
	wind_spanning_to:     INTEGER
	runway_code:          STRING
	visual_range:         INTEGER
	visual_range_unit:    STRING
	tendency:             STRING

	qnh:                  BOOLEAN
	hpa:                  INTEGER
	relative_humidity:    DOUBLE

end
