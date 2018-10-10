note
	description: "Summary description for {GEOS_OBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GEOS_OBJECT

inherit
	DISPOSABLE
	GEOS_EXTERNALS_NON_R
	GEOS_EXTERNALS_R

feature -- Access

	as_pointer: POINTER
			--
		do
			Result := item
		end

feature -- Status setting

	set_item (p: POINTER)
			--
		require
			p_not_void: p /= Void
		do
			item := p
		end

feature -- Implementation

	item: POINTER assign set_item
			-- The geos object

end
