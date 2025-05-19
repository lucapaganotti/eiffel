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

feature {NONE} -- Initialization

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

	make
			-- Run application.
		local
			--pf: BASIC_PREFERENCE_FACTORY
			ph:  detachable READABLE_STRING_32
			pp:  detachable READABLE_STRING_32
			pt:  detachable READABLE_STRING_32
			ptp: detachable READABLE_STRING_32
			pau: detachable READABLE_STRING_32
			pu:  detachable READABLE_STRING_32
			pw: detachable READABLE_STRING_32
		do
			init_log

			create auth_url.make_empty
			create auth_usr.make_empty
			create auth_pwd.make_empty

			create prefs_storage.make_with_location ("/home/buck/adsb_service.xml")
			create prefs.make_with_storage (prefs_storage)
			prefs_manager := prefs.new_manager ("adsb")
			--create pf
			--ph := pf.new_string_preference_value (prefs_manager, "host", "127.0.0.1")
			--pp := pf.new_integer_preference_value (prefs_manager, "port", 30003)
			--prefs.save_preferences

			ph  := prefs.get_preference_value_direct ("host")
			pp  := prefs.get_preference_value_direct ("port")
			pt  := prefs.get_preference_value_direct ("timeout")
			ptp := prefs.get_preference_value_direct ("trackspath")
			pau := prefs.get_preference_value_direct ("authurl")
			pu  := prefs.get_preference_value_direct ("authusr")
			pw  := prefs.get_preference_value_direct ("authpwd")

			if attached {READABLE_STRING_32} ph  as l_ph  and
			   attached {READABLE_STRING_32} pp  as l_pp  and
			   attached {READABLE_STRING_32} pt  as l_pt  and
			   attached {READABLE_STRING_32} ptp as l_ptp and
			   attached {READABLE_STRING_32} pau as l_pau and
			   attached {READABLE_STRING_32} pu  as l_pu  and
			   attached {READABLE_STRING_32} pw  as l_pw  then
			   	logger.write_information ("host:        " + l_ph)
			   	logger.write_information ("port:        " + l_pp)
			   	logger.write_information ("timeout:     " + l_pt)
			   	logger.write_information ("tracks path: " + l_ptp)
			   	logger.write_information ("auth url:    " + l_pau)
			   	logger.write_information ("auth usr:    " + l_pu)
			   	logger.write_information ("auth pwd:    ******")

			   	auth_url := l_pau
			   	auth_usr := l_pu
			   	auth_pwd := l_pw

				create sbs_client.make (l_ph, l_pp.to_integer, l_pt.to_integer, logger, l_ptp)
				if attached {ADSB_SBS_CLIENT} sbs_client as l_sbs_client then
					l_sbs_client.start
				end

			else
				io.put_string ("FATAL: preferences file not found")
				io.put_new_line
			end

		rescue
			if attached {ADSB_SBS_CLIENT} sbs_client as l_sbs_client then
				l_sbs_client.stop
				l_sbs_client.start
			end
		end

	retrieve_auth_token
			--
		local
			postfields: STRING
			res:        INTEGER
			slist:      POINTER
		do
			create postfields.make_empty

			if is_api_available then

				curl_handle := init

				if curl_handle /= Void then
					setopt_string (curl_handle, curlopt_url, auth_url)
					slist := slist_append (slist, "")
					setopt_slist (curl_handle, curlopt_header, slist)

					--setopt_string (curl_handle, curlopt_postfields, postfields)


					res := perform (curl_handle)

					if res /= curle_ok then
						io.put_string ("cURL error " + res.out)
						io.put_new_line
					end
				end

			end

			cleanup (curl_handle)
		end

feature {NONE} -- Access

	log_path:      PATH
	log_writer:    LOG_ROLLING_WRITER_FILE
	logger:        LOG_LOGGING_FACILITY

	sbs_client:    detachable ADSB_SBS_CLIENT

    prefs_storage: PREFERENCES_STORAGE_XML
    prefs_manager: PREFERENCE_MANAGER
	prefs:         PREFERENCES

	auth_url:      STRING
	auth_usr:      STRING
	auth_pwd:      STRING

	curl_handle:   POINTER

end
