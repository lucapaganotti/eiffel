note
	description : "[
		collect application root class
	    Acts as a network gateway between REMS web service
	    and clients.
	    
	    +----------+      +---------+     +---------+     +-------------+
		| json req | -->  | collect | --> | xml req | --> | wcf service |
		+----------+      +---------+     +---------+     +-------------+
        		            |     ^                              |
		                    |     |                              |
		+----------+        |     |      +---------+             |
		| json rsp |  <-----+     +------| xml rsp | <-----------+
		+----------+                     +---------+
    ]"
	copyright   : "$Copyright Copyright (c) 2015-2017 ARPA Lombardia $"
	license     : "$License General Public License v2 (see http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt) $"
	author      : "$Author Luca Paganotti < luca.paganotti (at) gmail.com > $"
	source: "[
		Luca Paganotti <luca.paganotti (at) gmail.com>
		Via dei Giardini, 9
		21035 Cunardo (VA)
	]"
	date        : "$Date 2017-12-10 19:21:47 (dom 10 dic 2017, 19.21.47, CET) buck $"
	revision    : "$Revision 48 $"

class
	COLLECT_APPLICATION

inherit
	MSG_CONSTANTS
	JSON_CONSTANTS
	ERROR_CODES
	EXCEPTIONS
	EXECUTION_ENVIRONMENT
		rename
			command_line as env_command_line,
			launch as env_launch,
			arguments as environment_arguments
		end
	PROCESS_INFO_IMP
		rename
			command_line as env_command_line,
			launch as env_launch
		end
	ARGUMENTS
	LOG_PRIORITY_CONSTANTS
	LOGGING_I
	DEFAULTS
	WSF_DEFAULT_SERVICE
		redefine
			initialize
		end
	MEMORY
		redefine
			dispose
		end
	UNIX_SIGNALS
		rename
			meaning as sig_meaning,
			catch   as sig_catch,
			ignore  as sig_ignore
		end
	SYSLOG_UNIX_OS
		rename
			log_alert as syslog_alert,
			log_warning as syslog_warning,
			log_notice as syslog_notice,
			log_debug as syslog_debug
		export
			{COLLECT_APPLICATION} all
		redefine
			dispose
		end

create
	make_and_launch

