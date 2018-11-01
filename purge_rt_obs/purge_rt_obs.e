note
	description : "[
		purge_rt_obs application root class
		purge observations from M_Osservazioni_TR too old than `n` days
	]"
	copyright   : "$Copyright Copyright (c) 2015-2017 ARPA Lombardia $"
	license     : "$License General Public License v2 (see http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt) $"
	author      : "$Author Luca Paganotti < luca.paganotti (at) gmail.com > $"
	source      : "[
		Luca Paganotti <luca.paganotti (at) gmail.com>
		Via dei Giardini, 9
		21035 Cunardo (VA)
	]"
	date        : "$Date 2018-11-01 11:33:56 buck $"
	revision    : "$Revision 1 $"

class
	PURGE_RT_OBS

inherit
	DEFAULTS
	ARGUMENTS
	RDB_HANDLE
	EXECUTION_ENVIRONMENT
	rename
		Command_line as env_command_line
	end
	MEMORY
		redefine
			dispose
		end
	EXCEPTIONS
	UNIX_SIGNALS
		rename
			meaning as sig_meaning,
			catch   as sig_catch,
			ignore  as sig_ignore
		end
	SYSLOG_UNIX_OS
		redefine
			dispose
		end

create
	make

feature {NONE} -- Initialization

	init
			--
		do
			-- syslog
			open_log (app_name, log_pid, log_user)
		end

	init_gc
			-- GC settings
		do
			-- garbage collection
			allocate_compact
			set_memory_threshold (40000000)
			set_max_mem (160000000)
			set_collection_period (1)
			set_coalesce_period (2)
			collection_on
		end

	make
			-- Run application.
		local
			l_idx: INTEGER
		do
			sig_ignore (sighup)
			sig_ignore (sigint)
			sig_ignore (sigkill)
			sig_ignore (sigterm)

			init_gc

			init

			init_preferences

			set_hostname (db_host)
			set_application (db)
			login(db_user, db_password)
			set_base

			create modification.make
			create session_control.make
			session_control.connect

			-- Check program arguments
			l_idx := index_of_word_option ("o")

			-- Do job
			if l_idx = 0 then
				purge
				optimize
			else
				optimize
			end

			-- Clean up
			modification.clear_all
			modification.reset
			session_control.disconnect

		rescue
			if is_signal then
				if is_caught (sighup) then
					display_line ("SIGHUP "  + sighup.out  + " caught%N", true, true)
				elseif is_caught (sigint) then
					display_line ("SIGINT "  + sigint.out  + " caught%N", true, true)
				elseif is_caught (sigkill) then
					display_line ("SIGKILL " + sigkill.out + " caught%N", true, true)
					display_line ("Killing myself%N", true, true)
					die (sigkill)
				elseif is_caught (sigterm) then
					display_line ("SIGTERM " + sigterm.out + " caught%N", true, true)
				else
					display_line ("UNKNOWN signal caught%N", true, true)
				end
			end
		end

feature -- Display

	display_line (a_line: STRING; nl, to_syslog: BOOLEAN)
			-- Display `a_line' on screen with a new line if `nl' is True
		local
			dt: detachable DATE_TIME
		do
			dt := create {DATE_TIME}.make_now_utc
			io.put_string (dt.formatted_out (default_date_time_format) + " " + a_line)
			if nl then
				io.put_new_line
			end
			if to_syslog then
				sys_log (log_notice, a_line)
			end
		end

