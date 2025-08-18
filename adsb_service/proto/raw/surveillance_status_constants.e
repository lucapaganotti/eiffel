note
	description: "Summary description for {SURVEILLANCE_STATUS_CONSTANTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SURVEILLANCE_STATUS_CONSTANTS

feature -- Surveillance Status constants in use to {AIRBORNE_POSITION_ME_SEGMENT_DATA}

	SS_No_Condition:				INTEGER = 0
			-- No condition
	SS_Permanent_Alert:             INTEGER = 1
			-- Permanent Alert
	SS_Temporary_Alert:				INTEGER = 2
			-- Temporary Alert
	SS_SPI_Condition:				INTEGER = 3
			-- SPI Condition

end