feature {NONE} -- Initialization

	init
			-- internal initialization
		do
			catch_signals

			init_format_integer
			init_format_double

			create session.make ("")
			session.add_header ("content-type", "text/xml;charset=utf-8")
			--session.add_header ("SOAPAction", a_request.soap_action_header)
			session.add_header ("Accept-Encoding", "gzip, deflate")

			-- login management
			is_logged_in := false
			create login_request.make
			create logout_request.make
			create login_response.make
			create logout_response.make

			create content_type.make_empty
			create token.make
			create error_message.make_empty
			create cfg_file_name.make_empty

			read_credentials
			if attached username and attached password then
				log_display ("Credentials read", log_information, true)
			else
				log_display ("Critical failure, dying.", log_emergency, true)
				die(sigabrt)
			end

			-- Master/slave settings
			is_master := True
			create master_address.make_empty

			-- Parsing
			create xml_parser_factory
			xml_parser := xml_parser_factory.new_standard_parser
			create json_parser.make_with_string ("{}")

			-- Up time
			start_time := create {DATE_TIME}.make_now

			-- Check DLTS
			one_hour  := create {DATE_TIME_DURATION}.make (0, 0, 0, 1, 0, 0)

			-- Licensing
			create license
		end

	initialize
			-- Initialize current service
		do
			init
			init_log
			-- parse command line parameters
			parse_cmdline_parameters

			-- Activate collection
			collection_on

			log_display("Collect application started @ " + start_time.formatted_out(default_date_time_format), log_information, true)

			-- must check if `COLLECT_APPLICATION' is logged in remws
			if not is_logged_in then
				-- do login
				if is_master then
					is_logged_in := do_login
					if not is_logged_in then
						log_display ("FATAL error: unable to login", log_critical, true)
						die(0)
					else
						log_display ("logged in with token " +
						             token.id +
						             " expiring upon " +
						             token.expiry.formatted_out (default_date_time_format),
						             log_information, true)
					end
				else
					-- query token to master
					if query_token_to_master then
						is_logged_in := true
					else
						log_display ("FATAL error: unable to acquire token from master", log_critical, true)
						die(0)
					end
				end
			end
		end

	init_format_integer
			-- Initialize `format_integer'
		do
			create format_integer.make (2)
			format_integer.zero_fill
		ensure
			format_integer_attached: attached format_integer
		end

	init_format_double
			-- Initialize `format_double'
		do
			create format_double.make (6, 4)
			format_double.zero_fill
		ensure
			format_double_attached: attached format_double
		end

feature -- Usage

	usage
			-- little help on usage
		do
			credits
			main_help
			help_remarks
			env_var_usage
		end

	credits
			-- Credits and copyright
		do
			print ("collect network remws gateway%N")
			print ("Agenzia Regionale per la Protezione Ambientale della Lombardia%N")
			print ("Autore: Luca Paganotti <luca.paganotti@gmail.com>%N")
			print ("        Released under GPLv2%N")
		end

	main_help
			-- Main help text
		do
			print ("collect [-p <port_number>][-l <log_level>][-c <configfilename>][-m <master_addr_and_port][-gcm <message_number>]%N")
			print ("        [-gcoap <coalesceperiod>][-gcolp <collectionperiod>][-mt <threshold>][-mm <memory>]%N")
			print ("        [-gct <GC behaviour>][-fst][-t][-u][-v][-syslog][-h][-license]%N%N")
			print ("%T<port_number>          is the network port on which collect will accept connections%N")
			print ("%T                         default: 9090%N")
			print ("%T<log_level>            is the logging level that will be used%N")
			print ("%T                         default: debug-level%N")
			print ("%T<configfilename>       is the fie name to config file to be used, it must be in $HOME/.collect%N")
			print ("%T<master_addr_and_port> master instance IP and port must be specified%N")
			print ("%T                         i.e. 10.10.0.18:8900%N")
			print ("%T<message_number>       activates GC monitoring and checks%N")
			print ("%T                       GC parameters every <message_number> messages%N")
			print ("%T                         default: 10.000 messages%N")
			print ("%T<coalesceperiod>       sets gc coalesce period%N")
			print ("%T                         default: 2%N")
			print ("%T<collectionperiod>     sets gc collection period%N")
			print ("%T                         default: 2%N")
			print ("%T<threshold>            sets gc memory threshold%N")
			print ("%T                         default: 40.000.000 bytes%N")
			print ("%T<memory>               sets the maximum memory amount the runtime can allocate%N")
			print ("%T                         default: 160.000.000 bytes%N")
			print ("%T<GC behaviour>         GC behaviour setup%N")
			print ("%T                       t: (tiny) optimize memory allocation for size%N")
			print ("%T                       c: (compact) balance memory optimization between speed and size,%N")
			print ("%T                          shrink allocated memory%N")
			print ("%T                       s: (speed) optimize memory allocation for speed%N")
			print ("%T                          default: t (tiny)%N")
			print ("%T-m                     this instance will be run as a client instance, with master equal to <master_addr_and_port>%N")
			print ("%T-fst                   forces Nino single threaded%N")
			print ("%T                         default: nino multi-threaded%N")
			print ("%T-t                     uses the testing web service%N")
			print ("%T                         default: production server remws%N")
			print ("%T-u                     the box running collect is in UTC%N")
			print ("%T                         default: local time%N")
			print ("%T-v                     nino verbose%N")
			print ("%T                         default: no verbose%N")
			print ("%T-syslog                use syslog_utilities%N")
			print ("%T                         default: do not use%N")
			print ("%T-h                     prints this text%N")
			print ("%T-license               prints the GPLv2 license on screen%N")
			print ("%TThe available logging levels are:%N")
			print ("%T%T " + log_debug.out       + " --> debug-level messages%N")
			print ("%T%T " + log_information.out + " --> informational%N")
			print ("%T%T " + log_notice.out      + " --> normal but significant condition%N")
			print ("%T%T " + log_warning.out     + " --> warning conditions%N")
			print ("%T%T " + log_error.out       + " --> error conditions%N")
			print ("%T%T " + log_critical.out    + " --> critical conditions%N")
			print ("%T%T " + log_alert.out       + " --> action must be taken immediately%N")
			print ("%T%T " + log_emergency.out   + " --> system is unusable%N%N")
		end

	help_remarks
			-- Help remarks
		do
			print ("REMARKS:%N")
			print ("%TGarbage Collection is on by default so you have to setup it%N")
			print ("%Tto suite your needs.%N")
		end

	env_var_usage
			-- GC environment variables usage
		do
			print ("%TThere are environment variables that can/must be defined in order to%N")
			print ("%Tsetup Garbage Collection:%N")
			print ("%T  * EIF_FULL_COALESCE_PERIOD: %N")
			print ("%T      Period of full coalesce (in number of collections).%N")
			print ("%T      If the environment variable EIF_FULL_COALESCE_PERIOD%N")
			print ("%T      is defined, it is set to the closest reasonable%N")
			print ("%T      value from it.%N")
			print ("%T      If null, no full coalescing is launched.%N")
			print ("%T  * EIF_FULL_COLLECTION_PERIOD: %N")
			print ("%T      Period of full collection.%N")
			print ("%T      If the environment variable EIF_FULL_COLLECTION_PERIOD%N")
			print ("%T      is defined, it is set to the closest reasonable%N")
			print ("%T      value from it.%N")
			print ("%T      If null, no full collection is launched.%N")
			print ("%T  * EIF_MEMORY_CHUNK: %N")
			print ("%T      Minimal size of a memory chunk. The run-time always%N")
			print ("%T      allocates a multiple of this size.%N")
			print ("%T      If the environment variable EIF_MEMORY_CHUNK%N")
			print ("%T      is defined, it is set to the closest reasonable%N")
			print ("%T      value from it.%N")
			print ("%T  * EIF_MEMORY_SCAVENGE: %N")
			print ("%T      Size of generational scavenge zone.%N")
			print ("%T      If the environment variable EIF_MEMORY_SCAVENGE%N")
			print ("%T      is defined, it is set to the closest reasonable%N")
			print ("%T      value from it.%N")
			print ("%T  * EIF_TENURE_MAX: %N")
			print ("%T      Maximum age of object before being considered%N")
			print ("%T      as old (old objects are not scanned during%N")
			print ("%T      partial collection).%N")
			print ("%T      If the environment variable EIF_TENURE_MAX%N")
			print ("%T      is defined, it is set to the closest reasonable%N")
			print ("%T      value from it.%N")
			print ("%TIf -h or -license is used or no parameters are provided%N%T" + app_name + " terminates itself.%N%N")
		end

feature -- Credentials

	username:      detachable STRING
	password:      detachable STRING
	cfg_file:      PLAIN_TEXT_FILE
	default_cfg_file_name: STRING = "credentials.conf"
	cfg_file_name: STRING

	set_username (a_username: STRING)
			-- Sets `username'
		do
			username := a_username
		end

	set_password (a_password: STRING)
			-- Sets `password'
		do
			password := a_password
		end

	cfg_file_path: STRING
			-- format cfg file name full path
		do
			create Result.make_empty
			if attached home_directory_path as l_home then
				Result := l_home.out + "/.collect/"
				if cfg_file_name.is_empty then
					cfg_file_name := default_cfg_file_name
				end
			end
		end

	read_cfg--: BOOLEAN
			-- Trivial config file --> switch to preferences library
		do
			if cfg_file.exists then
				cfg_file.open_read

				cfg_file.read_line
				set_username (cfg_file.last_string)
				cfg_file.read_line
				set_password (cfg_file.last_string)

				cfg_file.close
			end
		rescue
			cfg_file.close
		end

	read_credentials--: BOOLEAN
			-- Read wsrem credentials from file
		local
			l_path: detachable STRING
		do
			if not cfg_file_path.is_empty then
				l_path := cfg_file_path + default_cfg_file_name
			else
				l_path := "/etc/collect/credentials.conf"
			end

			create cfg_file.make_with_name (l_path)

			read_cfg
			if attached username and attached password then
				log_display ("Credentials OK", log_alert, true)
			else
				log_display ("Unable to read credentials", log_alert, true)
			end
		end

feature -- Logging

	init_log
			-- Initialize log on file
		local
			path: detachable STRING
			home: detachable STRING
		do
			create path.make_from_string ("$HOME/log/collect.log")
			create home.make_empty

			if attached item("HOME") as s_h then
				if not s_h.is_empty then
					home.copy (s_h.to_string_8)
					path.replace_substring_all ("$HOME", home)
				end
			else
				path.copy ("/var/log/collect.log")
			end

			create log_path.make_from_string (path)
			create logger.make
			create file_logger.make_at_location (log_path)
			file_logger.set_max_backup_count (10)
			file_logger.set_max_file_size ({NATURAL_64}1 * 1024 * 1024 * 1024)
			file_logger.enable_debug_log_level
			if attached logger as l_logger then
				l_logger.register_log_writer (file_logger)
				log_display ("Log system initialized", log_information, true)
			end
		end

	is_logging_enabled: BOOLEAN
			-- Is logging enabled
		do
			Result := attached logger
		end

	log (a_string: STRING; priority: INTEGER)
			-- Logs `a_string'
		do
			if attached logger as l_logger then
				if priority = log_debug then l_logger.write_debug (a_string)
					elseif priority = log_emergency   then l_logger.write_emergency (a_string)
					elseif priority = log_alert       then l_logger.write_alert (a_string)
					elseif priority = log_critical    then l_logger.write_critical (a_string)
					elseif priority = log_error       then l_logger.write_error (a_string)
					elseif priority = log_information then l_logger.write_information (a_string)
					elseif priority = log_notice      then l_logger.write_notice (a_string)
					elseif priority = log_warning     then l_logger.write_warning (a_string)
				end
			end
		end

	log_display(a_string: STRING; priority: INTEGER; to_file: BOOLEAN)
			-- Combined file, syslog and display log
		do
			io.put_string (a_string)
			io.put_new_line
			if to_file then
				log (a_string, priority)
			end
			if use_syslog then
				sys_log (priority, a_string)
			end
		end

	log_gc_parameters
			-- log/display GC parameters
		local
			l_mem_stat: detachable MEM_INFO
			l_gc_stat:  detachable GC_INFO
			l_count, i: detachable INTEGER
		do
			if is_gc_monitoring_active then
				l_mem_stat := memory_statistics (Total_memory)
				log_display ("Displaying GC parameters ...",                                     log_alert, true);
				log_display ("MEMORY STATISTICS ON TOTAL " + msg_number.out,                     log_alert, true)
				log_display ("Total 64 MEMORY:   "  + l_mem_stat.total64.out,                    log_alert, true)
				log_display ("Free  64 MEMORY:   "  + l_mem_stat.free64.out,                     log_alert, true)
				log_display ("Used  64 MEMORY:   "  + l_mem_stat.used64.out,                     log_alert, true)

				l_mem_stat := memory_statistics (Eiffel_memory)
				log_display ("MEMORY STATISTICS ON EIFFEL " + msg_number.out,                    log_alert, true)
				log_display ("Total 64 MEMORY:   "  + l_mem_stat.total64.out,                    log_alert, true)
				log_display ("Free  64 MEMORY:   "  + l_mem_stat.free64.out,                     log_alert, true)
				log_display ("Used  64 MEMORY:   "  + l_mem_stat.used64.out,                     log_alert, true)

				l_mem_stat := memory_statistics (C_memory)
				log_display ("MEMORY STATISTICS ON C " + msg_number.out,                         log_alert, true)
				log_display ("Total 64 MEMORY:   "  + l_mem_stat.total64.out,                    log_alert, true)
				log_display ("Free  64 MEMORY:   "  + l_mem_stat.free64.out,                     log_alert, true)
				log_display ("Used  64 MEMORY:   "  + l_mem_stat.used64.out,                     log_alert, true)

				l_gc_stat  := gc_statistics (Full_collector)
				log_display ("GC MEMORY STATISTICS ON FULL COLLECTOR " + msg_number.out,         log_alert, true)
				log_display ("Collected MEMORY:   "  + l_gc_stat.collected.out,                  log_alert, true)
				log_display ("Total MEMORY:       "  + l_gc_stat.total_memory.out,               log_alert, true)
				log_display ("Eiffel MEMORY:      "  + l_gc_stat.eiffel_memory.out,              log_alert, true)
				log_display ("MEMORY used:        "  + l_gc_stat.memory_used.out,                log_alert, true)
				log_display ("MEMORY Cycle count: "  + l_gc_stat.cycle_count.out,                log_alert, true)

				l_gc_stat  := gc_statistics (Incremental_collector)
				log_display ("GC MEMORY STATISTICS ON INCREMENTAL COLLECTOR " + msg_number.out,  log_alert, true)
				log_display ("Collected MEMORY:   "  + l_gc_stat.collected.out,                  log_alert, true)
				log_display ("Total MEMORY:       "  + l_gc_stat.total_memory.out,               log_alert, true)
				log_display ("Eiffel MEMORY:      "  + l_gc_stat.eiffel_memory.out,              log_alert, true)
				log_display ("MEMORY used:        "  + l_gc_stat.memory_used.out,                log_alert, true)
				log_display ("MEMORY Cycle count: "  + l_gc_stat.cycle_count.out,                log_alert, true)

				log_display ("MEMORY count map: " + memory_count_map.count.out,                  log_alert, true)
				from i := memory_count_map.current_keys.lower
				until i = memory_count_map.current_keys.upper
				loop
					l_count := l_count + memory_count_map.item (i)
					i := i + 1
				end
				log_display ("MEMORY count map objects: " + l_count.out,                         log_alert, true)

				log_display ("GC collection parameters displaying end ...",                      log_alert, true)
			end
		end


