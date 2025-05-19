note
	description : "TEST_DATE_TIME_FORMAT application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	TEST_DATE_TIME

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			a_date_time: DATE_TIME
			a_date: DATE
			a_time: TIME
		do
			create a_date_time.make_from_string ("2017-11-18 15:32:00", "yyyy-[0]mm-[0]dd [0]hh:[0]mi:[0]ss")
			io.put_new_line
			io.put_string ("STANDARD OUT")
			io.put_new_line
			io.put_string (a_date_time.out)
			io.put_new_line
			create a_date.make_from_string ("2017-11-18", "yyyy-[0]mm-[0]dd")
			create a_time.make_from_string ("15:32:00", "[0]hh:[0]mi:[0]ss")
			io.put_string (a_date.out + " " + a_time.out)
			io.put_new_line
			io.put_string ("FORMATTED OUT")
			io.put_new_line
			io.put_string (a_date_time.formatted_out ("yyyy-[0]mm-[0]dd [0]hh:[0]mi:[0]ss"))
			io.put_new_line
			io.put_string (a_date.formatted_out ("yyyy-[0]mm-[0]dd")+ " " + a_time.formatted_out ("[0]hh:[0]mi:[0]ss"))
			io.put_new_line
		end

end
