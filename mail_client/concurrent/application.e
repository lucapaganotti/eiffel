note
	description: "mail_client application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			client: CLIENT
		do
			create client.make
			client.live
		end

end