feature -- Basic operations

	reset_json_parser
			-- Reset `json_parser'
		do
			if not json_parser.is_valid then
				log_display ("Resetting JSON parser", log_warning, true)
				json_parser.reset_reader
				json_parser.reset
				--log_display ("JSON parser OK", log_warning, true)
			end
		end

	parse_header (json: STRING): INTEGER
			-- Search message header for message id
		require
			json_parser_attached: attached json_parser
		do
			if not json_parser.is_valid then
				reset_json_parser
			end
			json_parser.set_representation (json)
			json_parser.parse_content
			if json_parser.is_valid then
				if  attached json_parser.parsed_json_value as jv and then
				    attached {JSON_OBJECT} jv as j_object and then attached {JSON_OBJECT} j_object.item (json_header_tag) as j_header
					and then attached {JSON_NUMBER} j_header.item (json_id_tag) as j_id then
					Result := j_id.integer_64_item.to_integer
				else
					reset_json_parser
					-- assume a real time data request
					Result := 10
				end
			end
		end

	check_json_message (a_msg: STRING): BOOLEAN
			-- Checks for unreachable characters
		require
			a_msg_attached: attached a_msg
		local
			l_idx: INTEGER
			l_chr: CHARACTER_8
		do
			Result := true

			from l_idx := 1
			until l_idx = a_msg.count
			loop
				l_chr := a_msg.at (l_idx)
				if not (l_chr.is_printable or (l_chr.code >= 9 and l_chr.code <= 13)) then
					Result := false
				end
				l_idx := l_idx + 1
			end
		end

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
	    local
	    	current_time:       detachable DATE_TIME
	    			-- Current time

			request:            detachable STRING
    				-- Request as string
	    	response:           detachable STRING
    				-- Response as string

			req_obj:            detachable REQUEST_I
			res_obj:            detachable RESPONSE_I

			token_expired:      detachable BOOLEAN
			log_string:         detachable STRING

			received_bytes:   INTEGER
					-- Received bytes
			msg_id:           INTEGER
					-- Message id

		do
			--log_display ("Entering execute ...", log_debug, true)
			create request.make (req.content_length_value.to_integer_32)
			create response.make_empty
			create current_time.make_now

--			up_time := current_time.relative_duration (start_time)
--			if attached up_time as l_up_time then
--				log_display("UP TIME: " +
--								l_up_time.day.out + ":" +
--								format_integer.formatted (l_up_time.hour) + ":" +
--								format_integer.formatted (l_up_time.minute) + ":" +
--								format_integer.formatted (l_up_time.second), log_information, true)
--			end

			--log_display ("Checking UTC settings ...", log_debug, true)
			if is_utc_set then
				--log_display ("time_offset     : " + one_hour.hour.out, log_debug, true)
				current_time := current_time + one_hour
			end

			token_expired := is_token_expired (current_time)

			--log_display ("is logged in    : " + is_logged_in.out, log_debug, true)
			--log_display ("token id        : " + token.id, log_debug, true)
			--log_display ("token expiry    : " + token.expiry.formatted_out (default_date_time_format), log_debug, true)
			--log_display ("current time    : " + current_time.formatted_out (default_date_time_format), log_debug, true)
			--log_display ("is token expired: " + token_expired.out, log_debug, true)

			--log_display ("Checking token expiration ...", log_debug, true)
			if is_master then
				if token_expired then
					sleep (500000000)
					login_response.reset
					is_logged_in := do_login
					if not is_logged_in then
						log_display("Unable to login", log_error, true)
						log_display ("Outcome   : " + login_response.outcome.out, log_information, true)
						log_display ("Message   : " + login_response.message, log_information, true)
					else
						log_display ("logged in with new token " +
						             token.id +
						             " expiring upon " +
						             token.expiry.formatted_out (default_date_time_format),
						             log_information, true)
					end
					sleep (500 * 1000000)
				end
			else
				is_logged_in := query_token_to_master
			end

			if is_logged_in then
				-- read json input
				--log_display ("Reading JSON input ...", log_debug, true)
				received_bytes := req.input.read_to_string (request, 1, req.content_length_value.to_integer_32)
				--log_display ("Received " + received_bytes.out + " bytes", log_debug, true)

				if attached request as l_req then
					if not check_json_message (l_req) then
						log_display ("CONTROL character(s) received: not a valid JSON message", log_warning, true)
						log_display ("DISCARD message", log_warning, true)
						raise ("CONTROL character(s) received: raise")
					else
						if not l_req.is_valid_as_string_8 then
							log_display ("ERROR: not a text message", log_warning, true)

							log_string := "********** BAD REQUEST "
							log_string.append (l_req)
							log_string.append (" ")
							log_string.append (req.remote_addr)
							log_string.append (" ")
							if attached req.remote_host as l_remote_host then
								log_string.append (l_remote_host)
								log_string.append (" ")
							end
							log_string.append (req.request_uri)
							if attached req.request_time as l_request_time then
								log_string.append (l_request_time.formatted_out (default_date_time_format))
							end
							log_display (log_string, log_alert, true)

							l_req.fill_character (null_char)
							l_req.wipe_out
						else
							--log_display(" <<< " + l_req, log_debug, true)
							-- parse the message header
							msg_id := parse_header (l_req)

							if msg_id = 0 then
								error_code    := {ERROR_CODES}.err_invalid_json
								error_message := {ERROR_CODES}.msg_invalid_json
								log_display("Client error " + l_req, log_warning, true)
								reset_json_parser
							end
							--log_display ("Received message id: " + msg_id.out, log_debug, true)
							--log_display ("Checking message type ... got " + msg_id.out + " msg" , log_debug, true)
							--log_display ("Inspecting message type id " + msg_id.out, log_debug, true)
							msg_number := msg_number + 1
							--log_display ("%T Managed message number " + msg_number.out, log_notice, true)

							--log_display ("Checking message number ...", log_debug, true)
							inspect
								msg_id
							when {REQUEST_I}.station_status_list_request_id then
								req_obj := create {STATION_STATUS_LIST_REQUEST}.make
								if attached req_obj as myreq then
									myreq.from_json (l_req, json_parser)
									myreq.set_token_id (token.id)
									res_obj := do_post (myreq)
									if attached res_obj as myres then
										response := myres.to_json
										log_display("Sent message id: " + myres.id.out + " Station status list", log_information, true)
										log_display("Message outcome: " + myres.outcome.out, log_information, true)
										if attached myres.message as l_message then
											log_display("Message message: " + l_message, log_information, true)
										end
									end
								end
							when {REQUEST_I}.station_types_list_request_id then
								req_obj := create {STATION_TYPES_LIST_REQUEST}.make
								if attached req_obj as myreq then
									myreq.from_json (l_req, json_parser)
									myreq.set_token_id (token.id)
									res_obj := do_post (myreq)
									if attached res_obj as myres then
										response := myres.to_json
										log_display("Sent message id: " + myres.id.out + " Station types list", log_information, true)
										log_display("Message outcome: " + myres.outcome.out, log_information, true)
										if attached myres.message as l_message then
											log_display("Message message: " + l_message, log_information, true)
										end
									end
								end
							when {REQUEST_I}.province_list_request_id then
								req_obj := create {PROVINCE_LIST_REQUEST}.make
								if attached req_obj as myreq then
									myreq.from_json (l_req, json_parser)
									myreq.set_token_id (token.id)
									res_obj := do_post (myreq)
									if attached res_obj as myres then
										response := myres.to_json
										log_display("Sent message id: " + myres.id.out + " Province list", log_information, true)
										log_display("Message outcome: " + myres.outcome.out, log_information, true)
										if attached myres.message as l_message then
											log_display("Message message: " + l_message, log_information, true)
										end
									end
								end
							when {REQUEST_I}.municipality_list_request_id then
								req_obj := create {MUNICIPALITY_LIST_REQUEST}.make
								if attached req_obj as myreq then
									myreq.from_json (l_req, json_parser)
									myreq.set_token_id (token.id)
									res_obj := do_post (myreq)
									if attached res_obj as myres then
										response := myres.to_json
										log_display("Sent message id: " + myres.id.out + " Municipality list", log_information, true)
										log_display("Message outcome: " + myres.outcome.out, log_information, true)
										if attached myres.message as l_message then
											log_display("Message message: " + l_message, log_information, true)
										end
									end
								end
							when {REQUEST_I}.station_list_request_id then
								req_obj := create {STATION_LIST_REQUEST}.make
								if attached req_obj as myreq then
									myreq.from_json (l_req, json_parser)
									myreq.set_token_id (token.id)
									res_obj := do_post (myreq)
									if attached res_obj as myres then
										response := myres.to_json
										log_display("Sent message id: " + myres.id.out + " Station list", log_information, true)
										log_display("Message outcome: " + myres.outcome.out, log_information, true)
										if attached myres.message as l_message then
											log_display("Message message: " + l_message, log_information, true)
										end
									end
								end
							when {REQUEST_I}.sensor_type_list_request_id then
								req_obj := create {SENSOR_TYPE_LIST_REQUEST}.make
								if attached req_obj as myreq then
									myreq.from_json (request, json_parser)
									myreq.set_token_id (token.id)
									res_obj := do_post (myreq)
									if attached res_obj as myres then
										response := myres.to_json
										log_display("Sent message id: " + myres.id.out + " Sensor types list", log_information, true)
										log_display("Message outcome: " + myres.outcome.out, log_information, true)
										if attached myres.message as l_message then
											log_display("Message message: " + l_message, log_information, true)
										end
									end
								end
							when {REQUEST_I}.sensor_list_request_id then
								req_obj := create {SENSOR_LIST_REQUEST}.make
								if attached req_obj as myreq then
									myreq.from_json (request, json_parser)
									myreq.set_token_id (token.id)
									res_obj := do_post (myreq)
									if attached res_obj as myres then
										response := myres.to_json
										log_display("Sent message id: " + myres.id.out + " Sensor list", log_information, true)
										log_display("Message outcome: " + myres.outcome.out, log_information, true)
										if attached myres.message as l_message then
											log_display("Message message: " + l_message, log_information, true)
										end
									end
								end
							when {REQUEST_I}.realtime_data_request_id then
								log_display ("Create request object --> req_obj.make", log_debug, true)
								req_obj := create {REALTIME_DATA_REQUEST}.make
								log_display ("req_obj called", log_debug, true)
								if attached req_obj as myreq then
									--log_display ("req_obj attached as myreq", log_debug, true)
									--log_display ("parse myreq from json detachable STRING request attached as l_req", log_debug, true)
									myreq.from_json (l_req, json_parser)
									--log_display ("myreq.from_json called", log_debug, true)
									--log_display ("update myreq with token id", log_debug, true)
									myreq.set_token_id (token.id)
									--log_display ("myreq.set_token_id called", log_debug, true)
									--log_display ("do post of myreq", log_debug, true)

									res_obj := do_post (myreq)

									--log_display ("res_obj := do_post(myreq) called", log_debug, true)
									--log_display ("verify if res_obj is attached", log_debug, true)
									if attached res_obj as myres then
										--log_display ("res_obj attached as myres", log_debug, true)
										--log_display ("convert myres.to_json", log_debug, true)
										response := myres.to_json
										--log_display ("myres.to_json called", log_debug, true)
										--log_display ("Sent message id: " + myres.id.out + " Realtime data", log_information, true)
										--log_display ("Message outcome: " + myres.outcome.out, log_information, true)
										--if attached myres.message as l_message then
										--	log_display ("Message message: " + l_message, log_information, true)
										--else
										--	log_display ("myres.message not attached, may raise an exception", log_warning, true)
										--end
									else
										log_display ("res_obj not attached, may raise an exception ...", log_warning, true)
									end
								else
									log_display ("req_obj not attached, may raise an exception ...", log_warning, true)
								end
							when {REQUEST_I}.query_token_request_id then
								req_obj := create {QUERY_TOKEN_REQUEST}.make
								if attached req_obj as myreq then
									myreq.from_json (l_req, json_parser)
									res_obj := create {QUERY_TOKEN_RESPONSE}.make_from_token (token)
									if attached res_obj as myres then
										response := myres.to_json
										log_display("Sent message id: " + myres.id.out + " Query token", log_information, true)
										log_display("Message outcome: " + myres.outcome.out, log_information, true)
										if attached myres.message as l_message then
											log_display("Message message: " + l_message, log_information, true)
										end
									end
								end
							when {REQUEST_I}.standard_data_request_id then
								req_obj := create {STANDARD_DATA_REQUEST}.make
								if attached req_obj as myreq then
									myreq.from_json (l_req, json_parser)
									myreq.set_token_id (token.id)
									res_obj := do_post (myreq)
									if attached res_obj as myres then
										response := myres.to_json
										log_display("Sent message id: " + myres.id.out + " Realtime data", log_information, true)
										log_display("Message outcome: " + myres.outcome.out, log_information, true)
										if attached myres.message as l_message then
											log_display("Message message: " + l_message, log_information, true)
										end
									end
								end
							else
								log_display ("UNKNOWN message id " + msg_id.out, log_warning, true)
							end

						end
					end
				else
					log_display ("JSON request NOT ATTACHED", log_warning, true)
				end

				if msg_id = 0 then
					res.put_header ({HTTP_STATUS_CODE}.bad_request, <<["Content-Type", "text/json"], ["Content-Length", response.count.out]>>)
					log_display ("Returned HTTP status code: " + {HTTP_STATUS_CODE}.bad_request.out + " Content-Length: " + response.count.out, log_error, true)
				else
					res.put_header ({HTTP_STATUS_CODE}.ok, <<["Content-Type", "text/json"], ["Content-Length", response.count.out]>>)
					--log_display ("Returned HTTP status code: " + {HTTP_STATUS_CODE}.ok.out, log_debug, true)
				end
				res.put_string (response)
				--log_display (" >>> " + response, log_debug, true)

				if msg_number = {INTEGER}.max_value - 1 then
					msg_number := 0
					msg_total_time := 0.0
					--log_display ("Reset message counter to 1", log_notice, true)
				end

				--log_display ("Message number checked", log_debug, true)

				if (msg_number \\ gc_monitoring_message_number) = 0 then
					log_gc_parameters
				end
			else
				log_display ("ERROR: NOT LOGGED IN", log_error, true)
			end

			error_code    := success
			error_message := ""

			--log_display ("Exiting execute ...", log_debug, true)

		rescue
			log_display ("EXCEPTION raised", log_error, true)
			log_gc_parameters
			handle_signals
			reset_json_parser
			sleep (100)
		end

	parse_help_switches
			-- Parses -h, -license and no argument cases
		local
			idx: INTEGER
		do
			if argument_count = 0 then
				usage
				die (0)
			end

			idx := index_of_word_option ("h")
			if idx > 0 then
				usage
				die (0)
			end

			idx := index_of_word_option ("license")
			if idx > 0 then
				log_display (license.text, log_information, false)
				die (0)
			end
		end

	parse_main_switches
			-- Parses main switches: -c, -p, -fst, -l, -m
		local
			idx:    INTEGER
			addrp:  STRING
			tokens: LIST[STRING]
		do
			idx := index_of_word_option ("c")
			if idx > 0 then
				cfg_file_name := argument (idx + 1).to_string_8
			end
			idx := index_of_word_option ("p")
			if idx > 0 then
				port := argument (idx + 1).to_integer
			else
				port := default_port
			end
			set_service_option ("port", port)

			idx := index_of_word_option ("fst")
			if idx > 0  then
				set_service_option ("force_single_threaded", true)
			end

			idx := index_of_word_option ("l")
			if idx > 0 then
				log_level := argument (idx + 1).to_integer
				if     log_level = log_debug       then file_logger.enable_debug_log_level          -- 7
				elseif log_level = log_information then file_logger.enable_information_log_level    -- 6
				elseif log_level = log_notice      then file_logger.enable_notice_log_level         -- 5
				elseif log_level = log_warning     then file_logger.enable_warning_log_level        -- 4
				elseif log_level = log_error       then file_logger.enable_error_log_level          -- 3
				elseif log_level = log_critical    then file_logger.enable_critical_log_level       -- 2
				elseif log_level = log_alert       then file_logger.enable_alert_log_level          -- 1
				elseif log_level = log_emergency   then file_logger.enable_emergency_log_level      -- 0
				else
					file_logger.enable_error_log_level -- 3
				end
			else
				log_level := log_error
				file_logger.enable_error_log_level -- 3
			end

			idx := index_of_word_option ("m")
			if idx > 0 then
				addrp := argument (idx + 1)
				tokens := addrp.split (':')
				check tokens.count = 2 end
				master_address := tokens.at (1)
				master_port    := tokens.at (2).to_integer
				is_master := false
			end
		end

	parse_extended_switches
			-- Parses extended switches -t, -u and -v
		local
			idx: INTEGER
		do
			idx := index_of_word_option ("k")
			if idx > 0 then
				existing_token := true
				token.set_id (argument (idx + 1).out)
				token.set_expiry (create {DATE_TIME}.make (2100, 12, 31, 23, 59, 59))
				is_logged_in := true
				save_last_token
			end

			idx := index_of_word_option ("t")
			if idx > 0 then
				use_testing_ws := true
			else
				use_testing_ws := false
			end

			idx := index_of_word_option ("u")
			if idx > 0 then
				is_utc_set := true
			else
				is_utc_set := false
			end

			idx := index_of_word_option ("v")
			if idx > 0 then
				set_service_option ("verbose", true)
			end

			idx := index_of_word_option ("syslog")
			if idx > 0 then
				use_syslog := true
				-- syslog
				open_log (app_name, log_pid, log_user)
			end
		end

	parse_gc_switches
			-- Parses garbage collection switches
		local
			idx: INTEGER
			gct: STRING
		do
			-- GC switches
			idx := index_of_word_option ("gcm")
			if idx > 0 then
				is_gc_monitoring_active := true
				gc_monitoring_message_number := argument (idx + 1).to_integer
			else
				is_gc_monitoring_active := false
				gc_monitoring_message_number := default_gc_monitoring_message_number
			end

			idx := index_of_word_option("mt")
			if idx > 0 then
				set_memory_threshold (argument (idx + 1).to_integer)
			else
				set_memory_threshold (default_gc_memory_threshold)
			end

			idx := index_of_word_option("mm")
			if idx > 0 then
				set_max_mem (argument (idx + 1).to_integer)
			else
				set_max_mem (default_runtime_max_memory)
			end

			idx := index_of_word_option("mm")
			if idx > 0 then
				set_max_mem (argument (idx + 1).to_integer)
			else
				set_max_mem (default_runtime_max_memory)
			end

			idx := index_of_word_option("gcolp")
			if idx > 0 then
				set_collection_period (argument (idx + 1).to_integer)
			else
				set_collection_period (default_gc_collection_period)
			end

			idx := index_of_word_option("gcoap")
			if idx > 0 then
				set_coalesce_period (argument (idx + 1).to_integer)
			else
				set_coalesce_period (default_gc_coalesce_period)
			end

			idx := index_of_word_option ("gct")
			if idx > 0 then
				gct := argument (idx + 1).to_string_8
				if gct.is_equal ("t") then
					allocate_tiny
				elseif gct.is_equal ("c") then
					allocate_compact
				elseif gct.is_equal ("s") then
					allocate_fast
				else
					allocate_tiny
				end
			else
				allocate_tiny
			end
		end

	parse_cmdline_parameters
			-- Parse command line parameters

		do
			parse_help_switches

			parse_main_switches

			parse_extended_switches

			parse_gc_switches
		end

feature -- dispose

	dispose
			-- `dispose' redefinition
		do
			Precursor {SYSLOG_UNIX_OS}
			Precursor {MEMORY}
		end

