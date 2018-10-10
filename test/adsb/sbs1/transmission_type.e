note
	description: "Summary description for {TRANSMISSION_TYPE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

-- Refer to SBS1 BaseStation message description.

class
	TRANSMISSION_TYPE

feature -- Constants

	identification_and_category: INTEGER = 1
			-- DF17 BDS 0,8

	surface_position:            INTEGER = 2
			-- DF17 BDS 0,6

	airborne_position:           INTEGER = 3
			-- DF17 BDS 0,5

	airborne_velocity:           INTEGER = 4
			-- DF17 BDS 0,9

	surveillance_alt:            INTEGER = 5
			-- Triggered by ground radar. Not CRC secured.
  			-- MSG,5 will only be output if  the aircraft has previously sent a
  			-- MSG,1, 2, 3, 4 or 8 signal.

	surveillance_id:             INTEGER = 6
			-- Triggered by ground radar. Not CRC secured.
  			-- MSG,6 will only be output if  the aircraft has previously sent a
			-- MSG,1, 2, 3, 4 or 8 signal.

	air_to_air:                  INTEGER = 7
			-- Triggered from TCAS.
  			-- MSG,7 is now included in the SBS socket output.

	all_call_reply:              INTEGER = 8
			-- Broadcast but also triggered by ground radar

end
