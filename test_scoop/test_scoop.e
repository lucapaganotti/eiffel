note
	description: "test_scoop application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_SCOOP

inherit
	ARGUMENTS_32

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
			create queue.make
			create pusher.make
			create puller.make
			run (queue)
		end

	sleep (seconds: NATURAL_32)
			-- unsigned int sleep(unsigned int seconds)
		external
			"C inline use %"unistd.h%""
		alias
			"sleep($seconds)"
		end

feature -- Operations

	run (q: separate LINKED_LIST[INTEGER])
			--
		do
			from
			until false
			loop
				pusher.produce (q)
				puller.consume (q)
				io.put_string ("Queue has " + q.count.out + " items")
				io.put_new_line
				sleep (1)
			end
		end

feature -- Access

	queue: separate LINKED_LIST[INTEGER]

	pusher: PUSHER
	puller: PULLER

end
