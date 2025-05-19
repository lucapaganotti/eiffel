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
			pj:       PROJ_EXTERNALS
			pjsrc:    POINTER
			pj4src:   STRING
			pjdst:    POINTER
			pj4dst:   STRING
			res:      INTEGER

			x,y,z: MANAGED_POINTER
		do
			--| Add your code here
			print ("%NHello Eiffel proj World!%N")
			create pj_const
			print ("proj version: " + pj_const.pj_version.out + "%N")
			print ("rad to deg conversion factor: " + pj_const.pj_rad_to_deg.out + "%N")
			print ("deg to rad conversion factor: " + pj_const.pj_deg_to_rad.out + "%N")
			print ("proj release: " + pj_const.pj_release + "%N")
			print ("proj errno global: " + pj_const.pj_errno.out + "%N")

			create pj4src.make_empty
			pj4src := "+proj=latlong +ellps=WGS84"
			create pj4dst.make_empty
			pj4dst := "+proj=utm +zone=32 +ellps=WGS84"
			create pj


			pjsrc := pj.c_pj_init_plus (pj4src.area.base_address)
			pjdst := pj.c_pj_init_plus (pj4dst.area.base_address)


			create x.make (8)
			x.put_real_64 (8.45 * pj_const.pj_deg_to_rad, 0)
			create y.make (8)
			y.put_real_64 (44.78 * pj_const.pj_deg_to_rad, 0)
			create z.make (8)
			z.put_real_64 (1000.0, 0)

			res := pj.c_pj_transform (pjsrc, pjdst, 1, 0, x.item, y.item, z.item)

			print ("res : " + res.out + " x: " + x.read_real_64 (0).out + " y: " + y.read_real_64 (0).out + " z: " + z.read_real_64 (0).out + "%N")

            res := pj.c_pj_transform (pjdst, pjsrc, 1, 0, x.item, y.item, z.item)

            x.put_real_64 (x.read_real_64 (0) * pj_const.pj_rad_to_deg, 0)
            y.put_real_64 (y.read_real_64 (0) * pj_const.pj_rad_to_deg, 0)

            print ("res : " + res.out + " x: " + x.read_real_64 (0).out + " y: " + y.read_real_64 (0).out + " z: " + z.read_real_64 (0).out + "%N")

			x.dispose
			y.dispose
			z.dispose

			pj.c_pj_free (pjsrc)
			pj.c_pj_free (pjdst)
		end

end