feature {NONE} -- Signals

	catch_signals
			-- Catch UNIX signals
		do
			sig_catch (sighup)
			sig_catch (sigint)
			sig_catch (sigsegv)
			sig_catch (sigkill)
			sig_catch (sigterm)
		end

	handle_signals
			-- Handle UNIX signals
		do
			if is_signal then
				if is_caught (sighup) then
					log_display ("SIGHUP "  + sighup.out  + " caught", log_emergency, true)
				elseif is_caught (sigint) then
					log_display ("SIGINT "  + sigint.out  + " caught", log_emergency, true)
				elseif is_caught (sigsegv) then
					log_display ("SIGSEGV " + sigsegv.out + " caught", log_emergency, true)
					log_display ("Dying ...", log_emergency, true)
					if do_logout then
						log_display ("Logged out", log_emergency, true)
					else
						log_display ("Unable to log out", log_emergency, true)
					end

					die(sigsegv)
				elseif is_caught (sigkill) then
					log_display ("SIGKILL " + sigkill.out + " caught", log_emergency, true)
					log_display ("Killing myself", log_emergency, true)
					if do_logout then
						log_display ("Logged out", log_emergency, true)
					else
						log_display ("Unable to log out", log_emergency, true)
					end
					die (sigkill)
				elseif is_caught (sigterm) then
					log_display ("SIGTERM " + sigterm.out + " caught", log_emergency, true)
				else
					log_display ("UNKNOWN signal caught", log_emergency, true)
				end
			end
			if is_developer_exception then
				log_display ("EXCEPTION: developer exception", log_critical, true)
			end
			if is_system_exception then
				log_display ("EXCEPTION: system exception", log_critical, true)
			end
		end

