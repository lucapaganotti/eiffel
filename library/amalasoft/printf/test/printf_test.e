indexing
	description	: "System's root class"
	date: "$Date$"
	revision: "$Revision$"

class PRINTF_TEST

inherit
	AEL_PRINTF

create
	make

feature -- Initialization

	make is
			-- Run application.
		do
			create tests_passed.make
			create tests_failed.make
			show_expected_on_pass := True

			exec_arg_count_test1
			exec_percent_test1
			exec_percent_test2
			exec_percent_test3
			exec_string_test1
			exec_string_test2
			exec_string_test3
			exec_string_test4
			exec_string_test5
			exec_integer_test1
			exec_integer_test2
			exec_integer_test3
			exec_float_test1
			exec_float_test2
			exec_binary_test1
			exec_binary_test2
			exec_octal_test1
			exec_octal_test2
			exec_octal_test3
			exec_octal_test4
			exec_octal_test5
			exec_octal_test6
			exec_octal_test7
			exec_boolean_test1
			exec_hex_test1
			exec_hex_test2
			exec_hex_test3
			exec_hex_test4
			exec_hex_test5
			exec_hex_test6
			exec_hex_test7
			exec_char_test1
			exec_char_test2
			exec_char_test3
			exec_char_test4
			exec_unsigned_test1
			exec_unsigned_test2
			exec_unsigned_test3
			exec_unsigned_test4
			exec_unsigned_test5
			exec_list_test1
			exec_list_test2
			exec_list_test3
			exec_list_test4
			exec_list_test5
			exec_list_test6
			exec_solo_test1
			exec_solo_test2
			exec_verbatim_test1

			report_results
		end

	--|--------------------------------------------------------------

	exec_arg_count_test1 is
		local
			ta: ARRAY [INTEGER_32]
			v1, v2, v3: INTEGER_32
			test_name, fmt, ok_out, t_out: STRING
			desc: STRING
		do
			test_name := "Arg count test 1"
			desc := "Single integer arg in fmt; 0 and more args"
			fmt := "*%%d*"
			v1 := 99
			ok_out := "*99*"
			ta := << v1 >>
			t_out := aprintf (fmt, <<v1>>)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, <<v1, v2, v3>>)
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, << >>)
			record_result (fmt, t_out, "*Void*", test_name, 3, desc)
			t_out := aprintf (fmt, <<v1, v2>>)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)
			t_out := aprintf (fmt, v1)
			record_result (fmt, t_out, ok_out, test_name, 5, desc)
		end

	--|--------------------------------------------------------------

	exec_percent_test1 is
		local
			ta: ARRAY [INTEGER_32]
			tlist: LINKED_LIST [INTEGER_32]
			v1: INTEGER_32
			test_name, fmt, ok_out, t_out: STRING
			desc: STRING
		do
			test_name := "Percent test 1"
			desc := "Literal percent, single int fmt and argument"
			fmt := "%%d%%"
			v1 := 99
			ok_out := "99%%"
			ta := << v1 >>
			create tlist.make
			tlist.extend (v1)
			t_out := aprintf (fmt, v1)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, <<v1>>)
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, [v1])
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)
			t_out := aprintf (fmt, tlist)
			record_result (fmt, t_out, ok_out, test_name, 5, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 6, desc)
			t_out := aprintf (fmt, <<Void>>)
			record_result (fmt, t_out, "Void%%", test_name, 7, desc)
		end

	--|--------------------------------------------------------------

	exec_percent_test2 is
		local
			ta: ARRAY [INTEGER_32]
			tlist: LINKED_LIST [INTEGER_32]
			v1: INTEGER_32
			test_name, fmt, ok_out, t_out: STRING
			desc: STRING
		do
			test_name := "Percent test 2"
			desc := "Literal percent as next-to-last char"
			fmt := "%%d%% "
			v1 := 99
			ok_out := "99%% "
			ta := << v1 >>
			create tlist.make
			tlist.extend (v1)
			t_out := aprintf (fmt, v1)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, <<v1>>)
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, [v1])
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)
			t_out := aprintf (fmt, tlist)
			record_result (fmt, t_out, ok_out, test_name, 5, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 6, desc)
			t_out := aprintf (fmt, <<Void>>)
			record_result (fmt, t_out, "Void%% ", test_name, 7, desc)
		end

	--|--------------------------------------------------------------

	exec_percent_test3 is
		local
			test_name, fmt, t_out: STRING
			desc: STRING
		do
			test_name := "Percent test 3"
			desc := "Percent followed by non-formatting characters"
			fmt := "%%a%%A%%C%%D%%e%%E%%F%%G%%g%%h%%H%%I%%i%%J%%j%%k%%K%%l%%m%%M"
			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 1, desc)
			fmt := "%%n%%O%%P%%p%%q%%Q%%R%%r%%S%%t%%U%%v%%V%%w%%W%%X%%y%%Y%%z%%Z"
			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 2, desc)
			fmt := "%%0%%1%%2%%3%%4%%5%%6%%7%%8%%9%%0"
			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 3, desc)
			fmt := "%%!%%@%%#%%$%%^%%&%%*%%(%%)%%-%%_%%+%%=%%{%%}%%[%%]%%|%%\"
			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 4, desc)
			fmt := "%%:%%;%%<%%>%%,%%.%%?%%/%%~%%`"
			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 5, desc)
		end

	--|--------------------------------------------------------------

	exec_string_test1 is
		local
			ta: ARRAY [STRING]
			tl: LINKED_LIST [STRING]
			test_name, fmt, ok_out, ts, t_out: STRING
			desc: STRING
		do
			test_name := "String test 1"
			desc := "Single argument"
			fmt := "%%s"
			ok_out := "foo"
			ts := "foo"
			create ta.make (0, 1)
			create tl.make
			ta.put (ts, 1)
			tl.extend (ts)
			t_out := aprintf (fmt, ts)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, <<ts>>)
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, [ts])
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)
			t_out := aprintf (fmt, tl)
			record_result (fmt, t_out, ok_out, test_name, 5, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 6, desc)
			t_out := aprintf (fmt, <<Void>>)
			record_result (fmt, t_out, "Void", test_name, 7, desc)
		end

	--|--------------------------------------------------------------

	exec_string_test2 is
		local
			ta: ARRAY [STRING]
			tl: LINKED_LIST [STRING]
			test_name, fmt, ok_out, ts, t_out: STRING
			desc: STRING
		do
			desc := ""
			test_name := "String test 2"
			fmt := "*%%-10s*"
			ok_out := "*foo       *"
			ts := "foo"
			create ta.make (0, 1)
			create tl.make
			ta.put (ts, 1)
			tl.extend (ts)
			t_out := aprintf (fmt, ts)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, <<ts>>)
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, [ts])
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)
			t_out := aprintf (fmt, tl)
			record_result (fmt, t_out, ok_out, test_name, 5, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 6, desc)
			t_out := aprintf (fmt, <<Void>>)
			record_result (fmt, t_out, "*Void      *", test_name, 7, desc)
		end

	--|--------------------------------------------------------------

	exec_string_test3 is
		local
			ta: ARRAY [STRING]
			tl: LINKED_LIST [STRING]
			test_name, fmt, ok_out, ts, t_out: STRING
			desc: STRING
		do
			desc := ""
			test_name := "String test 3"
			fmt := "*%%10s*"
			ok_out := "*       foo*"
			ts := "foo"
			create ta.make (0, 1)
			create tl.make
			ta.put (ts, 1)
			tl.extend (ts)
			t_out := aprintf (fmt, ts)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, <<ts>>)
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, [ts])
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)
			t_out := aprintf (fmt, tl)
			record_result (fmt, t_out, ok_out, test_name, 5, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 6, desc)
			t_out := aprintf (fmt, <<Void>>)
			record_result (fmt, t_out, "*      Void*", test_name, 7, desc)
		end

	--|--------------------------------------------------------------

	exec_string_test4 is
		local
			ta: ARRAY [STRING]
			tl: LINKED_LIST [STRING]
			test_name, fmt, ok_out, ts, t_out: STRING
			desc: STRING
		do
			desc := ""
			test_name := "String test 4"
			fmt := "*%%=11s*"
			ok_out := "*    foo    *"
			ts := "foo"
			create ta.make (0, 1)
			create tl.make
			ta.put (ts, 1)
			tl.extend (ts)
			t_out := aprintf (fmt, ts)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, <<ts>>)
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, [ts])
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)
			t_out := aprintf (fmt, tl)
			record_result (fmt, t_out, ok_out, test_name, 5, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 6, desc)
			t_out := aprintf (fmt, <<Void>>)
			record_result (fmt, t_out, "*   Void    *", test_name, 7, desc)
		end

	--|--------------------------------------------------------------

	exec_string_test5 is
		local
			ta: ARRAY [STRING]
			tl: LINKED_LIST [STRING]
			test_name, fmt, ok_out, ts1, ts2, t_out: STRING
			desc: STRING
		do
			desc := ""
			test_name := "String test 5"
			fmt := "*%%=5s*%%5s"
			ok_out := "* foo *" + Ks_alpha_upper
			ts1 := "foo"
			ts2 := Ks_alpha_upper
			ta := << ts1, ts2 >>
			create tl.make
			tl.fill (ta)
			t_out := aprintf (fmt, <<ts1, ts2>>)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, [ts1, ts2])
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, tl)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 5, desc)
			t_out := aprintf (fmt, <<ts1, Void>>)
			record_result (fmt, t_out, "* foo * Void", test_name, 6, desc)
			t_out := aprintf (fmt, <<Void, ts2>>)
			record_result (fmt, t_out, "*Void *" + ts2, test_name, 7, desc)
			t_out := aprintf (fmt, <<Void, Void>>)
			record_result (fmt, t_out, "*Void * Void", test_name, 8, desc)
		end

	--|--------------------------------------------------------------

	exec_integer_test1 is
		local
			ta: ARRAY [INTEGER]
			tl: LINKED_LIST [INTEGER]
			v1: INTEGER
			test_name, fmt, ok_out, t_out: STRING
			desc: STRING
		do
			desc := ""
			test_name := "Integer test 1"
			fmt := "*%%d*"
			v1 := 1492
			ok_out := "*" + v1.out +"*"
			ta := << v1 >>
			create tl.make
			tl.fill (ta)
			t_out := aprintf (fmt, v1)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, <<v1>>)
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, [v1])
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)
			t_out := aprintf (fmt, tl)
			record_result (fmt, t_out, ok_out, test_name, 5, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 6, desc)
		end

	--|--------------------------------------------------------------

	exec_integer_test2 is
		local
			ta: ARRAY [INTEGER]
			tl: LINKED_LIST [INTEGER]
			v1, v2: INTEGER
			test_name, fmt, ok_out, t_out: STRING
			desc: STRING
		do
			desc := ""
			test_name := "Integer test 2"
			fmt := "*%%8d%%8d*"
			v1 := 1492
			v2 := 123456789
			ok_out := "*    " + v1.out + v2.out + "*"
			ta := << v1, v2 >>
			create tl.make
			tl.fill (ta)
			t_out := aprintf (fmt, <<v1, v2>>)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, [v1, v2])
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, tl)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 5, desc)
		end

	--|--------------------------------------------------------------

	exec_integer_test3 is
		local
			ta: ARRAY [INTEGER]
			tl: LINKED_LIST [INTEGER]
			v1, v2: INTEGER
			test_name, fmt, ok_out, t_out: STRING
			desc: STRING
		do
			desc := "Decimal integer with decoration"
			test_name := "Integer test 3"
			fmt := "*%%#d*%%8d*"
			v1 := 123456789
			v2 := 123456789
			ok_out := "*123,456,789*" + v2.out + "*"
			ta := << v1, v2 >>
			create tl.make
			tl.fill (ta)
			t_out := aprintf (fmt, <<v1, v2>>)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, [v1, v2])
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, tl)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 5, desc)
		end

	--|--------------------------------------------------------------

	exec_float_test1 is
		local
			ta: ARRAY [REAL]
			tl: LINKED_LIST [REAL]
			v1, v2: REAL
			test_name, fmt, ok_out, t_out: STRING
			desc: STRING
		do
			desc := ""
			test_name := "Float test 1"
			fmt := "*%%3.2f*%%3.2f"
			v1 := 12345.6789
			v2 := 0.123456789
			ok_out := "*12345.67*0.12"
			ta := << v1, v2 >>
			create tl.make
			tl.fill (ta)
			t_out := aprintf (fmt, <<v1, v2>>)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, [v1, v2])
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, tl)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 5, desc)
		end

	--|--------------------------------------------------------------

	exec_float_test2 is
		local
			ta: ARRAY [REAL_64]
			tl: LINKED_LIST [REAL_64]
			v1, v2: REAL_64
			test_name, fmt, ok_out, t_out: STRING
			desc: STRING
		do
			desc := ""
			test_name := "Float test 2"
			fmt := "*%%12.4f*%%12.4f"
			v1 := 12345.6789
			v2 := 0.123456789
			ok_out := "*  12345.6789*      0.1234"
			ta := << v1, v2 >>
			create tl.make
			tl.fill (ta)
			t_out := aprintf (fmt, <<v1, v2>>)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, [v1, v2])
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, tl)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 5, desc)
		end

	--|--------------------------------------------------------------

	exec_binary_test1 is
		local
			ta: ARRAY [INTEGER_64]
			tl: LINKED_LIST [INTEGER_64]
			v1, v2: INTEGER_64
			test_name, fmt, ok_out, t_out: STRING
			desc: STRING
		do
			desc := "Decorated, zero-filled"
			test_name := "Binary test 1"
			fmt := "*%%#08b*%%#08b"
			v1 := 19
			v2 := 123456789
			ok_out := "*0010011b*111"+"01011011"+"11001101"+"00010101b"
			ta := << v1, v2 >>
			create tl.make
			tl.fill (ta)
			t_out := aprintf (fmt, <<v1, v2>>)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, [v1, v2])
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, tl)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 5, desc)
		end

	--|--------------------------------------------------------------

	exec_binary_test2 is
		local
			ta: ARRAY [INTEGER_64]
			tl: LINKED_LIST [INTEGER_64]
			v1, v2: INTEGER_64
			test_name, fmt, ok_out, t_out: STRING
			desc: STRING
		do
			desc := "Undecorated, zero-filled"
			test_name := "Binary test 2"
			fmt := "*%%08b*%%08b"
			v1 := 19
			v2 := 123456789
			ok_out := "*00010011*111"+"01011011"+"11001101"+"00010101"
			ta := << v1, v2 >>
			create tl.make
			tl.fill (ta)
			t_out := aprintf (fmt, <<v1, v2>>)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, [v1, v2])
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, tl)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 5, desc)
		end

	--|--------------------------------------------------------------

	exec_octal_test1 is
		local
			ta: ARRAY [INTEGER_64]
			tl: LINKED_LIST [INTEGER_64]
			v1, v2: INTEGER_64
			test_name, fmt, ok_out, t_out: STRING
			desc: STRING
		do
			desc := "Shorter and longer than field width, no decoration"
			test_name := "Octal test 1"
			fmt := "*%%8o*%%8o"
			v1 := 19
			v2 := 123456789
			ok_out := "*      23*726746425"
			ta := << v1, v2 >>
			create tl.make
			tl.fill (ta)
			t_out := aprintf (fmt, <<v1, v2>>)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, [v1, v2])
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, tl)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 5, desc)
		end

	--|--------------------------------------------------------------

	exec_octal_test2 is
		local
			ta: ARRAY [INTEGER_64]
			tl: LINKED_LIST [INTEGER_64]
			v1, v2: INTEGER_64
			test_name, fmt, ok_out, t_out: STRING
			desc: STRING
		do
			desc := ""
			test_name := "Octal test 2"
			fmt := "*%%#8o*%%#8o"
			v1 := 19
			v2 := 123456789
			ok_out := "*     023*0726746425"
			ta := << v1, v2 >>
			create tl.make
			tl.fill (ta)
			t_out := aprintf (fmt, <<v1, v2>>)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, [v1, v2])
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, tl)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 5, desc)
		end

	--|--------------------------------------------------------------

	exec_octal_test3 is
		local
			ta: ARRAY [INTEGER_64]
			tl: LINKED_LIST [INTEGER_64]
			v1, v2: INTEGER_64
			test_name, fmt, ok_out, t_out: STRING
			desc: STRING
		do
			desc := "64 bit integer, zero-fill"
			test_name := "Octal test 3"
			fmt := "*%%#08o*%%#08o"
			v1 := 19
			v2 := 123456789
			ok_out := "*00000023*0726746425"
			ta := << v1, v2 >>
			create tl.make
			tl.fill (ta)
			t_out := aprintf (fmt, <<v1, v2>>)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, [v1, v2])
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, tl)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 5, desc)
		end

	--|--------------------------------------------------------------

	exec_octal_test4 is
		local
			ta: ARRAY [INTEGER_64]
			tl: LINKED_LIST [INTEGER_64]
			v1, v2: INTEGER_64
			test_name, fmt, ok_out, t_out: STRING
			desc: STRING
		do
			desc := "64 bit integer, wide zero-fill"
			test_name := "Octal test 4"
			fmt := "*%%#024o*%%#024o"
			v1 := -19 -- 1777777777777777777755
			v2 := 12345678901 -- 133767016065
			ok_out := "*001777777777777777777755*000000000000133767016065"
			ta := << v1, v2 >>
			create tl.make
			tl.fill (ta)
			t_out := aprintf (fmt, <<v1, v2>>)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, [v1, v2])
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, tl)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 5, desc)
		end

	--|--------------------------------------------------------------

	exec_octal_test5 is
		local
			ta: ARRAY [INTEGER_32]
			tl: LINKED_LIST [INTEGER_32]
			v1, v2: INTEGER_32
			test_name, fmt, ok_out, t_out: STRING
			desc: STRING
		do
			desc := "32 bit integer, default decoration"
			test_name := "Octal test 5"
			fmt := "*%%#16o*%%#16o"
			v1 := -19 -- 37777777755
			v2 := 123456789 -- 726746425
			ok_out := "*    037777777755*      0726746425"
			ta := << v1, v2 >>
			create tl.make
			tl.fill (ta)
			t_out := aprintf (fmt, <<v1, v2>>)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, [v1, v2])
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, tl)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 5, desc)
		end

	--|--------------------------------------------------------------

	exec_octal_test6 is
		local
			ta: ARRAY [INTEGER_8]
			tl: LINKED_LIST [INTEGER_8]
			v1, v2: INTEGER_8
			test_name, fmt, ok_out, t_out: STRING
			desc: STRING
		do
			desc := "8 bit integer, default decoration"
			test_name := "Octal test 6"
			fmt := "*%%#6o*%%#6o"
			v1 := -19 -- 355
			v2 := 123 -- 173
			ok_out := "*  0355*  0173"
			ta := << v1, v2 >>
			create tl.make
			tl.fill (ta)
			t_out := aprintf (fmt, <<v1, v2>>)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, [v1, v2])
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, tl)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 5, desc)
		end

	--|--------------------------------------------------------------

	exec_octal_test7 is
		local
			ta: ARRAY [INTEGER_16]
			tl: LINKED_LIST [INTEGER_16]
			v1, v2: INTEGER_16
			test_name, fmt, ok_out, t_out: STRING
			desc: STRING
		do
			desc := "16 bit integer, default decoration"
			test_name := "Octal test 7"
			fmt := "*%%#10o*%%#10o"
			v1 := -19 -- 177755
			v2 := 12345 -- 30071
			ok_out := "*   0177755*    030071"
			ta := << v1, v2 >>
			create tl.make
			tl.fill (ta)
			t_out := aprintf (fmt, <<v1, v2>>)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, [v1, v2])
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, tl)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 5, desc)
		end

	--|--------------------------------------------------------------

	exec_boolean_test1 is
		local
			ta: ARRAY [BOOLEAN]
			tl: LINKED_LIST [BOOLEAN]
			test_name, fmt, ok_out, t_out: STRING
			desc: STRING
		do
			desc := ""
			test_name := "Boolean test 1"
			fmt := "*%%B*%%B"
			ok_out := "*True*False"
			ta := << True, False >>
			create tl.make
			tl.fill (ta)
			t_out := aprintf (fmt, <<True, False>>)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, [True, False])
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, tl)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 5, desc)
		end

	--|--------------------------------------------------------------

	exec_hex_test1 is
		local
			ta: ARRAY [INTEGER_32]
			tl: LINKED_LIST [INTEGER_32]
			v1: INTEGER_32
			test_name, fmt, ok_out, t_out: STRING
			desc: STRING
		do
			desc := ""
			test_name := "Hex test 1"
			fmt := "*%%x*"
			v1 := 1492
			ok_out := "*5d4*"
			ta := << v1 >>
			create tl.make
			tl.fill (ta)
			t_out := aprintf (fmt, v1)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, <<v1>>)
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, [v1])
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)
			t_out := aprintf (fmt, tl)
			record_result (fmt, t_out, ok_out, test_name, 5, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 6, desc)
		end

