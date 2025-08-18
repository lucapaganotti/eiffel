note
	description: "adsb_dumper application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	ADSB_DUMPER

inherit
	ARGUMENTS_32
	LOG_PRIORITY_CONSTANTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			af: INET_ADDRESS_FACTORY
			tout: INTEGER_64
			sbs_restarts: INTEGER
			raw_restarts: INTEGER
		do
			init_log

			io.put_string ("ADS-B dumper")
			io.put_new_line

			create af

			create host.make_empty
			create adsb_proto.make_empty
			create tracks_path.make_empty
			create ref_arpt.make_empty

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

	run_sbs
			--
		local
			tout: INTEGER_64
		do
			tout := 10000000000

			create sbs_client.make_client (host, ref_arpt, tracks_path, logger)
			if attached {ADSB_SBS_CLIENT} sbs_client as l_sbs_client then
				from
				until false
				loop
					l_sbs_client.set_port (port)
					l_sbs_client.set_timeout (timeout)
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
			create raw_client.make_client (host, port, timeout, logger, tracks_path, ref_arpt)
			if attached {ADSB_RAW_CLIENT} raw_client as l_raw_client then
				from
				until false
				loop

					l_raw_client.set_max_seconds_between_msg (max_seconds_between_msg)
					l_raw_client.start

				end
			else
				logger.write_warning ("{ADSB_SERVICE_APPLICATION}.make Unable to create RAW client")
				tout := 2 * 1000 * 1000000
				{EXECUTION_ENVIRONMENT}.sleep (tout)
			end
		end

feature {NONE} -- Setup

	init_log
			--
		do
			create log_path.make_from_string ("/home/buck/adsb_dumper.log")
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
			refarpt: detachable READABLE_STRING_32
		do
			create prefs_storage.make_with_location ("/home/buck/adsb_dumper.xml")
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
			refarpt := prefs.get_preference_value_direct ("refarpt")

			if attached {READABLE_STRING_32} ph as l_ph and
				attached {READABLE_STRING_32} pp as l_pp and
				attached {READABLE_STRING_32} pap as l_pap and
				attached {READABLE_STRING_32} pt as l_pt and
				attached {READABLE_STRING_32} ptm as l_ptm and
				attached {READABLE_STRING_32} ptp as l_ptp and
				attached {READABLE_STRING_32} refarpt as l_arpt then
				logger.write_information ("host:                    " + l_ph.to_string_8)
				logger.write_information ("port:                    " + l_pp.to_string_8)
				logger.write_information ("adsb protocol:           " + l_pap.to_string_8)
				logger.write_information ("timeout:                 " + l_pt.to_string_8)
				logger.write_information ("max seconds between msg: " + l_ptm.to_string_8)
				logger.write_information ("tracks path:             " + l_ptp.to_string_8)
				logger.write_information ("reference airport:       " + l_arpt.to_string_8)

				host := l_ph.to_string_8
				port := l_pp.to_integer
				adsb_proto := l_pap.to_string_8

				timeout := l_pt.to_integer
				max_seconds_between_msg := l_ptm.to_integer
				tracks_path := l_ptp.to_string_8
				ref_arpt := l_arpt.to_string_8

				Result := true
			else
				io.put_string ("FATAL: preferences file not found")
				io.put_new_line
			end
		end

feature {NONE} -- Access

	host: STRING
	port: INTEGER
	adsb_proto: STRING
	timeout: INTEGER
	max_seconds_between_msg: INTEGER
	tracks_path: STRING

	log_path: PATH
	log_writer: LOG_ROLLING_WRITER_FILE
	logger: LOG_LOGGING_FACILITY

	sbs_client: detachable ADSB_SBS_CLIENT
	raw_client: detachable ADSB_RAW_CLIENT

	prefs_storage: PREFERENCES_STORAGE_XML
	prefs_manager: PREFERENCE_MANAGER
	prefs: PREFERENCES

	ref_arpt: STRING

end
