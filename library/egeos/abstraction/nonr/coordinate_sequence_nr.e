note
	description: "Summary description for {COORDINATE_SEQUENCE_NR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COORDINATE_SEQUENCE_NR

inherit
	GEOS_OBJECT
	EXCEPTIONS

create
	make

feature {NONE} -- Initialization

	make (sz, dims: NATURAL)
			-- Initialization for `Current'.
		do
			item := c_coord_seq_create (sz, dims)
			if item.is_default_pointer then
				raise ("Internal GEOS exception")
			end
		end

feature -- Access

	size: NATURAL
			--
		require
			pointer_attached: attached as_pointer
			pointer_not_void: not item.is_default_pointer
		local
			r: INTEGER
		do
			r := c_coord_seq_get_size (item, $Result)
			if r = 0 then
				raise ("Internal GEOS exception")
			end
		end

	dimensions: NATURAL
			--
		require
			pointer_attached: attached as_pointer
			pointer_not_void: not item.is_default_pointer
		local
			r: INTEGER
		do
			r := c_coord_seq_get_dimensions (item, $Result)
			if r = 0 then
				raise ("Internal GEOS exception")
			end
		end

	x(idx: NATURAL): DOUBLE assign set_x
			--
		require
			pointer_attached: attached as_pointer
			pointer_not_void: not item.is_default_pointer
		local
			r: INTEGER
		do
			r := c_coord_seq_get_x (item, idx, $Result)
			if r = 0 then
				raise ("Internal GEOS exception")
			end
		end

	y(idx: NATURAL): DOUBLE assign set_y
			--
		require
			pointer_attached: attached as_pointer
			pointer_not_void: not item.is_default_pointer
		local
			r: INTEGER
		do
			r := c_coord_seq_get_y (item, idx, $Result)
			if r = 0 then
				raise ("Internal GEOS exception")
			end
		end

	z(idx: NATURAL): DOUBLE assign set_z
			--
		require
			pointer_attached: attached as_pointer
			pointer_not_void: not item.is_default_pointer
		local
			r: INTEGER
		do
			r := c_coord_seq_get_z (item, idx, $Result)
			if r = 0 then
				raise ("Internal GEOS exception")
			end
		end

feature -- Measurement

feature -- Status report

feature -- Status setting

	set_x (value: DOUBLE; idx: NATURAL)
			--
		require
			pointer_attached: attached as_pointer
			pointer_not_void: not item.is_default_pointer
		local
			r: INTEGER
		do
			r := c_coord_seq_set_x (item, idx, value)
			if r = 0 then
				raise ("Internal GEOS exception")
			end
		end

	set_y (value: DOUBLE; idx: NATURAL)
			--
		require
			pointer_attached: attached as_pointer
			pointer_not_void: not item.is_default_pointer
		local
			r: INTEGER
		do
			r := c_coord_seq_set_y (item, idx, value)
			if r = 0 then
				raise ("Internal GEOS exception")
			end
		end

	set_z (value: DOUBLE; idx: NATURAL)
			--
		require
			pointer_attached: attached as_pointer
			pointer_not_void: not item.is_default_pointer
		local
			r: INTEGER
		do
			r := c_coord_seq_set_z (item, idx, value)
			if r = 0 then
				raise ("Internal GEOS exception")
			end
		end

feature -- Cursor movement

feature -- Element change

feature -- Removal

	dispose
			-- <Precursor>
		do
			c_geos_free (item)
		end

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

	dup: like Current
			--
		require
			pointer_attached: attached as_pointer
			pointer_not_void: not item.is_default_pointer
		do
			create Result.make (size, dimensions)
			Result.item := c_coord_seq_clone (item)
		end

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end
