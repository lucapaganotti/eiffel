note
	description: "Summary description for {SBS_MSG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SBS_MSG

inherit
	SBS_MSG_CONSTANTS

		redefine
			out
		end

create
	make, make_from_string

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create format_double.make (10, 5)
				--create type.make_empty
				--create addr.make_empty
				--create timestamp_gen.make_now
				--create timestamp_log.make_now
				--create callsign.make_empty
		end

	make_from_string (txt: detachable STRING)
			--
		local
			l_fields: LIST [STRING]
		do
			create format_double.make (10, 5)

			if attached {STRING} txt as l_txt then
				l_fields := l_txt.split (',')

				if attached {STRING} l_fields.at (1) as l_mt then
					type := l_mt

					if l_mt.is_equal (sbs_msg_type) then

						if attached {STRING} l_fields.at (2) as l_st then
							tx_type := l_st.to_integer
						end

							-- acquire mandatory fields
						if attached {STRING} l_fields.at (3) as l_sid then
							session_id := l_sid.to_integer
						end
						if attached {STRING} l_fields.at (4) as l_aid then
							acft_id := l_aid.to_integer
						end
						if attached {STRING} l_fields.at (5) as l_addr then
							addr := l_addr
						end
						if attached {STRING} l_fields.at (6) as l_fid then
							flight_id := l_fid.to_integer
						end
						if attached {STRING} l_fields.at (7) as l_dtgen and
							attached {STRING} l_fields.at (8) as l_tgen then
							create timestamp_gen.make_from_string (l_dtgen + str_space + l_tgen, sbs1_datetime_format_code)
						end

						if attached {STRING} l_fields.at (9) as l_dtlog and
							attached {STRING} l_fields.at (10) as l_tlog then
							create timestamp_log.make_from_string (l_dtlog + str_space + l_tlog, sbs1_datetime_format_code)
						end

						inspect tx_type
						when sbs_tx_type_identification then
							if attached {STRING} l_fields.at (11) as l_cs then
								callsign := l_cs
							end
						when sbs_tx_type_surface_position then

							if attached {STRING} l_fields.at (13) as l_gs then
								if l_gs.is_double then
									ground_speed := l_gs.to_double
								else
									ground_speed := 0.0
								end

							end
							if attached {STRING} l_fields.at (14) as l_trk then
								if l_trk.is_double then
									track_angle := l_trk.to_double
								else
									track_angle := 0.0
								end
							end
							if attached {STRING} l_fields.at (15) as l_lat then
								if l_lat.is_double then
									latitude := l_lat.to_double
								end
							end
							if attached {STRING} l_fields.at (16) as l_lon then
								if l_lon.is_double then
									longitude := l_lon.to_double
								end
							end
							if attached {STRING} l_fields.at (12) as l_alt then
								if l_alt.is_integer then
									altitude := l_alt.to_integer
								end
							end
							if attached {STRING} l_fields.at (22) as l_og then
								if l_og.is_integer then
									on_ground := l_og.to_integer
								else
									on_ground := 0
								end

							end
						when sbs_tx_type_airborne_position then

							if attached {STRING} l_fields.at (15) as l_lat then
								if l_lat.is_double then
									latitude := l_lat.to_double
								end
							end
							if attached {STRING} l_fields.at (16) as l_lon then
								if l_lon.is_double then
									longitude := l_lon.to_double
								end
							end
							if attached {STRING} l_fields.at (12) as l_alt then
								if l_alt.is_integer then
									altitude := l_alt.to_integer
								end
							end
							if attached {STRING} l_fields.at (19) as l_alrt then
								if l_alrt.is_integer then
									alert := l_alrt.to_integer
								else
									alert := 0
								end
							end
							if attached {STRING} l_fields.at (20) as l_emg then
								if l_emg.is_integer then
									emergency := l_emg.to_integer
								else
									emergency := 0
								end
							end
							if attached {STRING} l_fields.at (21) as l_spi then
								if l_spi.is_integer then
									spi := l_spi.to_integer
								else
									spi := 0
								end
							end
							if attached {STRING} l_fields.at (22) as l_og then
								if l_og.is_integer then
									on_ground := l_og.to_integer
								else
									on_ground := 0
								end

							end
						when sbs_tx_type_velocity then
							if attached {STRING} l_fields.at (13) as l_gs then
								if l_gs.is_double then
									ground_speed := l_gs.to_double
								else
									ground_speed := 0.0
								end
							end
							if attached {STRING} l_fields.at (14) as l_trk then
								if l_trk.is_double then
									track_angle := l_trk.to_double
								else
									track_angle := 0.0;
								end
							end
							if attached {STRING} l_fields.at (17) as l_vr then
								if l_vr.is_integer then
									vertical_rate := l_vr.to_integer
								else
									vertical_rate := 0
								end
							end
						when sbs_tx_type_surveillance_alt then
								-- not implemented
						when sbs_tx_type_surveillance_id then
								-- not implemented
						when sbs_tx_type_air_to_air then
								-- not implemented
						when sbs_tx_type_all_call_reply then
								-- not implemented
						else

						end

					end

				end

			end
		end

