note
	description: "Summary description for {MSG_TYPE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

-- Refer to SBS1 BaseStation message description.

class
	MSG_TYPE

feature -- Constants

	selection_change: STRING = "SEL"
			-- Generated when the user changes the selected aircraft in BaseStation.

	new_id:           STRING = "ID"
			-- Generated when an aircraft being tracked sets or changes its callsign.

	new_aircraft:     STRING = "AIR"
			-- Generated when the SBS picks up a signal for an aircraft that it isn't
 			-- currently tracking.

 	status_change:    STRING = "STA"
 			-- Generated when an aircraft's status changes according to the time-out
 			-- values in the Data Settings menu.

 	click:            STRING = "CLK"
 			-- Generated when the user double-clicks (or presses return) on an aircraft
 			-- (i.e. to bring up the aircraft details window).

 	transmission:     STRING = "MSG"
 			-- Generated by the aircraft. There are eight different MSG types.

end