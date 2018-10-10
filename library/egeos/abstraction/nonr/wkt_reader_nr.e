note
	description: "Summary description for {WKT_READER_NR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WKT_READER_NR

inherit
	GEOS_OBJECT
	GEOS_EXTERNALS_NON_R

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			item := c_wkt_reader_create
		ensure
			pointer_attached: attached as_pointer
		end

feature -- Access

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

	dispose
			-- <Precursor>
		require else
			pointer_attached: attached as_pointer
		do
			c_wkt_reader_destroy (item)
		end

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
