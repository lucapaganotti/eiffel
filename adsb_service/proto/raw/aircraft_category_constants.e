note
	description: "Summary description for {AIRCRAFT_CATEGORY_CONSTANTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AIRCRAFT_CATEGORY_CONSTANTS

feature -- Access

	Ac_Reserved:                            STRING = "Reserved"
			-- TC:   1 - CA: ANY
			-- TC:   3 - CA:   5

	Ac_Unknown:                             STRING = "No category information"
			-- TC: ANY - CA:   0

	Ac_Surface_Emergency:                   STRING = "Surface Emergency Vehicle"
			-- TC:   2 - CA:   1
	Ac_Surface_Service:                     STRING = "Surface Service Vehicle"
			-- TC:   2 - CA:   3
	Ac_Ground_Obstruction:                  STRING = "Ground Obstruction"
			-- TC:   2 - CA: 4-7
	
	Ac_Glider_SailPlane:                    STRING = "Glider, Sailplane"
			-- TC:   3 - CA:   1
	Ac_Lighter_Than_Air:                    STRING = "Ligter than air"
			-- TC:   3 - CA:   2
	Ac_Parachutist_Skydiver:                STRING = "Parachutist, Skydiver"
			-- TC:   3 - CA:   3
	Ac_Ultralight_Hangglider_Paraglider:    STRING = "Ultralight, Hang-glider, Paraglider"
			-- TC:   3 - CA:   4
	Ac_Unmanned_Aerial_Vehicle:             STRING = "Unmanned aerial vehicle"
			-- TC:   3 - CA:   6
	Ac_Space_Or_Transatmospheric_vehicle:   STRING = "Space or transatmospheric vehicle"
			-- TC:   3 - CA:   7

	Ac_Light:                               STRING = "Light (less than 7000 kg)"
			-- TC:   4 - CA:   1
	Ac_Medium_1:                            STRING = "Medium 1 (between 7000 kg and 34000 kg)"
			-- TC:   4 - CA:   2
	Ac_Medium_2:                            STRING = "Medium 2 (between 34000 kg and 136000 kg)"
			-- TC:   4 - CA:   3
	Ac_High_Vortex_Aircraft:                STRING = "High Vortex Aircraft"
			-- TC:   4 - CA:   4
	Ac_Heavy:                               STRING = "Heavy (larger than 136000 kg)"
			-- TC:   4 - CA:   5
	Ac_High_Performance:                    STRING = "High performance (> 5 g acceleration) and high speed (> 400 kt)"
			-- TC:   4 - CA:   6
	Ac_Rotorcraft:                          STRING = "Rotorcraft"
			-- TC:   4 - CA:   7


end