feature {NONE} -- Network IO

	session: LIBCURL_HTTP_CLIENT_SESSION


	post(a_request: REQUEST_I) : STRING
			-- Post `a_request' to remws using `LIBCURL_HTTP_CLIENT'
		local
			l_context: detachable HTTP_CLIENT_REQUEST_CONTEXT
			l_res: detachable HTTP_CLIENT_RESPONSE
		do
			--session.headers.wipe_out
			if session.headers.count /= 3 then
				session.headers.wipe_out
				session.add_header ("content-type", "text/xml;charset=utf-8")
				session.add_header ("SOAPAction", a_request.soap_action_header)
				session.add_header ("Accept-Encoding", "gzip, deflate")
			else
				session.headers.replace (a_request.soap_action_header, "SOAPAction")
				check session.headers.replaced end
			end
			if use_testing_ws then
				l_res := session.post (a_request.ws_test_url, l_context, a_request.to_xml)
			else
				l_res := session.post (a_request.ws_url, l_context, a_request.to_xml)
			end

			if attached l_res.body as r then
				Result := r
			else
				Result := ""
			end
		end


	do_post (a_request: REQUEST_I): detachable RESPONSE_I
			-- Do a post to remws
			-- Parse the XML response
			-- Convert the response in json
		require
			a_request_attached: attached a_request
			xml_parser_attached: attached xml_parser
		local
			l_xml_str: detachable STRING
			received_time:      DATE_TIME
	    	sent_to_rem_time:   DATE_TIME

	    	serving_time:       detachable DATE_TIME_DURATION
	    			-- Message serving time

			msg_mean_time:      DOUBLE
		do
			Result    := a_request.init_response
			create sent_to_rem_time.make_now
			l_xml_str := post (a_request)
			create received_time.make_now
			serving_time := received_time.relative_duration (sent_to_rem_time)
			msg_total_time := msg_total_time + serving_time.fine_seconds_count
			msg_mean_time := msg_total_time / msg_number.to_real
			if attached serving_time then
				log_display ("@ MSG " + msg_number.out + " serving time is " + format_double.formatted(serving_time.fine_seconds_count) +
				                        " total time is " + format_double.formatted(msg_total_time) +
				                        " avg time is " + format_double.formatted (msg_mean_time) + " seconds", log_notice, true)
			end
			--log_display(" <<< " + l_xml_str, log_debug, true)

			if attached Result as l_result then
				if error_code = 0 then
					l_result.from_xml (l_xml_str, xml_parser)
				else
					l_result.set_outcome (error_code)
					l_result.set_message (error_message)
				end
			end
		ensure
			result_attached: attached Result
		end

