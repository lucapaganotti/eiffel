note
	description: "Summary description for {DUMP_FILE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DUMP_FILE

inherit
	PLAIN_TEXT_FILE

create

	build

feature {NONE} -- Initialization

	build (p: STRING)
			--
		do
			create dt.make_now_utc
			fn := p
			make_open_append (p)
		end

feature -- Access

	dt: DATE_TIME
	fn: STRING

feature -- Commands

	set_dt (t: DATE_TIME)
			--
		do
			dt := t
		end

	set_fn (n: STRING)
			--
		do
			fn := n
		end

end
