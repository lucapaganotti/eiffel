note
	description: "Summary description for {PIGPIO_EVENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PIGPIO_EVENT

inherit
	ANY
	undefine
		out
	end

create
	make_empty, make

feature {NONE} -- Initialization

	make_empty
			-- Initialization for `Current'.
		do
			create name.make_empty
			create description.make_empty
		end

	make (i: NATURAL n, d: STRING cid: INTEGER f: POINTER)
			-- Initialization for `Current' with parameters.
		require
			n_d_f_attached: attached n and attached d and attached f
		do
			id          := i
			name        := n
			description := d
			callback_id := cid
			callback    := f
		end


feature -- Access

	id:          NATURAL
	name:        STRING
	description: STRING
	callback_id: INTEGER
	callback:    POINTER

feature -- Measurement

feature -- Status report

	out: STRING
			--
		do
			Result :=           "Event id:            " + id.out + "%N"
			Result :=  Result + "Event name:          " + name + "%N"
			Result :=  Result + "Event description:   " + description + "%N"
			Result :=  Result + "Event callback id:   " + callback_id.out + "%N"
			Result :=  Result + "Event callback addr: " + callback.out + "%N"
		end

feature -- Status setting

	set_id (i: NATURAL)
			--
		do
			id := i
		end

	set_name(n: STRING)
			--
		require
			n_attached: attached n
		do
			name := n
		end

	set_description (d: STRING)
			--
		require
			d_attached: attached d
		do
			description := d
		end

	set_callback_id(i: INTEGER)
			--
		do
			callback_id := i
		end

	set_callback (c: POINTER)
		require
			c_not_void: c.item /= Void
		do
			callback := c
		end

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end
