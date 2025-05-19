note
	description: "Summary description for {RWY_END}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RWY_END

inherit ANY

	redefine
		out
	end

create
	make,
	make_from_params

feature -- Access

	id:   INTEGER
	name: STRING
	pos:  POINT

feature -- Commands

	set_id (i: INTEGER)
			--
		do
			id := i
		end

	set_name (n: STRING)
			--
		do
			name := n
		end

	set_position (p: POINT)
			--
		do
			pos := p
		end

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create name.make_empty
			create pos.make
		end

	make_from_params (i: INTEGER n: STRING p: POINT)
			--
		do
			id := i
			name := n
			pos := p
		end

feature -- IO

	out: STRING
			--
		do
			create Result.make_empty
			Result.append (id.out + " " + name + " " + pos.out)
		end

end