--|--------------------------------------------------------------

	exec_hex_test2 is
		local
			ta: ARRAY [INTEGER_32]
			tl: LINKED_LIST [INTEGER_32]
			v1, v2: INTEGER_32
			test_name, fmt, ok_out, t_out: STRING
			desc: STRING
		do
			desc := ""
			test_name := "Hex test 2"
			fmt := "*%%8x%%8x*"
			v1 := 1492 -- 5d4
			v2 := 123456789 -- 75bcd15
			ok_out := "*     5d4 75bcd15*"
			ta := << v1, v2 >>
			create tl.make
			tl.fill (ta)
			t_out := aprintf (fmt, <<v1, v2>>)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, [v1, v2])
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, tl)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 5, desc)
		end

	--|--------------------------------------------------------------

	exec_hex_test3 is
		local
			ta: ARRAY [INTEGER_32]
			tl: LINKED_LIST [INTEGER_32]
			v1, v2: INTEGER_32
			test_name, fmt, ok_out, t_out: STRING
			desc: STRING
		do
			desc := ""
			test_name := "Hex test 3"
			fmt := "*%%#10x%%#10x*"
			v1 := 1492 -- 5d4
			v2 := 123456789 -- 75bcd15
			ok_out := "*     0x5d4 0x75bcd15*"
			ta := << v1, v2 >>
			create tl.make
			tl.fill (ta)
			t_out := aprintf (fmt, <<v1, v2>>)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, [v1, v2])
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, tl)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 5, desc)
		end

	--|--------------------------------------------------------------

	exec_hex_test4 is
		local
			ta: ARRAY [INTEGER_32]
			tl: LINKED_LIST [INTEGER_32]
			v1, v2: INTEGER_32
			test_name, fmt, ok_out, t_out: STRING
			desc: STRING
		do
			desc := ""
			test_name := "Hex test 4"
			fmt := "*%%#20x%%#20x*"
			v1 := -1492 -- fffffffffffffa2c
			v2 := 123456789 -- 75bcd15
			ok_out := "*          0xfffffa2c           0x75bcd15*"
			ta := << v1, v2 >>
			create tl.make
			tl.fill (ta)
			t_out := aprintf (fmt, <<v1, v2>>)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, [v1, v2])
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, tl)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 5, desc)
		end

	--|--------------------------------------------------------------

	exec_hex_test5 is
		local
			ta: ARRAY [INTEGER_64]
			tl: LINKED_LIST [INTEGER_64]
			v1, v2: INTEGER_64
			test_name, fmt, ok_out, t_out: STRING
			desc: STRING
		do
			desc := ""
			test_name := "Hex test 5"
			fmt := "*%%#20x%%#20x*"
			v1 := -1492 -- fffffffffffffa2c
			v2 := 12_345_678_901 -- 2dfdc1c35
			ok_out := "*  0xfffffffffffffa2c         0x2dfdc1c35*"
			ta := << v1, v2 >>
			create tl.make
			tl.fill (ta)
			t_out := aprintf (fmt, <<v1, v2>>)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, [v1, v2])
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, tl)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 5, desc)
		end

	--|--------------------------------------------------------------

	exec_hex_test6 is
		local
			ta: ARRAY [INTEGER_8]
			tl: LINKED_LIST [INTEGER_8]
			v1, v2: INTEGER_8
			test_name, fmt, ok_out, t_out: STRING
			desc: STRING
		do
			desc := ""
			test_name := "Hex test 6"
			fmt := "*%%#10x%%#10x*"
			v1 := -109 -- 93
			v2 := 123 -- 7b
			ok_out := "*      0x93      0x7b*"
			ta := << v1, v2 >>
			create tl.make
			tl.fill (ta)
			t_out := aprintf (fmt, <<v1, v2>>)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, [v1, v2])
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, tl)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 5, desc)
		end

	--|--------------------------------------------------------------

	exec_hex_test7 is
		local
			ta: ARRAY [INTEGER_16]
			tl: LINKED_LIST [INTEGER_16]
			v1, v2: INTEGER_16
			test_name, fmt, ok_out, t_out: STRING
			desc: STRING
		do
			desc := ""
			test_name := "Hex test 7"
			fmt := "*%%#12x%%#12x*"
			v1 := -1090 -- fbbe
			v2 := 12345 -- 3039
			ok_out := "*      0xfbbe      0x3039*"
			ta := << v1, v2 >>
			create tl.make
			tl.fill (ta)
			t_out := aprintf (fmt, <<v1, v2>>)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, [v1, v2])
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, tl)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 5, desc)
		end

	--|--------------------------------------------------------------

	exec_char_test1 is
		local
			ta: ARRAY [CHARACTER_8]
			tl: LINKED_LIST [CHARACTER_8]
			v1, v2, v3: CHARACTER_8
			test_name, fmt, ok_out, t_out: STRING
			desc: STRING
		do
			desc := "Multiple chars in line"
			test_name := "Char test 1"
			fmt := "*%%c%%c%%c*"
			v1 := 'a'
			v2 := 'b'
			v3 := 'c'
			ok_out := "*abc*"
			ta := << v1, v2, v3 >>
			create tl.make
			tl.fill (ta)
			t_out := aprintf (fmt, <<v1, v2, v3>>)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, [v1, v2, v3])
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, tl)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 5, desc)
		end

	--|--------------------------------------------------------------

	exec_char_test2 is
		local
			ta: ARRAY [CHARACTER_8]
			tl: LINKED_LIST [CHARACTER_8]
			v1, v2, v3: CHARACTER_8
			test_name, fmt, ok_out, t_out: STRING
			desc: STRING
		do
			desc := "Non-printable characters"
			test_name := "Char test 2"
			fmt := "*%%c%%c%%c*"
			v1 := ''
			v2 := ''
			v3 := ''
			ok_out := "**"
			ta := << v1, v2, v3 >>
			create tl.make
			tl.fill (ta)
			t_out := aprintf (fmt, <<v1, v2, v3>>)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, [v1, v2, v3])
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, tl)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 5, desc)
		end

	--|--------------------------------------------------------------

	exec_char_test3 is
		local
			ta: ARRAY [CHARACTER_8]
			tl: LINKED_LIST [CHARACTER_8]
			v1, v2, v3: CHARACTER_8
			test_name, fmt, ok_out, t_out: STRING
			desc: STRING
		do
			desc := "Backspace and underline"
			test_name := "Char test 3"
			fmt := "*%%c%%c%%c*"
			v1 := 'a'
			v2 := ''
			v3 := '_'
			ok_out := "*a_*"
			ta := << v1, v2, v3 >>
			create tl.make
			tl.fill (ta)
			t_out := aprintf (fmt, <<v1, v2, v3>>)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, [v1, v2, v3])
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, tl)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 5, desc)
		end

	--|--------------------------------------------------------------

	exec_char_test4 is
		local
			ta: ARRAY [CHARACTER_32]
			tl: LINKED_LIST [CHARACTER_32]
			v1, v2, v3: CHARACTER_32
			test_name, fmt, ok_out, t_out: STRING
			desc: STRING
		do
			desc := "Character 32 basic"
			test_name := "Char test 4"
			fmt := "*%%c%%c%%c*"
			v1 := 'a'
			v2 := 'b'
			v3 := 'c'
			ok_out := "*abc*"
			ta := << v1, v2, v3 >>
			create tl.make
			tl.fill (ta)
			t_out := aprintf (fmt, <<v1, v2, v3>>)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, [v1, v2, v3])
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, tl)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 5, desc)
		end

	--|--------------------------------------------------------------

	exec_unsigned_test1 is
		local
			ta: ARRAY [INTEGER_32]
			tl: LINKED_LIST [INTEGER_32]
			v1: INTEGER_32
			test_name, fmt, ok_out, t_out: STRING
			desc: STRING
		do
			desc := "Single positive INT 32 arg"
			test_name := "Unsigned test 1"
			fmt := "*%%u*"
			v1 := 1492
			ok_out := "*1492*"
			ta := << v1 >>
			create tl.make
			tl.fill (ta)
			t_out := aprintf (fmt, v1)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, <<v1>>)
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, [v1])
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)
			t_out := aprintf (fmt, tl)
			record_result (fmt, t_out, ok_out, test_name, 5, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 6, desc)
		end

	--|--------------------------------------------------------------

	exec_unsigned_test2 is
		local
			ta: ARRAY [INTEGER_32]
			tl: LINKED_LIST [INTEGER_32]
			v1, v2: INTEGER_32
			test_name, fmt, ok_out, t_out: STRING
			desc: STRING
		do
			desc := "2 INT 32 args; One positive, one negative"
			test_name := "Unsigned test 2"
			fmt := "*%%u*%%u*"
			v1 := 1492
			v2 := -1492 -- 4294965804
			ok_out := "*1492*4294965804*"
			ta := << v1, v2 >>
			create tl.make
			tl.fill (ta)
			t_out := aprintf (fmt, v1)
			record_result (fmt, t_out, "*1492*Void*", test_name, 1, desc)
			t_out := aprintf (fmt, <<v1, v2>>)
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, [v1, v2])
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)
			t_out := aprintf (fmt, tl)
			record_result (fmt, t_out, ok_out, test_name, 5, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 6, desc)
		end

	--|--------------------------------------------------------------

	exec_unsigned_test3 is
		local
			ta: ARRAY [INTEGER_64]
			tl: LINKED_LIST [INTEGER_64]
			v1, v2: INTEGER_64
			test_name, fmt, ok_out, t_out: STRING
			desc: STRING
		do
			desc := "2 INT 64 args; One small, one large"
			test_name := "Unsigned test 3"
			fmt := "*%%u*%%u*"
			v1 := 123
			v2 := 4_294_965_804
			ok_out := "*123*4294965804*"
			ta := << v1, v2 >>
			create tl.make
			tl.fill (ta)
			t_out := aprintf (fmt, v1)
			record_result (fmt, t_out, "*123*Void*", test_name, 1, desc)
			t_out := aprintf (fmt, <<v1, v2>>)
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, [v1, v2])
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)
			t_out := aprintf (fmt, tl)
			record_result (fmt, t_out, ok_out, test_name, 5, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 6, desc)
		end

	--|--------------------------------------------------------------

	exec_unsigned_test4 is
		local
			ta: ARRAY [INTEGER_8]
			tl: LINKED_LIST [INTEGER_8]
			v1, v2: INTEGER_8
			test_name, fmt, ok_out, t_out: STRING
			desc: STRING
		do
			desc := "2 INT 8 args; One positive, one negative"
			test_name := "Unsigned test 4"
			fmt := "*%%u*%%u*"
			v1 := 123
			v2 := -123
			ok_out := "*123*133*"
			ta := << v1, v2 >>
			create tl.make
			tl.fill (ta)
			t_out := aprintf (fmt, v1)
			record_result (fmt, t_out, "*123*Void*", test_name, 1, desc)
			t_out := aprintf (fmt, <<v1, v2>>)
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, [v1, v2])
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)
			t_out := aprintf (fmt, tl)
			record_result (fmt, t_out, ok_out, test_name, 5, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 6, desc)
		end

	--|--------------------------------------------------------------

	exec_unsigned_test5 is
		local
			ta: ARRAY [INTEGER_16]
			tl: LINKED_LIST [INTEGER_16]
			v1, v2: INTEGER_16
			test_name, fmt, ok_out, t_out: STRING
			desc: STRING
		do
			desc := "2 INT 16 args; One positive, one negative"
			test_name := "Unsigned test 5"
			fmt := "*%%u*%%u*"
			v1 := 123
			v2 := -123
			ok_out := "*123*65413*"
			ta := << v1, v2 >>
			create tl.make
			tl.fill (ta)
			t_out := aprintf (fmt, v1)
			record_result (fmt, t_out, "*123*Void*", test_name, 1, desc)
			t_out := aprintf (fmt, <<v1, v2>>)
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, [v1, v2])
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)
			t_out := aprintf (fmt, tl)
			record_result (fmt, t_out, ok_out, test_name, 5, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 6, desc)
		end

	--|--------------------------------------------------------------

	exec_list_test1 is
		local
			va: ARRAY [INTEGER_32]
			ta: ARRAY [ARRAY [INTEGER_32]]
			tl: LINKED_LIST [ARRAY [INTEGER_32]]
			v1, v2, v3: INTEGER_32
			tp: TUPLE [INTEGER_32, INTEGER_32, INTEGER_32]
			test_name, fmt, ok_out, t_out: STRING
			desc: STRING
		do
			desc := "List using array of integers, default sep"
			test_name := "List test 1"
			fmt := "%%L"
			v1 := 123
			v2 := 456
			v3 := 789
			ok_out := "123 456 789"
			va := << v1, v2, v3 >>
			ta := << va >>
			create tl.make
			tl.fill (ta)
			t_out := aprintf (fmt, va)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, << <<v1, v2, v3>> >>)
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, [va])
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)
			t_out := aprintf (fmt, tl)
			record_result (fmt, t_out, ok_out, test_name, 5, desc)

			tp := [v1, v2, v3]
			-- List does not accept a TUPLE, must be CONTAINER
			t_out := aprintf (fmt, tp)
			ok_out := "** Arg Type Mismatch **"
			record_result (fmt, t_out, ok_out, test_name, 6, desc)
			-- List element is a tuple, and its 'out' is tagged out
			t_out := aprintf (fmt, <<tp>>)
			ok_out := tp.out
			record_result (fmt, t_out, ok_out, test_name, 7, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 8, desc)
		end

	--|--------------------------------------------------------------

	exec_list_test2 is
		local
			vl: TWO_WAY_LIST [INTEGER_32]
			ta: ARRAY [TWO_WAY_LIST [INTEGER_32]]
			tl: LINKED_LIST [TWO_WAY_LIST [INTEGER_32]]
			v1, v2, v3: INTEGER_32
			test_name, fmt, ok_out, t_out: STRING
			desc: STRING
		do
			desc := "List using 2-way list of integers, default sep"
			test_name := "List test 2"
			fmt := "*%%L*"
			v1 := 123
			v2 := 456
			v3 := 789
			ok_out := "*123 456 789*"
			create vl.make
			vl.fill (<< v1, v2, v3 >>)
			ta := << vl >>
			create tl.make
			tl.fill (ta)
			t_out := aprintf (fmt, vl)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, << <<v1, v2, v3>> >>)
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, [vl])
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)
			t_out := aprintf (fmt, tl)
			record_result (fmt, t_out, ok_out, test_name, 5, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 6, desc)
		end

	--|--------------------------------------------------------------

	exec_list_test3 is
		local
			vl: TWO_WAY_LIST [INTEGER_32]
			ta: ARRAY [TWO_WAY_LIST [INTEGER_32]]
			tl: LINKED_LIST [TWO_WAY_LIST [INTEGER_32]]
			v1, v2, v3: INTEGER_32
			test_name, fmt, ok_out, t_out: STRING
			desc: STRING
		do
			desc := "List, w/ comma separator using 2-way list of integers"
			test_name := "List test 3"
			fmt := "*%%#,L*"
			v1 := 123
			v2 := 456
			v3 := 789
			ok_out := "*123,456,789*"
			create vl.make
			vl.fill (<< v1, v2, v3 >>)
			ta := << vl >>
			create tl.make
			tl.fill (ta)
			t_out := aprintf (fmt, vl)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, << <<v1, v2, v3>> >>)
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, [vl])
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)
			t_out := aprintf (fmt, tl)
			record_result (fmt, t_out, ok_out, test_name, 5, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 6, desc)
		end

	--|--------------------------------------------------------------

	exec_list_test4 is
		local
			vl: TWO_WAY_LIST [INTEGER_32]
			ta: ARRAY [TWO_WAY_LIST [INTEGER_32]]
			tl: LINKED_LIST [TWO_WAY_LIST [INTEGER_32]]
			v1, v2, v3: INTEGER_32
			test_name, fmt, ok_out, t_out: STRING
			desc: STRING
		do
			desc := "List, comma sep, w/o decoratio; 2-way list of integers"
			test_name := "List test 4"
			fmt := "*%%,L*"
			v1 := 123
			v2 := 456
			v3 := 789
			ok_out := "*123,456,789*"
			create vl.make
			vl.fill (<< v1, v2, v3 >>)
			ta := << vl >>
			create tl.make
			tl.fill (ta)
			t_out := aprintf (fmt, vl)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, << <<v1, v2, v3>> >>)
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, [vl])
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)
			t_out := aprintf (fmt, tl)
			record_result (fmt, t_out, ok_out, test_name, 5, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 6, desc)
		end

	--|--------------------------------------------------------------

	exec_list_test5 is
		local
			vl: TWO_WAY_LIST [INTEGER_32]
			ta: ARRAY [TWO_WAY_LIST [INTEGER_32]]
			tl: LINKED_LIST [TWO_WAY_LIST [INTEGER_32]]
			v1, v2, v3: INTEGER_32
			test_name, fmt, ok_out, t_out: STRING
			desc: STRING
		do
			desc := "List, no sep; 2-way list of integers"
			test_name := "List test 5"
			fmt := "*%%#L*"
			v1 := 123
			v2 := 456
			v3 := 789
			ok_out := "*123456789*"
			create vl.make
			vl.fill (<< v1, v2, v3 >>)
			ta := << vl >>
			create tl.make
			tl.fill (ta)
			t_out := aprintf (fmt, vl)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, << <<v1, v2, v3>> >>)
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, [vl])
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)
			t_out := aprintf (fmt, tl)
			record_result (fmt, t_out, ok_out, test_name, 5, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 6, desc)
		end

	--|--------------------------------------------------------------

	exec_list_test6 is
		local
			vl: TWO_WAY_LIST [INTEGER_32]
			ta: ARRAY [TWO_WAY_LIST [INTEGER_32]]
			tl: LINKED_LIST [TWO_WAY_LIST [INTEGER_32]]
			v1, v2, v3: INTEGER_32
			test_name, fmt, ok_out, t_out: STRING
			desc: STRING
		do
			desc := "List, custom dflt sep; 2-way list of integers"
			test_name := "List test 6"
			fmt := "*%%L*"
			v1 := 123
			v2 := 456
			v3 := 789
			ok_out := "*123->456->789*"
			create vl.make
			vl.fill (<< v1, v2, v3 >>)
			ta := << vl >>
			create tl.make
			tl.fill (ta)
			set_default_printf_list_delimiter ("->")
			t_out := aprintf (fmt, vl)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, << <<v1, v2, v3>> >>)
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, [vl])
			record_result (fmt, t_out, ok_out, test_name, 3, desc)
			t_out := aprintf (fmt, ta)
			record_result (fmt, t_out, ok_out, test_name, 4, desc)
			t_out := aprintf (fmt, tl)
			record_result (fmt, t_out, ok_out, test_name, 5, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 6, desc)

			reset_default_printf_list_delimiter
		end

	--|--------------------------------------------------------------

	exec_solo_test1 is
		local
			vlist: TWO_WAY_LIST [STRING]
			v1: STRING
			v2: INTEGER_32
			v3: REAL_32
			test_name, fmt, ok_out, t_out: STRING
			desc: STRING
		do
			desc := "Single arg, no list"
			test_name := "Solo test 1"
			fmt := "*%%s*"
			v1 := "foo"
			v2 := 123
			v3 := 5.7
			ok_out := "*foo*"
			create vlist.make
			vlist.extend (v1)
			t_out := aprintf (fmt, v1)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, v2)
			record_result (fmt, t_out, "*** Arg Type Mismatch ***", test_name, 2, desc)
			t_out := aprintf (fmt, vlist)
			record_result (fmt, t_out, ok_out, test_name, 3, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 4, desc)
		end

	--|--------------------------------------------------------------

	exec_solo_test2 is
		local
			v1: INTEGER_32
			v2: STRING
			v3: REAL_32
			test_name, fmt, ok_out, t_out: STRING
			desc: STRING
		do
			desc := "Single int arg, no list"
			test_name := "Solo test 2"
			fmt := "*%%d*"
			v1 := 123
			v2 := "foo"
			v3 := 5.7
			ok_out := "*123*"
			t_out := aprintf (fmt, v1)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, v2)
			record_result (fmt, t_out, "*** Arg Type Mismatch ***", test_name, 2, desc)
			t_out := aprintf (fmt, v3)
			record_result (fmt, t_out, "*** Arg Type Mismatch ***", test_name, 3, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 4, desc)
		end

	--|--------------------------------------------------------------

	exec_verbatim_test1 is
		local
			vlist: TWO_WAY_LIST [ANY]
			va: ARRAY [ANY]
			v1: INTEGER_32
			v2: STRING
			test_name, fmt, ok_out, t_out, void_out: STRING
			desc: STRING
		do
			desc := "Verbatim format, 1 int, 1 string arg, literal pct"
			test_name := "Verbatim test 1"
			fmt := "{
