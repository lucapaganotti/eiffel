note
	description: "test_callback application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS_32

create
	make

feature -- Initialization

	make
			-- Run application.

		do
			io.put_string ("do callback")
			io.put_new_line
			create callback
			c_set_routine (callback.routine)
			c_set_object ($callback)
			c_do_callback

			io.put_new_line

			create cbfunc

			io.put_string ("do cbfunc with callable object")
			io.put_new_line
			c_set_routine (cbfunc.routine)
			c_set_object ($cbfunc)
			c_do_cbfunc (0, 5, 1, 1234)

			io.put_new_line

			io.put_string ("do cbfunc with function pointer")
			io.put_new_line
			c_set_callback (cbfunc.cbfunc_fp)
			c_set_cbfunc (cbfunc.cbfunc_fp)
			c_call_cbfunc (1, 6, 0, 4321)

			io.put_new_line

			io.put_string ("do cbfunc1 with function pointer")
			io.put_new_line
			c_set_callback (cbfunc.cbfunc1_fp)
			c_set_cbfunc (cbfunc.cbfunc1_fp)
			c_call_cbfunc (1, 6, 0, 4321)

		end

	callback: CALLABLE
	cbfunc:   CBFUNC

feature{NONE} -- C side

	c_set_routine (routine: POINTER)
		external
			"C inline use %"application.h%""
		alias
			"c_set_routine ($routine);"
		end

	c_set_object (obj: POINTER)
		external
			"C inline use %"application.h%""
		alias
			"c_set_object ($obj);"
		end

	c_set_callback (c: POINTER )
		external
			"C inline use %"application.h%""
		alias
			"c_set_callback ($c);"
		end

	c_do_callback
		external
			"C inline use %"application.h%""
		alias
			"c_do_callback();"
		end

	c_do_cbfunc (pi: INTEGER user_gpio: NATURAL level: NATURAL tick: NATURAL)
		external
			"C inline use %"application.h%""
		alias
			"c_do_cbfunc($pi, $user_gpio, $level, $tick);"
		end

	c_set_cbfunc (f: POINTER)
			--
		external
			"C inline use %"application.h%""
		alias
			"c_set_cbfunc($f);"
		end

	c_wean_cbfunc(f: POINTER)
			--
		external
			"C inline use %"application.h%""
		alias
			"c_wean_cbfunc($f);"
		end

	c_call_cbfunc (pi: INTEGER user_gpio: NATURAL edge: NATURAL tick: NATURAL_32)
			--
		external
			"C inline use %"application.h%""
		alias
			"c_call_cbfunc($pi, $user_gpio, $edge, $tick);"
		end






end -- class APPLICATION
