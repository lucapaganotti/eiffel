note
	description: "test_proj application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	PROJ_TEST

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			pj_const: PROJ_CONSTANTS
		do
			--| Add your code here
			print ("%NHello Eiffel proj World!%N")
			create pj_const
			print ("proj version: " + pj_const.pj_version.out + "%N")
			print ("rad to deg conversion factor: " + pj_const.pj_rad_to_deg.out + "%N")
			print ("deg to rad conversion factor: " + pj_const.pj_deg_to_rad.out + "%N")
			print ("proj release: " + pj_const.pj_release + "%N")
			print ("proj errno global: " + pj_const.pj_errno.out + "%N")
		end

end
