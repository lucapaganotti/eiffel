note
	description: "Summary description for {ADSB_SBS_CLIENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ADSB_SBS_CLIENT

inherit
	ADSB_CLIENT

create
	make_client

feature {NONE} -- Initialization

	--make_client (h: STRING p, t: INTEGER l: LOG_LOGGING_FACILITY tp: STRING)
	make_client (h: STRING l: LOG_LOGGING_FACILITY)
			-- Initialization for `Current'.
		do
			create now.make_now
			create last_check.make_now
			create last_msg.make_now
			create format_double.make (10, 2)

			create means.make (0)
			host := h
			--sbs_port := p
			--to := t
			logger := l
			--tracks_path := tp

			--create auth_token.make
			create routes_url.make_empty
			create routes_url2.make_empty
			create pj4geo.make_empty
			create ref_arpt.make_empty
			create pj4proj.make_empty
			create mrt.make
			create tracks_path.make_empty
		end

feature -- Operations

	start
			--
		local
			af: INET_ADDRESS_FACTORY
		do
			create af

			logger.write_information ("{ADSB_SBS_CLIENT}.start")

			if attached af.create_from_name (host) as l_peer_address then
				create socket.make_client_by_address_and_port (l_peer_address, sbs_port)
				if attached {ADSB_NETWORK_STREAM_SOCKET} socket as l_sock then
						-- l_sock.set_receive_buf_size (1024 * 1024)
					l_sock.set_sock_opt_recv_buffer_size (1024 * 1024)
						-- l_sock.set_linger_on (5)
					l_sock.set_default_timeout
					l_sock.set_recv_timeout_ns (l_sock.one_second_in_nanoseconds)
						--l_sock.enable_debug
					l_sock.set_sock_opt_keep_alive_on
					l_sock.connect
					if l_sock.is_connected then
						running := true
						logger.write_information ("{ADSB_SBS_CLIENT}.start socket " + host + ":" + sbs_port.out + " connected")
						process
						stop
						last_check := create {DATE_TIME}.make_now
						last_msg   := create {DATE_TIME}.make_now
					else
						logger.write_error ("{ADSB_SBS_CLIENT}.start unable to connect to host: " + host + " on port " + sbs_port.out)
						{EXECUTION_ENVIRONMENT}.sleep (5000000000)
					end
				end
			else
				logger.write_error ("{ADSB_SBS_CLIENT}.start unable to resolve hostname: " + host)
				last_check := create {DATE_TIME}.make_now
				{EXECUTION_ENVIRONMENT}.sleep (10000000000)
			end
		end

	stop
			--
		do
			logger.write_information ("{ADSB_SBS_CLIENT}.stop")
			if attached {ADSB_NETWORK_STREAM_SOCKET} socket as l_sock then
				l_sock.cleanup
				l_sock.dispose
				logger.write_information ("{ADSB_SBS_CLIENT}.stop socket disposed")
			end
			running := false
		end

	process
			--
		local
			l_m: MEAN
			l_pos: POSITION
			l_delta_t: INTERVAL [DATE_TIME]
			l_msg_delta_t: INTERVAL [DATE_TIME]
			d: DOUBLE
			res: INTEGER
			l_str_msg: STRING
			l_gendt: STRING
			--must_stop: BOOLEAN
		do
			logger.write_information ("{ADSB_SBS_CLIENT}.process")
			if attached {ADSB_NETWORK_STREAM_SOCKET} socket as l_sock then
				logger.write_information ("{ADSB_SBS_CLIENT}.process begins acquisition")
				from
						--until l_sock.was_error or auth_token.is_expired or not is_endpoint_reachable or l_sock.expired_socket or not l_sock.exists
				until not l_sock.exists or not l_sock.is_connected or not running
				loop
					create now.make_now
						--if l_sock.exists and then l_sock.is_connected and then l_sock.is_readable and not must_stop then
					if l_sock.exists and then l_sock.is_connected and then l_sock.is_readable then

						l_sock.readline

						if not l_sock.last_string.is_empty then

							l_str_msg := l_sock.last_string
							if not l_str_msg.is_empty then

								create msg.make_from_string (l_str_msg)

								if attached {SBS_MSG} msg as l_msg and then l_msg.is_valid then

									last_msg := now

									if attached {STRING} l_msg.addr as l_addr then
										if attached {DATE_TIME} l_msg.timestamp_gen as l_gen then
											l_gendt := l_gen.formatted_out ({SBS_MSG_CONSTANTS}.sbs1_datetime_format_code)
										else
											l_gendt := now.formatted_out ({SBS_MSG_CONSTANTS}.sbs1_datetime_format_code)
										end
										if means.has_key (l_addr) then
												-- update mean data
											l_m := means.at (l_addr)
											if attached {MEAN} l_m as m and attached {STRING} l_msg.callsign as l_cs and then l_msg.is_identification then
												m.set_callsign (l_cs)
												m.set_last_logged (now)
												l_m.retrieve_route
												logger.write_information (l_m.out)
											end
											if attached {MEAN} l_m as m then
												m.scan
												m.set_last_logged (now)
												if attached {STRING} m.callsign as l_cs then
													if l_msg.is_velocity then
														m.set_ground_speed (l_msg.ground_speed)
														m.set_track_angle (l_msg.track_angle)
														m.set_vertical_rate (l_msg.vertical_rate)

														if not m.pos.is_empty then
															m.pos.last.set_ground_speed (l_msg.ground_speed)
															m.pos.last.set_track_angle (l_msg.track_angle)
															m.pos.last.set_vertical_rate (l_msg.vertical_rate)
														end
														logger.write_information (l_gendt + " " + l_addr + " " + l_cs + " VELOCITY " + format_double.formatted (m.ground_speed) + " " +
															format_double.formatted (m.track_angle) + " " + format_double.formatted (m.vertical_rate))
													elseif l_msg.is_surface_position then
														if l_msg.longitude /= 0.0 and l_msg.latitude /= 0.0 then

															create l_pos.make_from_coordinates (l_msg.longitude, l_msg.latitude, l_msg.altitude)
															l_pos.set_t (now)
															l_pos.set_on_ground
															res := l_pos.transform (pj4geo, pj4proj)
															d := l_pos.to_point.distance (mrt, false)
															if d <= distance_threshold then
																logger.write_information (l_gendt + " " + l_addr + " " + l_cs + " SURFACE  " + l_pos.out)
																m.pos.extend (l_pos)
															end
															res := l_pos.transform (pj4proj, pj4geo)
														end
														m.on_ground := l_msg.on_ground /= 0
													elseif l_msg.is_airborne_position then
														if l_msg.longitude /= 0.0 and l_msg.latitude /= 0.0 then

															create l_pos.make_from_coordinates (l_msg.longitude, l_msg.latitude, l_msg.altitude)
															l_pos.set_t (now)
															res := l_pos.transform (pj4geo, pj4proj)
															d := l_pos.to_point.distance (mrt, false)
															if d <= distance_threshold then
																logger.write_information (l_gendt + " " + l_addr + " " + l_cs + " AIRBORNE " + l_pos.out)
																m.pos.extend (l_pos)
															end
															res := l_pos.transform (pj4proj, pj4geo)
															if l_msg.emergency /= 0 then
																m.emergency := l_msg.emergency
															end
														end
														if l_msg.alert /= 0 then
															m.alerted := l_msg.alert
														end
														if l_msg.spi /= 0 and then not m.transponder.activated then
															m.transponder.activate (create {DATE_TIME}.make_now)
														end
														m.on_ground := l_msg.on_ground /= 0
													elseif l_msg.is_surveillance_alt then

														if l_msg.altitude /= 0 and then m.pos.count > 0 then
															m.pos.last.setz (l_msg.altitude)
														end
														if l_msg.alert /= 0 then
															m.alerted := l_msg.alert
														end
														if l_msg.spi /= 0 and then not m.transponder.activated then
															m.transponder.activate (create {DATE_TIME}.make_now)
														end
														m.on_ground := l_msg.on_ground /= 0
														if l_msg.emergency /= 0 then
															m.emergency := l_msg.emergency
														end
														logger.write_information (l_gendt + " " + l_addr + " " + l_cs + " SURVEILLANCE ALTITUDE " + l_msg.altitude.out)
													elseif l_msg.is_surveillance_id then

														if l_msg.squawk /= 0 then
															m.squawk := l_msg.squawk
														end
														if l_msg.alert /= 0 then
															m.alerted := l_msg.alert
														end
														if l_msg.spi /= 0 and then not m.transponder.activated then
															m.transponder.activate (create {DATE_TIME}.make_now)
														end
														m.on_ground := l_msg.on_ground /= 0
														logger.write_information (l_gendt + " " + l_addr + " " + l_cs + " SURVEILLANCE ID " + m.squawk.out)
													elseif l_msg.is_air_to_air then
														m.on_ground := l_msg.on_ground /= 0
														logger.write_information (l_gendt + " " + l_addr + " " + l_cs + " AIR TO AIR ")
													elseif l_msg.is_all_call_reply then
														m.on_ground := l_msg.on_ground /= 0
														logger.write_information (l_gendt + " " + l_addr + " " + l_cs + " ALL CALL REPLY ")
													end
												end
											end
										else
												-- add a new MEAN o map
											create l_m.make (l_addr)
											--l_m.set_auth_token (auth_token)
											l_m.set_tracks_path (tracks_path)
											l_m.set_routes_url (routes_url)
											l_m.set_routes_url2 (routes_url2)
											l_m.set_reference_airport (ref_arpt)
											means.extend (l_m, l_addr)
											logger.write_information (l_gendt + " " + l_addr + " NEW MEAN")
										end
									end
								else
									logger.write_warning ("{ADSB_SBS_CLIENT}.process received NOT VALID SBS message")
									logger.write_information ("%T{ADSB_SBS_CLIENT}.process " + l_str_msg)
									{EXECUTION_ENVIRONMENT}.sleep (100 * 1000000)
								end
							else
								l_str_msg := l_sock.last_string
							end

							if now > last_check then
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
						else
							-- is socket in close_wait
							if l_sock.was_error then
								logger.write_warning ("{ADSB_SBS_CLIENT}.process got an empty string and there was error " + l_sock.error)
								stop
							else
								logger.write_information ("{ADSB_SBS_CLIENT}.process socket is readable but no data on it")
								{EXECUTION_ENVIRONMENT}.sleep (500 * 1000000)
							end
						end
					else
						if l_sock.was_error or l_sock.network or not l_sock.is_connected or not is_endpoint_reachable or l_sock.expired_socket or not l_sock.exists then
							logger.write_warning ("{ADSB_SBS_CLIENT}.process socket not readable")
							logger.write_warning ("{ADSB_SBS_CLIENT}.process acquisition socket has error " + l_sock.error_number.out + " - " + l_sock.error)
							logger.write_warning ("{ADSB_SBS_CLIENT}.process close and cleanup socket")
							stop
						else
							logger.write_debug ("{ADSB_SBS_CLIENT}.process socket not readable")
							{EXECUTION_ENVIRONMENT}.sleep (100 * 1000000)
						end
					end

					if now > last_msg then
						create l_msg_delta_t.make (last_msg, now)
						if attached {DATE_TIME_DURATION} l_msg_delta_t.duration as l_d then
							l_d.set_origin_date_time (create {DATE_TIME}.make (1970, 1, 1, 0, 0, 0))
							if l_d.seconds_count > max_seconds_between_msg then
									-- silence for at least max_seconds_between_msg
									-- try an acquisition restart
								logger.write_warning ("MSG silence for " + l_d.seconds_count.out + " seconds, try a restart")
								stop
							end
						end
					end
				end
			end

		rescue

			logger.write_warning ("{ADSB_SBS_CLIENT}.process Exception " + exception.out + " was triggered")
			if attached {STRING} meaning (exception) as l_e then
				logger.write_information ("{ADSB_SBS_CLIENT}.process %TMeaning: " + l_e)
			end

			if is_developer_exception then
				logger.write_information ("{ADSB_SBS_CLIENT}.process Developer exception")
			elseif is_system_exception then
				logger.write_information ("{ADSB_SBS_CLIENT}.process System exception")
			elseif is_signal then
				logger.write_information ("{ADSB_SBS_CLIENT}.process Caught signal")
			end

			if attached {ADSB_NETWORK_STREAM_SOCKET} socket as l_sock then
					-- if l_sock.was_error then
				logger.write_warning ("{ADSB_SBS_CLIENT}.process acquisition socket has some error, try a restart")
				logger.write_warning ("{ADSB_SBS_CLIENT}.process acquisition socket has error " + l_sock.error_number.out + " - " + l_sock.error)
				logger.write_warning ("{ADSB_SBS_CLIENT}.process close and cleanup socket")
				stop
				{EXECUTION_ENVIRONMENT}.sleep (500 * 1000000)
					-- end
			else
				logger.write_error ("{ADSB_SBS_CLIENT}.process socket is a bad state, quit processing")
				stop
			end
			logger.write_warning ("{ADSB_SBS_CLIENT}.process retry")
			retry
		end

feature -- Access

	msg: detachable SBS_MSG
	sbs_port: INTEGER

feature -- Commands

	set_port (p: INTEGER)
			--
		do
			sbs_port := p
		end

end
