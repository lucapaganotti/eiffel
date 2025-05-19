note
	description: "Summary description for {ADSB_CLIENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ADSB_CLIENT


feature -- Access

	host:        STRING
	port:        INTEGER
	tracks_path: STRING
	to:          INTEGER

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
		do
			host := h
		end

	set_port (p: INTEGER)
			--
		do
			port := p
		end

	set_tracks_path (tp: STRING)
			--
		do
			tracks_path := tp
		end

	set_timeout (t: INTEGER)
			--
		do
			to := t
		end

end
