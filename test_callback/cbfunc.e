note
	description: "Summary description for {CBFUNC}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CBFUNC

feature -- CBFunc_t

	cb (pi: INTEGER user_gpio: NATURAL level: NATURAL tick: NATURAL)
			--
		local
			current_addr: POINTER
		do
			current_addr := $Current
			io.put_string ("We're inside cb at address: " + current_addr.to_integer_32.out)
			io.put_new_line
			io.put_string ("pi:        " + pi.out)
			io.put_new_line
			io.put_string ("user_gpio: " + user_gpio.out)
			io.put_new_line
			io.put_string ("level:     " + level.out)
			io.put_new_line
			io.put_string ("tick:      " + tick.out)
			io.put_new_line
		end

	routine: POINTER
		do
			result := $cb
		end

	cbfunc_fp: POINTER
			--
		do
			Result := $cbfunc
		end

	cbfunc1_fp: POINTER
			--
		do
			Result := $cbfunc1
		end

	cbfunc (pi: INTEGER user_gpio: NATURAL edge: NATURAL tick: NATURAL_32)
			--
		local
			current_addr: POINTER
		do
			current_addr := $Current
			io.put_string ("We're inside cbfunc at address: " + current_addr.to_integer_32.out)
			io.put_new_line
			io.put_string ("pi:        " + pi.out)
			io.put_new_line
			io.put_string ("user_gpio: " + user_gpio.out)
			io.put_new_line
			io.put_string ("level:     " + edge.out)
			io.put_new_line
			io.put_string ("tick:      " + tick.out)
			io.put_new_line
		end

	cbfunc1 (pi: INTEGER user_gpio: NATURAL edge: NATURAL tick: NATURAL_32)
			--
		local
			current_addr: POINTER
		do
			current_addr := $Current
			io.put_string ("We're inside cbfunc1 at address: " + current_addr.to_integer_32.out)
			io.put_new_line
			io.put_string ("pi:        " + (pi + 3).out)
			io.put_new_line
			io.put_string ("user_gpio: " + (user_gpio + 1).out)
			io.put_new_line
			io.put_string ("level:     " + (edge + 1).out)
			io.put_new_line
			io.put_string ("tick:      " + (tick + 1).out)
			io.put_new_line
		end

end
