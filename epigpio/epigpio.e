note
	description: "epigpio application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	EPIGPIO

inherit
	ARGUMENTS_32
	PIGPIO_IF2
	rename
		make as make_pigpio
	end

create
	make

-- gpio  5 - ch  1
-- gpio  6 - ch  2
-- gpio 12 - ch  6
-- gpio 13 - ch  3
-- gpio 19 - ch  4
-- gpio 26 - ch  5

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			res: INTEGER
			cb:  INTEGER
			ef:  POINTER
			rf:  POINTER
			ff:  POINTER
			evt: PIGPIO_EVENT
			efn: POINTER
			cid: INTEGER
		do
		    make_pigpio

			create address.make_from_string ("localhost")
			port := 8888
			io.put_string ("Hello Eiffel PIGPIO World!")
			io.put_new_line
			io.put_string (pigpio_version)
			io.put_new_line
			io.put_string (pigpiod_if2_version)
			io.put_new_line

			io.put_string ("Try to connect to pigpiod daemon")
			io.put_new_line
			start (address, port)
			if running then
				ef  := c_pigpiod_if2_get_either_edge_callback
				rf  := c_pigpiod_if2_get_rising_edge_callback
				ff  := c_pigpiod_if2_get_falling_edge_callback
				cb := callback (5, 2, ef)
				if cb < 0  then
					io.put_string ("Unable to set either edge callback")
					io.put_new_line
				else
					io.put_string ("Set either edge callback: " + cb.out)
					io.put_new_line
				end
				cb := callback (5, 0, rf)
				if cb < 0 then
					io.put_string ("Unable to set rising edge callback")
					io.put_new_line
				else
					io.put_string ("Set rising edge callback: " + cb.out)
					io.put_new_line
				end
				cb := callback (5, 1, ff)
				if cb < 0 then
					io.put_string ("Unable to set falling edge callback")
					io.put_new_line
				else
					io.put_string ("Set falling edge callback: " + cb.out)
					io.put_new_line
				end

				res := set_pull_up_down (5, pigpio_pi_pud_off.as_natural_16)
				if write_gpio (5, 0) then
					res := read_gpio (5)
				    io.put_string ("GPIO 5 value: " + res.out)
				    io.put_new_line
				else
					io.put_string ("Error writing GPIO 5 value")
				    io.put_new_line
				end
				{EXECUTION_ENVIRONMENT}.sleep (3000000000)
				if write_gpio (5, 1) then
					res := read_gpio (5)
					io.put_string ("GPIO 5 value: " + res.out)
					io.put_new_line
					{EXECUTION_ENVIRONMENT}.sleep (500000000)
				else
					io.put_string ("Error writing GPIO 5 value")
				    io.put_new_line
				end

				-- remove some callback
				if not callback_cancel (2) then
					io.put_string ("Callback 2 NOT removed")
				    io.put_new_line
				else
					io.put_string ("Callback 2 removed")
				    io.put_new_line
				end

				{EXECUTION_ENVIRONMENT}.sleep (500000000)
				if not callback_cancel (2) then
					io.put_string ("Callback 2 NOT removed")
				    io.put_new_line
				else
					io.put_string ("Callback 2 removed")
				    io.put_new_line
				end

				{EXECUTION_ENVIRONMENT}.sleep (500000000)
				if not callback_cancel (1) then
					io.put_string ("Callback 1 NOT removed")
				    io.put_new_line
				else
					io.put_string ("Callback 1 removed")
				    io.put_new_line
				end

				if write_gpio (5, 0) then
					res := read_gpio (5)
				    io.put_string ("GPIO 5 value: " + res.out)
				    io.put_new_line
				else
					io.put_string ("Error writing GPIO 5 value")
				    io.put_new_line
				end
				{EXECUTION_ENVIRONMENT}.sleep (3000000000)
				if write_gpio (5, 1) then
					res := read_gpio (5)
					io.put_string ("GPIO 5 value: " + res.out)
					io.put_new_line
					{EXECUTION_ENVIRONMENT}.sleep (500000000)
				else
					io.put_string ("Error writing GPIO 5 value")
				    io.put_new_line
				end

				{EXECUTION_ENVIRONMENT}.sleep (3000000000)
				io.put_string ("Create a new event")
				io.put_new_line
				create evt.make_empty
				evt.set_id (1)
				evt.set_name ("New event 1")
				evt.set_description ("New event 1 description")
				efn := c_pigpiod_if2_get_event_callback_example
				io.put_string ("Got event callback address " + evt.callback.out)
				io.put_new_line
				cid := c_pigpiod_if2_event_callback (handle, evt.id, efn)
				io.put_string ("Got event callback id " + evt.callback.out)
				io.put_new_line
				evt.set_callback_id (cid)
				evt.set_callback (efn)

				io.put_string ("Add new event:")
				io.put_new_line
				io.put_string (evt.out)

				add_event (evt)

				io.put_string ("Trigger event " + evt.id.out)
				io.put_new_line

				if trigger_event (evt) then
					{EXECUTION_ENVIRONMENT}.sleep (500000000)
					io.put_string ("Event " + evt.id.out + " triggered")
					io.put_new_line
				else
					io.put_string ("Event " + evt.id.out + " NOT triggered")
					io.put_new_line
				end
				{EXECUTION_ENVIRONMENT}.sleep (3000000000)
				io.put_string ("Cancel callback for event " + evt.id.out)
				io.put_new_line
				if event_callback_cancel (evt.callback_id) then
					{EXECUTION_ENVIRONMENT}.sleep (500000000)
					io.put_string ("Callback for event " + evt.id.out + " cancelled")
					io.put_new_line
				else
					io.put_string ("Callback for event " + evt.id.out + " NOT cancelled")
					io.put_new_line
				end

				{EXECUTION_ENVIRONMENT}.sleep (3000000000)
			end
			stop
		end



	address: STRING
	port:    INTEGER

end
