note
	description: "test_mongodb application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	MONGODB_TEST

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			l_client: MONGODB_CLIENT
		do
			--| Add your code here
			print ("Hello Eiffel World!%N")

			create l_client.make ("mongodb://127.0.0.1:27017")
		end

end
