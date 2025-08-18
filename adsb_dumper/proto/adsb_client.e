note
	description: "Summary description for {ADSB_CLIENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ADSB_CLIENT

	inherit
		EXCEPTIONS

feature -- Access

	now:                     DATE_TIME
	last_check:              DATE_TIME
	last_msg:                DATE_TIME

	host:                    STRING
	tracks_path:             STRING
	to:                      INTEGER_32
	max_seconds_between_msg: INTEGER_32

	logger:                  LOG_LOGGING_FACILITY
	ref_arpt:                STRING

	format_double:           FORMAT_DOUBLE

	socket:                  detachable ADSB_NETWORK_STREAM_SOCKET

	running:                 BOOLEAN

	dump_file:               DUMP_FILE

feature -- Status

	is_endpoint_reachable: BOOLEAN
			--
		local
			af: INET_ADDRESS_FACTORY
		do
			create af
			Result := attached af.create_from_name (host)
		end

feature {NONE} -- Output



	make_dump_file_name (t: DATE_TIME): STRING
			--
		deferred end

feature -- Operations

	start
			--
		deferred end

	stop
			--
		deferred end

	process
			--
		deferred end

feature -- Commands

	set_host (h: STRING)
			--
		require
			h_attached: attached h
		do
			host := h
		ensure
			host_set: host = h
		end

	set_port (p: INTEGER)
			--
		deferred
		end

	set_tracks_path (tp: STRING)
			--
		do
			tracks_path := tp
		end

	set_timeout (t: INTEGER_32)
			--
		do
			to := t
		end

	set_max_seconds_between_msg (t: INTEGER_32)
			--
		do
			max_seconds_between_msg := t
		end

	set_logger (l: LOG_LOGGING_FACILITY)
			--
		do
			logger := l
		end

	set_reference_airport (a: STRING)
			--
		require
			a_attached: attached a
		do
			ref_arpt := a
		ensure
			airport_set: ref_arpt = A
		end

	set_dump_file (f: DUMP_FILE)
			--
		require
			f_attached: attached f
		do
			dump_file := f
		ensure
			dump_file_set: dump_file.is_equal (f)
		end

end

