note
	description: "Summary description for {DF17_ME_FACTORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

expanded class
	DF17_ME_FACTORY

feature -- Interface

	create_df17_me_segment (tc: INTEGER t: STRING): detachable ME_SEGMENT_DATA
			--
		do
			-- 01-04 Aircraft Identifiction
			if tc = {TYPE_CODE_CONSTANTS}.tc01_aircraft_identification or
			   tc = {TYPE_CODE_CONSTANTS}.tc02_aircraft_identification or
			   tc = {TYPE_CODE_CONSTANTS}.tc03_aircraft_identification or
			   tc = {TYPE_CODE_CONSTANTS}.tc04_aircraft_identification then
				Result := create {AIRCRAFT_IDENTIFICATION_ME_SEGMENT_DATA}.make_from_string (t)
			-- 05-08 Surface Position   	
			elseif tc = {TYPE_CODE_CONSTANTS}.tc05_surface_position or
			       tc = {TYPE_CODE_CONSTANTS}.tc06_surface_position or
			       tc = {TYPE_CODE_CONSTANTS}.tc07_surface_position or
			       tc = {TYPE_CODE_CONSTANTS}.tc08_surface_position then
			-- 09-18 Airborne Position (w/Baro Altitude)
			elseif tc = {TYPE_CODE_CONSTANTS}.tc09_airborne_position or
				   tc = {TYPE_CODE_CONSTANTS}.tc10_airborne_position or
				   tc = {TYPE_CODE_CONSTANTS}.tc11_airborne_position or
				   tc = {TYPE_CODE_CONSTANTS}.tc12_airborne_position or
				   tc = {TYPE_CODE_CONSTANTS}.tc13_airborne_position or
				   tc = {TYPE_CODE_CONSTANTS}.tc14_airborne_position or
				   tc = {TYPE_CODE_CONSTANTS}.tc15_airborne_position or
				   tc = {TYPE_CODE_CONSTANTS}.tc16_airborne_position or
				   tc = {TYPE_CODE_CONSTANTS}.tc17_airborne_position or
				   tc = {TYPE_CODE_CONSTANTS}.tc18_airborne_position then
				   	Result := create {AIRBORNE_POSITION_ME_SEGMENT_DATA}.make_from_string (t, create {DATE_TIME}.make_now)
			-- 19 Airborne Velocities
			elseif tc = {TYPE_CODE_CONSTANTS}.tc19_airborne_velocities then
			-- 20-22 Airborne Position (w/GNSS Height)
			elseif tc = {TYPE_CODE_CONSTANTS}.tc20_airborne_position or
			       tc = {TYPE_CODE_CONSTANTS}.tc21_airborne_position or
			       tc = {TYPE_CODE_CONSTANTS}.tc22_airborne_position then
			-- 23-27 Reserved
			elseif tc = {TYPE_CODE_CONSTANTS}.tc23_reserved or
			       tc = {TYPE_CODE_CONSTANTS}.tc24_reserved or
			       tc = {TYPE_CODE_CONSTANTS}.tc25_reserved or
			       tc = {TYPE_CODE_CONSTANTS}.tc26_reserved or
			       tc = {TYPE_CODE_CONSTANTS}.tc27_reserved then
			-- 28 Aircraft Status
			elseif tc = {TYPE_CODE_CONSTANTS}.tc28_aircraft_status then
			-- 29 Target State and Info
			elseif tc = {TYPE_CODE_CONSTANTS}.tc29_target_state_and_info then
			-- 31 Aircraft Operation Status
			elseif tc = {TYPE_CODE_CONSTANTS}.tc31_aircraft_operation_status then

			else

			end
		end

end
