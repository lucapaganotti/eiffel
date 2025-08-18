note
	description: "Summary description for {ADSB_NETWORK_STREAM_SOCKET}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ADSB_NETWORK_STREAM_SOCKET

	inherit
		NETWORK_STREAM_SOCKET
		redefine
			make_empty, accept
		end

create
	make, make_client_by_address_and_port

feature {NONE} -- Initialization

	make_empty
			-- Initialization for `Current'.
		do
			Precursor
		end

	accept
			--
		do

		end

feature -- Status

	set_sock_opt_keep_alive_on
			--
		do
			c_set_sock_opt_int (fd, level_iproto_tcp, so_keep_alive, 1)
		end

	set_sock_opt_keep_alive_off
			--
		do
			c_set_sock_opt_int (fd, level_iproto_tcp, so_keep_alive, 0)
		end

	set_sock_opt_recv_buffer_size (s: INTEGER)
			--
		do
			c_set_sock_opt_int (fd, level_sol_socket, so_rcv_buf, s)
		end

	get_sock_opt_int (fdesc, level, opt: INTEGER_32): INTEGER_32
			--
		do
			Result := c_get_sock_opt_int (fdesc, level, opt)
		end

end

