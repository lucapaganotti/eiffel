note
	description: "Summary description for {TRANSPONDER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TRANSPONDER

inherit
	ADSB_VERSION_CONSTANTS

create
	make,make_from_string

feature {NONE} -- Initialization

	make
			--
		do
			addr         := "FFFFFF"
			adsb_version := adsb_version_0
		end

	make_from_string (i: STRING)
			-- Initialization for `Current'.
		require
			i_attached: attached i
		do
			addr         := i
			adsb_version := adsb_version_0
		end

feature -- Access

	addr:         STRING
	adsb_version: INTEGER
	activated:    BOOLEAN
	activated_on: detachable DATE_TIME

feature -- Commands

	set_addr (a: STRING)
			--
		require
			a_attached: attached a
		do
			addr.copy (a)
		ensure
			addr_set: addr.is_equal (a)
		end

	set_adsb_version (v: INTEGER)
			--
		do
			adsb_version := v
		end

	activate (dt: DATE_TIME)
			--
		require
			dt_attached: attached dt
		do
			activated    := true
			activated_on := dt
		end

	deactivate
			--
		do
			activated := false
		end

end
