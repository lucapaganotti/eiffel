note
	description: "Summary description for {MSG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MSG

	inherit
		MSG_CONSTANTS

feature -- Access

	text: STRING assign set_text
			--

feature -- Measurement

feature -- Status report

feature -- Status setting

	set_text (t: STRING)
			--
		require
			attached_t: attached t
		do
			text := t.twin
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

	parse
			--
		deferred
		end

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end