feature -- Basic operations

	purge
			--
		local
			l_query:      detachable STRING
			l_date:       detachable DATE_TIME
			l_first_date: detachable DATE_TIME
			l_offset:     detachable DATE_TIME_DURATION
		do
			create l_offset.make_definite (-days_to_keep, 0, 0, 0)
			create l_date.make_now
			l_first_date := l_date + l_offset
			l_query := "delete from METEO.M_Osservazioni_TR where Data_e_ora < '" + l_first_date.formatted_out (default_date_time_format) + "';"

			session_control.begin
			modification.set_query (l_query)

			if modification.is_ok then
				if modification.is_executable then
					modification.modify (l_query)
					session_control.commit
					display_line ("# affected row(s): " + modification.affected_row_count.out, true, false)
				else
					display_line ("{purge} modification not executable, must rollback", true, false)
					session_control.rollback
				end
			else
				display_line ("{purge} nodification NOT OK", true, false)
				modification.reset
			end
		end

	optimize
			--
		local
			l_query: detachable STRING
		do
			l_query := "optimize table METEO.M_Osservazioni_TR;"

			session_control.begin
			modification.set_query (l_query)

			if modification.is_ok then
				if modification.is_executable then
					modification.modify (l_query)
					session_control.commit
					display_line ("M_Osservazioni_TR optimized", true, false)
				else
					display_line ("Optimization not executable, must rollback", true, false)
					session_control.rollback
				end
			else
				display_line ("{optimize} nodification NOT OK", true, false)
				modification.reset
			end
		end

feature -- dispose

	dispose
			-- `dispose' redefinition
		do
			Precursor {SYSLOG_UNIX_OS}
			Precursor {MEMORY}
		end

feature -- Preferences

	preferences: PREFERENCES
			-- Preferences
	preference_manager: PREFERENCE_MANAGER
			-- Preference manager
	preferences_storage: PREFERENCES_STORAGE_DEFAULT
			-- Preferences storage
	host_pref:          STRING_PREFERENCE
			-- Host preference
	database_pref:      STRING_PREFERENCE
			-- Database name preference
	dbusr_pref:         STRING_PREFERENCE
			-- Database user preference
	dbpwd_pref:         STRING_PREFERENCE
			-- Database password preference
	days_to_keep_pref:  INTEGER_PREFERENCE
			-- Keep observations not too old than `days_to_keep'
	factory:            BASIC_PREFERENCE_FACTORY
			-- Preferences factory

	init_preferences
			-- Loads preferences
		do
			create preferences_storage.make_with_location (preferences_folder + "/" + app_name + "_conf.xml")
			create preferences.make_with_storage (preferences_storage)
			preference_manager := preferences.new_manager (app_name)

			create factory
			host_pref         := factory.new_string_preference_value  (preference_manager,  app_name + ".host",         "localhost")
			database_pref     := factory.new_string_preference_value  (preference_manager,  app_name + ".database",     "METEO")
			dbusr_pref        := factory.new_string_preference_value  (preference_manager,  app_name + ".dbusr",        "root")
			dbpwd_pref        := factory.new_string_preference_value  (preference_manager,  app_name + ".dbpwd",        "METEO")
			days_to_keep_pref := factory.new_integer_preference_value (preference_manager,  app_name + ".days_to_keep", 3)
			db_host           := host_pref.value
			db_user           := dbusr_pref.value
			db_password       := dbpwd_pref.value
			db                := database_pref.value
			days_to_keep      := days_to_keep_pref.value

			display_line ("Host:         " + db_host, true, false)
			display_line ("Database:     " + db, true, false)
			display_line ("Db user:      " + db_user, true, false)
			display_line ("Db password:  " + "*****", true, false)
			display_line ("Days to keep: " + days_to_keep.out, true, false)

			--preferences.save_preferences
		end


feature {NONE} -- Implementation

	db_host:      STRING
			-- Database host
	db_user:      STRING
			-- Database user
	db_password:  STRING
			-- Database password
	db:           STRING
			-- Database name
	days_to_keep: INTEGER
			-- Keep `days_to_keep' days of observations
	session_control: DB_CONTROL
			-- Session manager
	modification:    DB_CHANGE
			-- Database modification tool

	home_folder: STRING_32
			-- Current user home folder
		once
			if( attached item("HOME") as l_home ) then
				create Result.make_from_string (l_home)
			else
				create Result.make_empty
			end
		end

	preferences_folder: STRING_32
			-- Preferences folder
		local
			d: DIRECTORY
		once
			if( home_folder.is_empty ) then
				create Result.make_from_string("./." + app_name)
			else
				create Result.make_from_string(home_folder + "/." + app_name)
			end

			create d.make_with_name (Result)
			if not d.exists then
				d.create_dir
			end
		end

	app_name: STRING
			-- `Current' application name
		do
			Result := "purge_rt_obs"
		end

end
