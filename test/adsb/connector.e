note
	description: "Summary description for {CONNECTOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONNECTOR

feature -- Access

	host: like h
			--
		do
			Result := h
		end

	port: like p
			--
		do
			Result := p
		end

	raw_socket: like s
			--
		do
			Result := s
		end

feature -- Measurement

feature -- Status report

	connected: BOOLEAN
			--
		do
			Result := s.is_connected
		end

	has_error: BOOLEAN
			--
		do
			Result := s.was_error
		end

	error: STRING
			--
		do
			Result := etag + colon.out + space.out + s.error_number.out + space.out + hyphen.out + space.out + s.error
		end

	last_string: STRING
			--
		require
			attached_socket: attached raw_socket
		do
			Result := s.last_string
		end

feature -- Status setting

	set_host (a_host: like h)
			--
		require
			attached_a_host: attached a_host
		do
			h := a_host
		ensure
			attached_host: attached host
			host_set: host.is_equal (a_host)
		end

	set_port (a_port: like p)
			--
		require
			a_port_valid: a_port >= 1024 and a_port <= 65535
		do
			p := a_port
		ensure
			port_set: p = a_port
		end

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

	connect
			--
		require
			attached_socket: attached raw_socket
			host_set: not host.is_empty
			port_valid: port >= 1024 and port <= 65535
		do
			s.connect
		end

	disconnect
			--
		require
			attached_socket: attached raw_socket
		do
			if s.is_open_read then
				s.cleanup
			end
		end

	read_line
			--
		require
			attached_socket: attached raw_socket
			connected_socket: connected
		do
			s.read_line
		end

feature -- Obsolete

feature -- Inapplicable

feature -- Constants

	space: CHARACTER = ' '
			--

	colon: CHARACTER = ':'
			--

	hyphen: CHARACTER = '-'
			--

	etag: STRING = "E"
			--


feature {NONE} -- Implementation

	h: STRING
			-- `host`

	p: INTEGER
			-- `port`

	s: NETWORK_STREAM_SOCKET
			-- Underlying socket


invariant
	invariant_clause: True -- Your invariant here

end
