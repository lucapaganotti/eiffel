note
	description: "Summary description for {RWY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RWY

inherit ANY

	redefine
		out
	end

create
	make,
	make_from_params

feature -- Access

	id: INTEGER
	thr: RWY_END
	rwe: RWY_END

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create thr.make
			create rwe.make
		end

	make_from_params (t, r: RWY_END)
			--
		do
			thr := t
			rwe := r
		end

feature -- IO

	out: STRING
			--
		do
			create Result.make_empty
			Result.append (thr.out + " - " + rwe.out)
		end

end
