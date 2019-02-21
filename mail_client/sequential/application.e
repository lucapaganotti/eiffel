note
	description: "mail_client application root class"
	author: "Bertrand Meyer"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

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
