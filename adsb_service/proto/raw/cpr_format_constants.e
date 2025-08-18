note
	description: "Summary description for {CPR_FORMAT_CONSTANTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CPR_FORMAT_CONSTANTS

feature -- Compact Position Reporting constants in use by {AIRBORNE_POSITION_ME_SEGMENT_DATA}

	CPR_Format_Even_Frame:			INTEGER = 0
			-- CPR Even Frame
	CPR_Format_Odd_Frame:			INTEGER = 1
			-- CPR Odd Frame

end
