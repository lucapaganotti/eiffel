note
	description: "Summary description for {PUSHER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PUSHER

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

feature -- Operation

	produce (a: separate LINKED_LIST[INTEGER])
			--
		local
			r: RANDOM
			i: INTEGER
		do
			create r.make
			r.set_seed (7685949)
			i := r.item
			a.extend (i)
			io.put_string ("Pushed: " + i.out)
			io.put_new_line
			r.forth
			sleep (3)
		end

end