This is a verbatim string test
where the format string is a
  "Verbatim"
string.  The format also includes
an integer arg (%d),
a string arg (%s),
and a literal percent sign (%)
}"
			v1 := 123
			v2 := "foo"
			va := << v1, v2 >>
			create vlist.make
			vlist.fill (va)
			ok_out := "{
This is a verbatim string test
where the format string is a
  "Verbatim"
string.  The format also includes
an integer arg (123),
a string arg (foo),
and a literal percent sign (%)
}"
			void_out := "{
This is a verbatim string test
where the format string is a
  "Verbatim"
string.  The format also includes
an integer arg (Void),
a string arg (Void),
and a literal percent sign (%)
}"
			t_out := aprintf (fmt, va)
			record_result (fmt, t_out, ok_out, test_name, 1, desc)
			t_out := aprintf (fmt, vlist)
			record_result (fmt, t_out, ok_out, test_name, 2, desc)
			t_out := aprintf (fmt, [v1, v2])
			record_result (fmt, t_out, ok_out, test_name, 3, desc)

			t_out := aprintf (fmt, Void)
			record_result (fmt, t_out, fmt, test_name, 4, desc)
			t_out := aprintf (fmt, [])
			record_result (fmt, t_out, void_out, test_name, 5, desc)
		end

