note
	description: "Summary description for {POINT_NR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	POINT_NR

inherit
	GEOMETRY_NR

create
	make

feature {NONE} -- Initialization

--	make
--			-- Initialization for `Current'.
--		do
--			item := c_geom_create_empty_point
--			if item.is_default_pointer then
--				raise ("Internal GEOS exception")
--			end
--			create coord_seq.make (1, 3)
--			coord_seq.item := c_get_coordinate_sequence (item)
--		end

	make (cs: COORDINATE_SEQUENCE_NR)
			--
		do
			item := c_geom_create_point (cs.as_pointer)
			if item.is_default_pointer then
				raise ("Internal GEOS exception")
			end
			coord_seq := cs
		end

feature -- Access

	z: DOUBLE
			--
		require
			has_zeta: has_z = 1
		local
			r: INTEGER
		do
			r := c_coord_seq_get_z (coord_seq.item, 0, $Result)
			if r = 0 then
				raise ("Internal GEOS exception")
			end
		end

feature -- Measurement

feature -- Status report

feature -- Status setting

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