feature -- classification

	is_identification: BOOLEAN
			--
		do
			Result := tx_type = sbs_tx_type_identification
		end

	is_surface_position: BOOLEAN
			--
		do
			Result := tx_type = sbs_tx_type_surface_position
		end

	is_airborne_position: BOOLEAN
			--
		do
			Result := tx_type = sbs_tx_type_airborne_position
		end

	is_velocity: BOOLEAN
			--
		do
			Result := tx_type = sbs_tx_type_velocity
		end

feature {NONE} -- IO

	out: STRING
			--
		local
			l_na: STRING
		do
			create Result.make_empty

			if attached {STRING} type as l_t then
				Result.append (l_t)
			else
				Result.append (not_assigned)
			end
			Result.append (str_space)

			Result.append (tx_type.out)
			Result.append (str_space)

			if attached {STRING} addr as l_addr then
				Result.append (l_addr)
			else
				Result.append (not_assigned)
			end
			Result.append (str_space)

			if attached {DATE_TIME} timestamp_gen as l_dtgen then
				Result.append (l_dtgen.formatted_out (sbs1_datetime_format_code))
			else
				Result.append (not_assigned)
				Result.append (str_space)
			end
			Result.append (str_space)

			if attached {DATE_TIME} timestamp_log as l_dtlog then
				Result.append (l_dtlog.formatted_out (sbs1_datetime_format_code))
			else
				Result.append (not_assigned)
			end
			Result.append (str_space)

			if attached {STRING} callsign as l_cs then
				l_cs.resize (8)
				l_cs.right_justify
				Result.append (l_cs)
			else
				create l_na.make_empty
				l_na.resize (6)
				l_na.fill_blank
				l_na.append (not_assigned)
				l_na.right_justify
				Result.append (l_na)

			end
			Result.append (str_space)

			Result.append (format_double.formatted (ground_speed))
			Result.append (str_space)

			Result.append (format_double.formatted (track_angle))
			Result.append (str_space)

			Result.append (format_double.formatted (longitude))
			Result.append (str_space)

			Result.append (format_double.formatted (latitude))
			Result.append (str_space)

			Result.append (altitude.out)
			Result.append (str_space)

			Result.append (on_ground.out)
		end

feature -- Attributes

	type: detachable STRING
	tx_type: INTEGER
	session_id: INTEGER
	acft_id: INTEGER
	addr: detachable STRING
	flight_id: INTEGER
	timestamp_gen: detachable DATE_TIME
	timestamp_log: detachable DATE_TIME
	callsign: detachable STRING
	altitude: INTEGER
	ground_speed: DOUBLE
	track_angle: DOUBLE
	latitude: DOUBLE
	longitude: DOUBLE
	vertical_rate: INTEGER
	squawk: INTEGER
	alert: INTEGER
	emergency: INTEGER
	spi: INTEGER
	on_ground: INTEGER

	format_double: FORMAT_DOUBLE

end
