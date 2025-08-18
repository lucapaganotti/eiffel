note
	description: "adsb_service application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	ADSB_SERVICE_APPLICATION

inherit
	ARGUMENTS_32
	LOG_PRIORITY_CONSTANTS
	CURL_EXTERNALS
	CURL_EASY_EXTERNALS
	CURL_OPT_CONSTANTS
	CURL_CODES

create
	make

feature {NONE} -- Init	ialization

	init_log
			--
		do
			create log_path.make_from_string ("/home/buck/adsb_service.log")
			create log_writer.make_at_location (log_path)
			log_writer.enable_information_log_level
			log_writer.set_max_file_size ((1024 * 1024 * 100).to_natural_64)
			log_writer.set_max_backup_count (5)
			create logger.make
			logger.register_log_writer (log_writer)
		end

	load_preferences: BOOLEAN
			--
		local
				--pf: BASIC_PREFERENCE_FACTORY
			ph: detachable READABLE_STRING_32
			pp: detachable READABLE_STRING_32
			pap: detachable READABLE_STRING_32
			pt: detachable READABLE_STRING_32
			ptm: detachable READABLE_STRING_32
			ptp: detachable READABLE_STRING_32
			pau: detachable READABLE_STRING_32
			pu: detachable READABLE_STRING_32
			pw: detachable READABLE_STRING_32
			pru: detachable READABLE_STRING_32
			pru2: detachable READABLE_STRING_32
			pjlatlon: detachable READABLE_STRING_32
			pjproj: detachable READABLE_STRING_32
			mrtstr: detachable READABLE_STRING_32
			distthres: detachable READABLE_STRING_32
			refarpt: detachable READABLE_STRING_32

			tokens: LIST [STRING]
			mrtbuf: STRING
			tout: INTEGER_64
		do
			create prefs_storage.make_with_location ("/home/buck/adsb_service.xml")
			create prefs.make_with_storage (prefs_storage)
			prefs_manager := prefs.new_manager ("adsb")

				--create pf
				--ph := pf.new_string_preference_value (prefs_manager, "host", "127.0.0.1")
				--pp := pf.new_integer_preference_value (prefs_manager, "port", 30003)
				--prefs.save_preferences

			ph := prefs.get_preference_value_direct ("host")
			pp := prefs.get_preference_value_direct ("port")
			pap := prefs.get_preference_value_direct ("adsbproto")
			pt := prefs.get_preference_value_direct ("timeout")
			ptm := prefs.get_preference_value_direct ("max_seconds_between_msg")
			ptp := prefs.get_preference_value_direct ("trackspath")
			pau := prefs.get_preference_value_direct ("authurl")
			pu := prefs.get_preference_value_direct ("authusr")
			pw := prefs.get_preference_value_direct ("authpwd")
			pru := prefs.get_preference_value_direct ("routesurl")
			pru2 := prefs.get_preference_value_direct ("routesurl2")
			pjlatlon := prefs.get_preference_value_direct ("pj4geo")
			pjproj := prefs.get_preference_value_direct ("pj4proj")
			mrtstr := prefs.get_preference_value_direct ("mrt")
			distthres := prefs.get_preference_value_direct ("distance_threshold")
			refarpt := prefs.get_preference_value_direct ("refarpt")

			if attached {READABLE_STRING_32} ph as l_ph and
				attached {READABLE_STRING_32} pp as l_pp and
				attached {READABLE_STRING_32} pap as l_pap and
				attached {READABLE_STRING_32} pt as l_pt and
				attached {READABLE_STRING_32} ptm as l_ptm and
				attached {READABLE_STRING_32} ptp as l_ptp and
				attached {READABLE_STRING_32} pau as l_pau and
				attached {READABLE_STRING_32} pu as l_pu and
				attached {READABLE_STRING_32} pw as l_pw and
				attached {READABLE_STRING_32} pru as l_pru and
				attached {READABLE_STRING_32} pru2 as l_pru2 and
				attached {READABLE_STRING_32} pjlatlon as l_pjlatlon and
				attached {READABLE_STRING_32} pjproj as l_pjproj and
				attached {READABLE_STRING_32} mrtstr as l_mrtstr and
				attached {READABLE_STRING_32} distthres as l_dist and
				attached {READABLE_STRING_32} refarpt as l_arpt then
				logger.write_information ("host:                    " + l_ph.to_string_8)
				logger.write_information ("port:                    " + l_pp.to_string_8)
				logger.write_information ("adsb protocol:           " + l_pap.to_string_8)
				logger.write_information ("timeout:                 " + l_pt.to_string_8)
				logger.write_information ("max seconds between msg: " + l_ptm.to_string_8)
				logger.write_information ("tracks path:             " + l_ptp.to_string_8)
				logger.write_information ("auth url:                " + l_pau.to_string_8)
				logger.write_information ("auth usr:                " + l_pu.to_string_8)
				logger.write_information ("auth pwd:                ******")
				logger.write_information ("routes url:              " + l_pru.to_string_8)
				logger.write_information ("routes url2:             " + l_pru2.to_string_8)
				logger.write_information ("pj4 geo:                 " + l_pjlatlon.to_string_8)
				logger.write_information ("pj4 proj:                " + l_pjproj.to_string_8)
				logger.write_information ("mrt:                     " + l_mrtstr.to_string_8)
				logger.write_information ("distance threshold:      " + l_dist.to_string_8)
				logger.write_information ("reference airport:       " + l_arpt.to_string_8)

				host := l_ph.to_string_8
				port := l_pp.to_integer
				adsb_proto := l_pap.to_string_8

				timeout := l_pt.to_integer
				max_seconds_between_msg := l_ptm.to_integer
				tracks_path := l_ptp.to_string_8
				auth_url := l_pau.to_string_8
				auth_usr := l_pu.to_string_8
				auth_pwd := l_pw.to_string_8
				routes_url := l_pru.to_string_8
				routes_url2 := l_pru2.to_string_8
				pj4geo := l_pjlatlon.to_string_8
				pj4proj := l_pjproj.to_string_8
				distance_threshold := l_dist.to_integer
				ref_arpt := l_arpt.to_string_8

				mrtbuf := l_mrtstr.to_string_8
				mrtbuf.prune_all ('(')
				mrtbuf.prune_all (')')
				mrtbuf.replace_substring_all ("POINT", "")
				tokens := mrtbuf.to_string_8.split (' ')

				if attached {STRING} tokens.at (1) as l_x and then
					attached {STRING} tokens.at (2) as l_y and then
					attached {STRING} tokens.at (3) as l_z then
					if l_x.is_double then
						mrt.setx (l_x.to_double)
					end
					if l_y.is_double then
						mrt.sety (l_y.to_double)
					end
					if l_z.is_double then
						mrt.setz (l_z.to_double)
					end
				end

				--if not retrieve_auth_token then
				--	logger.write_warning ("{ADSB_SERVICE_APPLICATION}.load_preferences unable to retrieve auth_token, retry in a few seconds")
				--	tout := 10 * 1000 * 1000000
				--	{EXECUTION_ENVIRONMENT}.sleep (tout)
				--end

				Result := true
			else
				io.put_string ("FATAL: preferences file not found")
				io.put_new_line
			end
		end

	make
			-- Run application.
		local
			af: INET_ADDRESS_FACTORY
			tout: INTEGER_64
			sbs_restarts: INTEGER
			raw_restarts: INTEGER
		do
			init_log

			create af

			create host.make_empty
			create adsb_proto.make_empty
			create tracks_path.make_empty

			create auth_url.make_empty
			create auth_usr.make_empty
			create auth_pwd.make_empty
			--create auth_token.make
			create routes_url.make_empty
			create routes_url2.make_empty
			create pj4geo.make_empty
			create pj4proj.make_empty
			create ref_arpt.make_empty
			create mrt.make

			tout := 10000000000

			from
			until not load_preferences
			loop

				from
				until false
				loop
					if attached af.create_from_name (host) as l_peer_address then
						if adsb_proto.is_equal ("SBS") then
							run_sbs
							sbs_restarts := sbs_restarts + 1
							logger.write_warning ("{ADSB_SERVICE_APPLICATION}.make SBS client restarted " + sbs_restarts.out + " times")
						elseif adsb_proto.is_equal ("RAW") then
							run_raw
							raw_restarts := raw_restarts + 1
							logger.write_warning ("{ADSB_SERVICE_APPLICATION}.make RAW client restarted " + raw_restarts.out + " times")
						else
							logger.write_critical ("{ADSB_SERVICE_APPLICATION}.make ADSB protocol " + adsb_proto + " unsupported")
							{EXECUTION_ENVIRONMENT}.sleep (tout)
						end
					else
						logger.write_warning ("{ADSB_SERVICE_APPLICATION}.make Network could be down or host unreachable")
						logger.write_error ("{ADSB_SERVICE_APPLICATION}.make " + af.error_number.out + " - " + af.error)
						{EXECUTION_ENVIRONMENT}.sleep (tout)
					end
				end

				logger.write_warning ("{ADSB_SERVICE_APPLICATION}.make preferences not loaded, retry in a few seconds")
				{EXECUTION_ENVIRONMENT}.sleep (tout)

			end
		end

	retrieve_auth_token: BOOLEAN
			--
		local
			postfields: STRING
			res: INTEGER
			slist: POINTER
			useragent: STRING
			tk: STRING
			data: CURL_STRING
		do
			Result := false

			create tk.make_empty
			create data.make_empty
			create postfields.make_empty
			postfields := "{%"user%": %"" + auth_usr + "%",%"password%": %"" + auth_pwd + "%"}"
			create useragent.make_empty
			useragent := "adsb service"
			if is_api_available then

				curl_handle := init

				if not curl_handle.is_default_pointer then
					setopt_string (curl_handle, curlopt_url, auth_url)
					slist := slist_append (slist, "Accept:")
					slist := slist_append (slist, "Content-Type: application/json")
					setopt_slist (curl_handle, curlopt_httpheader, slist)
					setopt_string (curl_handle, curlopt_postfields, postfields)
					setopt_integer (curl_handle, curlopt_ssl_verifypeer, 0)
					setopt_integer (curl_handle, curlopt_ssl_verifyhost, 0)
					setopt_string (curl_handle, curlopt_useragent, useragent)
					setopt_integer (curl_handle, curlopt_fresh_connect, 1)
					setopt_integer (curl_handle, curlopt_forbid_reuse, 1)
					setopt_integer (curl_handle, curlopt_buffersize, 1024)
					set_write_function (curl_handle)
					setopt_curl_string (curl_handle, curlopt_writedata, data)

					res := perform (curl_handle)

					if res = curle_ok then
						logger.write_information ("auth token request response: " + data)
						tk := data.split (':').at (2)
						tk.prune_all ('"')
						tk.prune_all ('}')
						--auth_token.set_token (tk)
						--auth_token.set_expiry (create {DATE_TIME}.make_now + create {DATE_TIME_DURATION}.make_definite (1, 0, 0, 0))
						--logger.write_information ("auth token: " + auth_token.token + " - " + auth_token.expiry.formatted_out ("yyyy/[0]mm/[0]dd [0]hh:[0]mi:[0]ss.ff3"))
						Result := true
					else
						logger.write_error ("cURL error " + res.out)
					end
				end
			end

			cleanup (curl_handle)
		end

	run_sbs
			--
		local
			tout: INTEGER_64
		do
			tout := 10000000000
			--create sbs_client.make_client (host, port, timeout, logger, tracks_path)
			create sbs_client.make_client (host, logger)
			if attached {ADSB_SBS_CLIENT} sbs_client as l_sbs_client then
				from
				until false
				loop
					l_sbs_client.set_port (port)
					l_sbs_client.set_timeout (timeout)
					--l_sbs_client.set_logger (logger)
					l_sbs_client.set_tracks_path (tracks_path)
					l_sbs_client.set_routes_url (routes_url)
					l_sbs_client.set_routes_url2 (routes_url2)
					l_sbs_client.set_reference_airport (ref_arpt)
					l_sbs_client.set_mrt (mrt)
					l_sbs_client.set_distance_threshold (distance_threshold)
					l_sbs_client.set_max_seconds_between_msg (max_seconds_between_msg)
					l_sbs_client.start
				end
			else
				logger.write_warning ("{ADSB_SERVICE_APPLICATION}.make Unable to create SBS client")
				tout := 2000000000
				{EXECUTION_ENVIRONMENT}.sleep (tout)
			end
		end

	run_raw
			--
		local
			tout: INTEGER_64
		do
			tout := 10000000000
			create raw_client.make_client (host, port, timeout, logger, tracks_path)
			if attached {ADSB_RAW_CLIENT} raw_client as l_raw_client then
				from
				until false
				loop
					--if auth_token.is_expired then
					--	if retrieve_auth_token then
							--l_raw_client.set_auth_token (auth_token)
							l_raw_client.set_routes_url (routes_url)
							l_raw_client.set_reference_airport (ref_arpt)
							l_raw_client.set_mrt (mrt)
							l_raw_client.set_distance_threshold (distance_threshold)
							l_raw_client.set_max_seconds_between_msg (max_seconds_between_msg)
							l_raw_client.start
					--	else
					--		logger.write_warning ("{ADSB_SERVICE_APPLICATION}.make unable to retrieve auth_token, retry in a few seconds")
					--		{EXECUTION_ENVIRONMENT}.sleep (tout)
					--	end
					--else
					--	--l_raw_client.set_auth_token (auth_token)
					--	l_raw_client.set_routes_url (routes_url)
					--	l_raw_client.set_reference_airport (ref_arpt)
					--	l_raw_client.set_mrt (mrt)
					--	l_raw_client.set_distance_threshold (distance_threshold)
					--	l_raw_client.start
					--end
				end
			else
				logger.write_warning ("{ADSB_SERVICE_APPLICATION}.make Unable to create RAW client")
				tout := 2 * 1000 * 1000000
				{EXECUTION_ENVIRONMENT}.sleep (tout)
			end
		end

feature {NONE} -- Access

	host: STRING
	port: INTEGER
	adsb_proto: STRING
	timeout: INTEGER
	max_seconds_between_msg: INTEGER
	tracks_path: STRING
	mrt: POINT
	distance_threshold: INTEGER

	log_path: PATH
	log_writer: LOG_ROLLING_WRITER_FILE
	logger: LOG_LOGGING_FACILITY

	sbs_client: detachable ADSB_SBS_CLIENT
	raw_client: detachable ADSB_RAW_CLIENT

	prefs_storage: PREFERENCES_STORAGE_XML
	prefs_manager: PREFERENCE_MANAGER
	prefs: PREFERENCES

	auth_url: STRING
	auth_usr: STRING
	auth_pwd: STRING
	--auth_token: AUTH_TOKEN
	routes_url: STRING
	routes_url2: STRING
	pj4geo: STRING
	pj4proj: STRING
	ref_arpt: STRING

	curl_handle: POINTER

	metar_data: detachable METAR_DATA
end
