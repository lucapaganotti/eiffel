note
	description: "Summary description for {CBFUNC_TYPE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CBFUNC_TYPE

feature -- CBFunc_t

	callback (pi: INTEGER user_gpio: NATURAL level: NATURAL tick: NATURAL)
			--
		local
			current_addr: POINTER
		do
			current_addr := $Current
			io.put_string ("We're inside callback at address: " + current_addr.to_integer_32.out)
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
			result := $callback
		end

end
