note
	description: "Summary description for {ADSB_RAW_CLIENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ADSB_RAW_CLIENT

inherit
	ADSB_CLIENT

create
	make_client

feature {NONE} -- Initialization

	make_client (h: STRING p, t: INTEGER l: LOG_LOGGING_FACILITY tp: STRING)
			-- Initialization for `Current'.
		local
			af: INET_ADDRESS_FACTORY
		do
			create af
			create now.make_now
			create last_check.make_now
			create last_msg.make_now
			create format_double.make (10, 2)

			create means.make (0)
			host := h
			raw_port := p
			to := t
			logger := l
			tracks_path := tp

			--create auth_token.make
			create routes_url.make_empty
			create routes_url2.make_empty
			create pj4geo.make_empty
			create ref_arpt.make_empty
			create pj4proj.make_empty
			create mrt.make

			if attached af.create_from_name (host) as l_peer_address then
				logger.write_information ("{ADSB_RAW_CLIENT}.make_client " + l_peer_address.out + " reachable")
				if attached {ADSB_NETWORK_STREAM_SOCKET} socket as l_sock then
					logger.write_information ("{ADSB_RAW_CLIENT}.make_client socket " + host + ":" + raw_port.out + " created")
				end
			else
				logger.write_warning ("{ADSB_RAW_CLIENT}.make_client Network could be down or host unreachable")
			end
		end

feature -- Operations

	start
			--
		local
			af: INET_ADDRESS_FACTORY
		do
			logger.write_information ("{ADSB_RAW_CLIENT}.start")
			create af
			if attached af.create_from_name (host) as l_peer_address then
				create socket.make_client_by_address_and_port (l_peer_address, raw_port)
				if attached {ADSB_NETWORK_STREAM_SOCKET} socket as l_sock then
						-- l_sock.set_receive_buf_size (5 * 1024 * 1024)
					l_sock.set_sock_opt_recv_buffer_size (10 * 1024 * 1024)
						-- l_sock.set_linger_on (5)
					l_sock.set_default_timeout
					l_sock.set_recv_timeout_ns (l_sock.one_second_in_nanoseconds)
						--l_sock.enable_debug
					l_sock.set_sock_opt_keep_alive_on
					l_sock.connect
					if l_sock.is_connected then
						running := true
						logger.write_information ("{ADSB_RAW_CLIENT}.start socket " + host + ":" + raw_port.out + " connected")
						process
						stop
						last_check := create {DATE_TIME}.make_now
					else
						logger.write_error ("{ADSB_RAW_CLIENT}.start unable to connect to host: " + host + " on port " + raw_port.out)
						{EXECUTION_ENVIRONMENT}.sleep (5000000000)
					end
				end
			else
				logger.write_error ("{ADSB_RAW_CLIENT}.start unable to resolve hostname: " + host)
				last_check := create {DATE_TIME}.make_now
				{EXECUTION_ENVIRONMENT}.sleep (10000000000)
			end
		end

	stop
			--
		do
			logger.write_information ("{ADSB_RAW_CLIENT}.stop")
			if attached {ADSB_NETWORK_STREAM_SOCKET} socket as l_sock then
				l_sock.cleanup
				l_sock.dispose
				logger.write_information ("{ADSB_RAW_CLIENT}.stop socket disposed")
			end
			running := false
		end

	process
			--
		local
				-- l_m:       MEAN
				-- l_pos:     POSITION
			l_delta_t: INTERVAL [DATE_TIME]
			l_msg_delta_t: INTERVAL [DATE_TIME]
				-- d:         DOUBLE
				-- res:       INTEGER
			l_str_msg: STRING
		do
			logger.write_information ("{ADSB_RAW_CLIENT}.process")
			if attached {ADSB_NETWORK_STREAM_SOCKET} socket as l_sock then
				logger.write_information ("{ADSB_RAW_CLIENT}.process begins acquisition")
				from
				until not l_sock.exists or not l_sock.is_connected or not running
				loop
					if l_sock.exists and then l_sock.is_connected and then l_sock.is_readable then

						l_sock.read_line

						if not l_sock.last_string.is_empty then

							create now.make_now

							l_str_msg := l_sock.last_string
							if not l_str_msg.is_empty then
								l_str_msg.prune_all_leading ('*')
								l_str_msg.prune_all_trailing (';')
								if l_str_msg.count = {RAW_MSG_CONSTANTS}.short_hex_msg_length or l_str_msg.count = {RAW_MSG_CONSTANTS}.long_hex_msg_length then
									create msg.make_from_string (l_str_msg)
									if attached {RAW_TEXT_MSG} msg as l_msg then
										logger.write_information ("<< [DF" + l_msg.df.out + "] " + l_msg.addr.out)

									end
								end
							end

							if last_check < now then

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

							if last_msg < now then

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

						else
							-- is socket in close_wait
							if l_sock.was_error then
								logger.write_warning ("{ADSB_SBS_CLIENT}.process got an empty string and there was error " + l_sock.error)
								stop
							end
						end
					else
						if l_sock.was_error or l_sock.network or not l_sock.is_connected or not is_endpoint_reachable or l_sock.expired_socket or not l_sock.exists then
							logger.write_warning ("{ADSB_RAW_CLIENT}.process sockect not readable")
							logger.write_warning ("{ADSB_RAW_CLIENT}.process acquisition socket has error " + l_sock.error_number.out + " - " + l_sock.error)
							logger.write_warning ("{ADSB_RAW_CLIENT}.process close and cleanup socket")
							l_sock.cleanup
							l_sock.dispose
						else
							{EXECUTION_ENVIRONMENT}.sleep (500 * 1000000)
						end
					end
				end
			end
		rescue

			logger.write_warning ("{ADSB_RAW_CLIENT}.process Exception " + exception.out + " was triggered")
			if attached {STRING} meaning (exception) as l_e then
				logger.write_information ("{ADSB_RAW_CLIENT}.process %TMeaning: " + l_e)
			end

			if is_developer_exception then
				logger.write_information ("{ADSB_RAW_CLIENT}.process Developer exception")
			elseif is_system_exception then
				logger.write_information ("{ADSB_RAW_CLIENT}.process System exception")
			elseif is_signal then
				logger.write_information ("{ADSB_RAW_CLIENT}.process Caught signal")
			end

			if attached {ADSB_NETWORK_STREAM_SOCKET} socket as l_sock then
					-- if l_sock.was_error then
				logger.write_warning ("{ADSB_RAW_CLIENT}.process acquisition socket has some error, try a restart")
				logger.write_warning ("{ADSB_RAW_CLIENT}.process acquisition socket has error " + l_sock.error_number.out + " - " + l_sock.error)
				logger.write_warning ("{ADSB_RAW_CLIENT}.process close and cleanup socket")
				stop
				{EXECUTION_ENVIRONMENT}.sleep (500 * 1000000)
					-- end
			else
				logger.write_error ("{ADSB_RAW_CLIENT}.process socket is a bad state, quit processing")
				stop
			end
			logger.write_warning ("{ADSB_RAW_CLIENT}.process retry")
			retry
		end

feature -- Access

	msg: detachable RAW_TEXT_MSG
	raw_port: INTEGER

feature -- Commands

	set_port (p: INTEGER)
			--
		do
			raw_port := p
		end

end
