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

	make_client (h, ra, tp: STRING l: LOG_LOGGING_FACILITY)
			-- Initialization for `Current'.
		require
			h_ra_attached: attached h and attached ra
		do
			create now.make_now_utc
			create last_check.make_now_utc
			create last_msg.make_now_utc
			create format_double.make (10, 2)
			ref_arpt := ra
			tracks_path := tp
			create dump_file.build (make_dump_file_name (now))

			host := h
			logger := l
		end

feature -- Output

	make_dump_file_name (t: DATE_TIME): STRING
			--
		do
			Result := tracks_path + "/" + ref_arpt + "-" + now.formatted_out ("yyyy[0]mm[0]dd") + ".dump.sbs"
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
						last_check := create {DATE_TIME}.make_now_utc
						last_msg   := create {DATE_TIME}.make_now_utc
					else
						logger.write_error ("{ADSB_SBS_CLIENT}.start unable to connect to host: " + host + " on port " + sbs_port.out)
						{EXECUTION_ENVIRONMENT}.sleep (5000000000)
					end
				end
			else
				logger.write_error ("{ADSB_SBS_CLIENT}.start unable to resolve hostname: " + host)
				last_check := create {DATE_TIME}.make_now_utc
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
					create now.make_now_utc
						--if l_sock.exists and then l_sock.is_connected and then l_sock.is_readable and not must_stop then
					if l_sock.exists and then l_sock.is_connected and then l_sock.is_readable then

						l_sock.readline

						if not l_sock.last_string.is_empty then

							l_str_msg := l_sock.last_string
							if not l_str_msg.is_empty then
								last_msg := now
								if last_msg.day /= now.day then
									dump_file.close
									dump_file.set_dt (last_msg)
									dump_file.open_append
								end
								l_str_msg.replace_substring_all ("%R", "")
								dump_file.put_string (l_str_msg)
								dump_file.put_new_line
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

	--msg: detachable SBS_MSG
	sbs_port: INTEGER

feature -- Commands

	set_port (p: INTEGER)
			--
		do
			sbs_port := p
		end

end

