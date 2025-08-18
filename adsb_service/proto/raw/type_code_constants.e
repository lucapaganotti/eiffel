note
	description: "Summary description for {TYPE_CODE_CONSTANTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_CODE_CONSTANTS

feature {DF17_ME_FACTORY}

	-- Aircraft Identification
	Tc01_Aircraft_Identification:		INTEGER =  1
	Tc02_Aircraft_Identification:		INTEGER =  2
	Tc03_Aircraft_Identification:		INTEGER =  3
	Tc04_Aircraft_Identification:		INTEGER =  4

	-- Surface Position
	Tc05_Surface_Position:				INTEGER =  5
	Tc06_Surface_Position:				INTEGER =  6
	Tc07_Surface_Position:				INTEGER =  7
	Tc08_Surface_Position:				INTEGER =  8

	-- Airborne Position (w/Baro Altitude)
	Tc09_Airborne_Position:				INTEGER =  9
	Tc10_Airborne_Position:				INTEGER = 10
	Tc11_Airborne_Position:				INTEGER = 11
	Tc12_Airborne_Position:				INTEGER = 12
	Tc13_Airborne_Position:				INTEGER = 13
	Tc14_Airborne_Position:				INTEGER = 14
	Tc15_Airborne_Position:				INTEGER = 15
	Tc16_Airborne_Position:				INTEGER = 16
	Tc17_Airborne_Position:				INTEGER = 17
	Tc18_Airborne_Position:				INTEGER = 18

	-- Airborne Velocities
	Tc19_Airborne_Velocities:			INTEGER = 19

	-- Airborne Position (w/GNSS Height)
	Tc20_Airborne_Position:				INTEGER = 20
	Tc21_Airborne_Position:				INTEGER = 21
	Tc22_Airborne_Position:				INTEGER = 22

	-- Reserved
	Tc23_Reserved:						INTEGER = 23
	Tc24_Reserved:						INTEGER = 24
	Tc25_Reserved:						INTEGER = 25
	Tc26_Reserved:						INTEGER = 26
	Tc27_Reserved:						INTEGER = 27

	-- Aircraft Status
	Tc28_Aircraft_Status:				INTEGER = 28
	Tc29_Target_State_And_Info:			INTEGER = 29

	-- Aircraft Operation Status
	Tc31_Aircraft_Operation_Status:		INTEGER = 31

end
