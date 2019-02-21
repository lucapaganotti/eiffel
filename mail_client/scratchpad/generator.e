note
	description: "Objects in charge of generating random numbers for simulation of email operations."
	author: "Bertrand Meyer"
	date: "$Date$"
	revision: "$Revision$"

class
	GENERATOR

create
	make

feature {NONE} -- Initialization

	make (n: INTEGER)
			-- Initialize integer generator for interval 1 |..| `n'.
		require
			positive: n > 0
		do
			create random.make
			random.start
			count := n
		end

feature -- Access

	count: INTEGER
			-- Upper bound of generated integers (lower bound is 1).

	item: INTEGER
			-- Last randomly generated element.
		do
			Result := (random.item \\ count) + 1
		end

feature -- Element change

	forth
			-- Produce a random integer in 1 |..| `count', available in `item'.
		do
			random.forth
		end

feature {NONE} -- Implementation

		random: RANDOM
				-- Random sequence	

invariant
	positive: count > 0
end
