note
	description: "Summary description for {SBS_CONNECTOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SBS_CONNECTOR

inherit
	CONNECTOR

	INET_ADDRESS_FACTORY
	rename
		error as inet_error
	end

create
	make,
	make_with_host,
	make_with_host_and_port

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create s.make
			s.set_receive_buf_size (1024)
			create h.make_empty
			p := default_msg_port
		end

	make_with_host (a_host: STRING)
			--
		require
			attached_a_host: attached a_host
		do
			create s.make_client_by_port (default_msg_port, a_host)
			s.set_receive_buf_size (1024)
			h := a_host
			p := default_msg_port
		end

	make_with_host_and_port (a_host: STRING; a_port: INTEGER)
			--
		require
			attached_a_host: attached a_host
			a_port_valid: a_port >= 1024 and a_port <= 65535
		do
			create s.make_client_by_port (a_port, a_host)
			h := a_host
			p := a_port
		end

feature -- Access

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

	reconnect
			--
		require
			attached_host: attached host
			port_valid: port >= 1024 and port <= 65535
		do
			disconnect
			create s.make_client_by_port (port, host)
			connect
		end

	check_network
			--
		local

		do
			check attached create_from_name (host) as l_peer_address then

			end
		end

feature -- Obsolete

feature -- Inapplicable

feature -- Constants

	default_msg_port: INTEGER = 30003
			--

feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end