--|========================================================================
feature {NONE} -- Recording and reporting
--|========================================================================

	record_result (
		fmt, t_out, ok_out, test_name: STRING; id: INTEGER; desc: STRING) is
		local
			ts: STRING
		do
			ts := aprintf ("%%s.%%d - %%s", <<test_name, id, desc>>)
			if t_out.is_equal (ok_out) then
				if show_expected_on_pass then
					ts := aprintf (
						"%%s%N    Format   [%%s]%N    Expected [%%s]",
						<<ts, fmt, ok_out>>)
				end
				tests_passed.extend (ts)
			else
				ts := aprintf (
					"%%s%N    Format   [%%s]%N    Expected [%%s]%N    Actual   [%%s]",
					<<ts, fmt, ok_out, t_out>>)
				tests_failed.extend (ts)
			end
		end

	--|--------------------------------------------------------------

	report_results is
		do
			print ("Tests Failed%N")
			print_list (tests_failed)
			print ("Tests Passed%N")
			print_list (tests_passed)
			printf (
				"Totals:%N  %%-8d Passed%N  %%-8d Failed%N",
				[tests_passed.count, tests_failed.count])
		end

	--|--------------------------------------------------------------

	print_list (tl: like tests_passed) is
		do
			if tl.is_empty then
				print ("  NONE%N")
			else
				from tl.start
				until tl.exhausted
				loop
					printf ("  %%s%N", tl.item)
					tl.forth
				end
			end
		end

	--|--------------------------------------------------------------

	tests_passed: LINKED_LIST [STRING]
	tests_failed: LINKED_LIST [STRING]

	show_expected_on_pass: BOOLEAN

--|========================================================================
feature {NONE} -- Add Comment
--|========================================================================

	Ks_alpha_upper: STRING is "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

end -- class PRINTF_TEST
