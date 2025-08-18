note
	description: "Summary description for {BRAKING_ACTION_CODES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BRAKING_ACTION_CODES

feature -- Friction coefficient or braking action codes

	fc_0_28:                    STRING = "28"
			-- friction coefficient 0.28
	fc_0_35:                    STRING = "35"
			-- friction coefficient 0.35
	ba_poor:                    STRING = "91"
			-- braking action poor
	ba_medium_to_poor:          STRING = "92"
			-- braking action medium to poor
	ba_medium:                  STRING = "93"
			-- braking action medium
	ba_medium_to_good:          STRING = "94"
			-- braking action medium to good
	ba_good:                    STRING = "95"
			-- braking action good
	ba_unreliable:              STRING = "99"
			-- figures unreliable
	ba_not_reported:            STRING = "//"
			-- braking action not reported or
			-- runway not operational or
			-- airport closed

-- TODO Add descriptions

end
