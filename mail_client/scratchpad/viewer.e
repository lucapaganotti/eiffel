note
	description: "Visualizer of email messages."
	author: "Bertrand Meyer"
	date: "$Date$"
	revision: "$Revision$"

class
	VIEWER

create
	make

feature {NONE} -- Initialization

	make (c: separate CLIENT)
			-- Initialize with `c' as client.
		do
			client := c
		end

feature -- Measurement

	count: INTEGER
			-- Number of messages read so far.

feature -- Access


	i_th (c: separate CLIENT; i: INTEGER): STRING
			-- Message of index `i' in `c'.
		require
			i <= c.count
		local
			s: separate STRING
		do
			s := c.i_th (i)
			create Result.make_from_separate (s)
		end

feature -- Basic operations

	live
			-- Simulate user repeatedly choosing a message and reading it.
		local
			next: INTEGER
			wait: INTEGER_64
			wait_generator: GENERATOR
					-- Random generator of wait times.

			index_generator: GENERATOR
					-- Random generator of index of message to view.
		do
			from
				create index_generator.make ({PARAMETERS}.Max_messages)
				index_generator.forth
				create wait_generator.make (Wait_range)
				wait_generator.forth
			until is_over loop
						-- User randomly selects next message he wants to read.
				count := count + 1
				next := index_generator.item
				wants (next)

						-- User reads chosen message.
				view (i_th (client, next))

						-- Advance random message choice generator.	
				index_generator.forth
				wait_generator.forth
				wait := wait_generator.item * {PARAMETERS}.Milli
				{EXECUTION_ENVIRONMENT}.sleep (wait)
			end
		end

	wants (i: INTEGER)
				-- Simulate user wanting to read message number `i'.
			do
				print ("%T%T%T%T%TViewer wants message number " + i.out + "%N")
			end

	view (mess: STRING)
				-- Display message `mess' for user.
			do
				print ("%T%T%T%T%TViewer reads: " + mess + "%N")
			end

feature {NONE} -- Constants


	Wait_range: INTEGER = 200
			-- Upper bound of random wait, in milliseconds.

	Max_messages: INTEGER
			-- Number of messages to be viewed.
		once
			Result := {PARAMETERS}.Max_messages * 2
		end


feature {NONE} -- Implementation


	client: separate CLIENT
			 -- (Shared)client from which we are getting messages.

	is_over: BOOLEAN
			-- Are we there yet?
		do
			Result := (count = Max_messages)
		end


end
