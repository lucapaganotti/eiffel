note
	description: "Summary description for {ADSB_SBS_CLIENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ADSB_SBS_CLIENT

inherit
	ADSB_CLIENT
	SOCKET_RESOURCES

create
	make

feature {NONE} -- Initialization

	make (h: STRING p, t: INTEGER l: LOG_LOGGING_FACILITY tp: STRING)
			-- Initialization for `Current'.
		do
			create now.make_now
			create last_check.make_now

			create means.make (0)
			host        := h
			port        := p
			to          := t
			logger      := l
			tracks_path := tp

			create auth_token.make_empty

			create socket.make_client_by_port (port, host)
		end

feature -- Operations

	start
			--
		do
			if attached {NETWORK_STREAM_SOCKET} socket as l_sock then
				l_sock.set_receive_buf_size (1024 * 1024)
				l_sock.connect
				process
			end
		end

	stop
			--
		do
			if attached {NETWORK_STREAM_SOCKET} socket as l_sock then
				l_sock.cleanup
				l_sock.close
			end
		end

	process
			--
		local
			l_m: MEAN
			l_pos: POSITION
			l_delta_t: INTERVAL[DATE_TIME]
		do
			if attached {NETWORK_STREAM_SOCKET} socket as l_sock then
				from
				until false
				loop
					create now.make_now
					l_sock.read_line
					if attached {STRING} l_sock.last_string as l_str_msg then
						create msg.make_from_string (l_str_msg)

						if attached {SBS_MSG} msg as l_msg then
							if attached {STRING} l_msg.addr as l_addr then
								if means.has_key (l_addr) then
										-- update mean data
									l_m := means.at (l_addr)
									if attached {MEAN} l_m as m and attached {STRING} l_msg.callsign as l_cs then
										if l_msg.is_identification then
											m.set_callsign (l_cs)
											logger.write_information (l_addr + " " + l_cs + " IDENTIFICATION")
											m.set_last_logged (now)
										end
									end
									if attached {MEAN} l_m as m then
										if attached {STRING} m.callsign as l_cs then
											if l_msg.is_velocity then
												m.set_ground_speed (l_msg.ground_speed)
												m.set_track_angle (l_msg.track_angle)
												m.set_vertical_rate (l_msg.vertical_rate)
												m.set_last_logged (now)
												if not m.pos.is_empty then
													m.pos.last.set_ground_speed (l_msg.ground_speed)
													m.pos.last.set_track_angle (l_msg.track_angle)
													m.pos.last.set_vertical_rate (l_msg.vertical_rate)
												end
												logger.write_information (l_addr + " " + l_cs + " VELOCITY " + m.ground_speed.out + " " + m.track_angle.out + " " + m.vertical_rate.out)
											elseif l_msg.is_surface_position then
												if l_msg.longitude /= 0.0 and l_msg.latitude /= 0.0 then
													m.set_last_logged (now)
													create l_pos.make_from_coordinates (l_msg.longitude, l_msg.latitude, l_msg.altitude)
													l_pos.set_t (now)
													l_pos.set_on_ground
													m.pos.extend (l_pos)
													logger.write_information (l_addr + " " + l_cs + " SURFACE  " + l_pos.out)
												end
											elseif l_msg.is_airborne_position then
												if l_msg.longitude /= 0.0 and l_msg.latitude /= 0.0 then
													m.set_last_logged (now)
													create l_pos.make_from_coordinates (l_msg.longitude, l_msg.latitude, l_msg.altitude)
													l_pos.set_t (now)
													m.pos.extend (l_pos)
													logger.write_information (l_addr + " " + l_cs + " AIRBORNE " + l_pos.out)
												end
											end
										end
									end
								else
										-- add a new MEAN o map
									create l_m.make (l_addr)
									l_m.set_tracks_path (tracks_path)
									means.extend (l_m, l_addr)
									logger.write_information (l_addr + " NEW MEAN")
								end
							end
						end
					end

					create l_delta_t.make (last_check, now)
					if attached {DATE_TIME_DURATION} l_delta_t.duration as l_d then
						l_d.set_origin_date_time (create {DATE_TIME}.make (1970, 1, 1, 0, 0, 0))
						if l_d.seconds_count > to then
							-- save mean to file
							-- remove mean from map
							clean_map
							last_check := create {DATE_TIME}.make_now
						end
					end
				end
			end
		rescue
			if attached {NETWORK_STREAM_SOCKET} socket as l_sock then
				if not l_sock.is_connected then
					logger.write_error ("{ADSB_SBS_CLIENT}.process error: " + l_sock.error)
					l_sock.cleanup
					l_sock.close
					l_sock.connect
					process
				end
			end
		end

	clean_map
			--
		local
			l_now: DATE_TIME
			l_delta_t: INTERVAL [DATE_TIME]
			l_m: MEAN
		do
			create l_now.make_now
			logger.write_information ("clean map started @ " + l_now.formatted_out ("yyyy/[0]mm/[0]dd [0]hh:[0]mi:[0]ss.ff3") + " " + means.count.out)
			from
				means.start
			until
				means.after
			loop
				l_m := means.item_for_iteration
				create l_delta_t.make (l_m.last_logged, l_now)
				if attached {DATE_TIME_DURATION} l_delta_t.duration as l_d then
					l_d.set_origin_date_time (create {DATE_TIME}.make (1970, 1, 1, 0, 0, 0))
				    if l_d.seconds_count > to then
						-- save mean to file
						logger.write_information ("write " + l_m.addr + " to disk")
						if l_m.write then
							logger.write_information (l_m.addr + " WRITTEN to disk")
						else
							logger.write_error (l_m.addr + " NOT WRITTEN to disk")
						end
						-- remove mean from map
						logger.write_information ("remove " + l_m.addr + " from map")
						means.remove (l_m.addr)
						logger.write_information (l_m.addr + " REMOVED from map")
					end
				end
				means.forth
			end
			create l_now.make_now
			logger.write_information ("clean map finished @ " + l_now.formatted_out ("yyyy/[0]mm/[0]dd [0]hh:[0]mi:[0]ss.ff3") + " " + means.count.out)
		end

feature -- Access

	now:         DATE_TIME
	last_check:  DATE_TIME
	msg:         detachable SBS_MSG
	socket:      detachable NETWORK_STREAM_SOCKET
	means:       HASH_TABLE [MEAN, STRING]
	logger:      LOG_LOGGING_FACILITY
	auth_token:  STRING

feature -- Commands

	set_auth_token (t: STRING)
			--
		do
			auth_token := t
		end

end
