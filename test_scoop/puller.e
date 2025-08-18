note
	description: "Summary description for {PULLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PULLER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
		end

	sleep (seconds: NATURAL_32)
			-- unsigned int sleep(unsigned int seconds)
		external
			"C inline use %"unistd.h%""
		alias
			"sleep($seconds)"
		end

feature -- Operations

	consume (a: separate LINKED_LIST[INTEGER])
			--
		local
			a_item: INTEGER
		do
			if a.count > 0 then
				a_item := a.at (1)
				a.remove_left
				io.put_string ("Pulled: " + a_item.out)
				io.put_new_line
			end
		end

end