feature {NONE} -- Login management

	one_hour:    DATE_TIME_DURATION
			-- One hour fixed `DATE_TIME_DURATION'
	login_request: LOGIN_REQUEST
			-- The login request
	logout_request: LOGOUT_REQUEST
			-- The logout request
	login_response: LOGIN_RESPONSE
			-- The login response
	logout_response: LOGOUT_RESPONSE
			-- The logout response

	last_token_file_path: STRING
			-- last token file name full path
		do
			create Result.make_empty
			if attached home_directory_path as l_home then
				Result := l_home.out + "/.collect/last_token"
			end
		end

	is_token_expired (a_date_time: DATE_TIME): BOOLEAN
			-- Tells if `token' is expired
		require
			token_attached: attached token
		do
			Result := a_date_time > token.expiry
		end

	save_last_token
			-- Saves last token
		local
			last_token_file: detachable PLAIN_TEXT_FILE
		do
			create last_token_file.make_create_read_write (last_token_file_path)
			last_token_file.put_string (token.id)
			last_token_file.put_new_line
			last_token_file.put_string (token.expiry.formatted_out (default_date_time_format))
			last_token_file.put_new_line
			last_token_file.put_integer (process_id)
			last_token_file.put_new_line
			last_token_file.flush
			last_token_file.close
		end

	do_login: BOOLEAN
			-- Execute login
		require
			token_attached: attached token
		local
			l_xml_str:       detachable STRING
		do
			if attached username as l_username and attached password as l_password then
				login_request.set_username (l_username)
				login_request.set_password (l_password)

				l_xml_str := post (login_request)
				log_display("do_login_response: " + l_xml_str, log_debug, true)
				login_response.from_xml (l_xml_str, xml_parser)
				log_display("login outcome: " + login_response.outcome.out, log_debug, true)
				log_display("login message: " + login_response.message,     log_debug, true)

				if login_response.outcome = success then
					token.set_id (login_response.token.id)
					token.set_expiry (login_response.token.expiry)
					if token.id.count > 0 then
						Result := true
						-- save token to text file
						save_last_token
					end
				end
			end
		end

	do_logout: BOOLEAN
			-- Execute logout
		local
			l_xml_str: detachable STRING
		do
			if attached token as l_token then
				logout_request.set_token_id (token.id)

				l_xml_str := post (logout_request)
				log_display("do_logout response " + l_xml_str, log_debug, true)
				log_display("login outcome: " + logout_response.outcome.out, log_debug, true)
				log_display("login message: " + logout_response.message,     log_debug, true)

				logout_response.from_xml (l_xml_str, xml_parser)

				Result := logout_response.outcome = success
			else
				Result := false
			end
		end

	error_code:     INTEGER
			-- Post error code
	error_message:  STRING
			-- Post error message
	use_testing_ws: BOOLEAN
			-- Must use the testing web service

	internal_error: ERROR_RESPONSE do create Result.make end

	query_token_to_master: BOOLEAN
			-- Query current token
		require
			token_attached: attached token
			master_addr_attached_and_not_empty: attached master_address and not master_address.is_empty
			valid_master_port: master_port > 1024
		local
			l_session: LIBCURL_HTTP_CLIENT_SESSION
			l_context: detachable HTTP_CLIENT_REQUEST_CONTEXT
			l_res:     detachable HTTP_CLIENT_RESPONSE
			qt_req:    QUERY_TOKEN_REQUEST
			qt_res:    RESPONSE_I
		do
			create qt_req.make
			qt_res := qt_req.init_response
			create l_session.make ("")
			l_session.add_header ("content-type", "text/json;charset=utf-8")
			l_session.add_header ("Accept-Encoding", "gzip, deflate")

			l_res := l_session.post ("http://" + master_address + ":" + master_port.out, l_context, qt_req.to_json)

			if attached l_res as res then
				if attached res.body as body then
					log_display("query_token_to_master " + body, log_debug, true)
					if attached {QUERY_TOKEN_RESPONSE} qt_res as r then
						log_display("query_token_to_master parse response ...", log_debug, true)
						r.from_json (body, json_parser)
						log_display("query_token_to_master parsed response: " + r.token.id + " " + r.token.expiry.formatted_out (default_date_time_format), log_debug, true)
						token.set_id (r.token.id)
						token.set_expiry (r.token.expiry)
						log_display("query_token_to_master: got token: " + token.id + " " + token.expiry.formatted_out (default_date_time_format), log_debug, true)
						result := true
					end
				else
					log_display("query_token_to_master: response after POST has body not attached", log_debug, true)
				end
			else
				log_display("query_token_to_master: response after POST not attached", log_debug, true)
			end
		end


