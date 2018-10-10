note
	description: "test_postgres application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	PG_TEST

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
			--| Add your code here
			print ("Hello Eiffel World!%N")
		end

end