feature {NONE}-- Attributes

	port:         INTEGER
			-- Listening port
	log_level:    INTEGER
			-- Log level
	content_type: STRING

	is_logged_in: BOOLEAN
			-- is collect logged in remws?
	is_utc_set:   BOOLEAN
			-- is the running box in UTC?
	is_master:    BOOLEAN
			-- is `Current' running as a master instance
	master_address: STRING
			-- IPv4 master address
	master_port:    INTEGER
			-- master port
	existing_token: BOOLEAN
			-- service running with -k switch
			-- a token is passed on the command line
			-- no need to login
			-- `last_token_file_path' needs to be updated
	token:          TOKEN
			-- the current `TOKEN'
	log_path:       PATH
			-- log path
	file_logger:    LOG_ROLLING_WRITER_FILE
			-- the logger
	msg_number:   INTEGER
			-- parsed messages number
	msg_total_time:     DOUBLE
	is_gc_monitoring_active: BOOLEAN
			-- log/display gc parameters
	gc_monitoring_message_number: INTEGER
			-- Monitor gc parameters every `gc_monitoring_message_number'
			-- if `is_gc_monitoring_active' is true
	start_time: DATE_TIME
			-- Application start date time
	--up_time: detachable DATE_TIME_DURATION
			-- Global applcation up time
	use_syslog: BOOLEAN
			-- Use syslog utilities
	app_name: STRING
			-- `Current' application name
		do
			Result := "collect"
		end

	null_char: CHARACTER

feature -- Parsing

	xml_parser_factory: XML_PARSER_FACTORY
			-- Global xml parser factory
	xml_parser:         XML_STANDARD_PARSER
			-- Global xml parser
	json_parser:        JSON_PARSER
			-- Global json parser

feature {NONE} -- Formatting

	format_integer: FORMAT_INTEGER

	format_double:  FORMAT_DOUBLE

feature {NONE} -- License

	license: GPLV2_LICENSE

end
