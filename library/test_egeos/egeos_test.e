note
	description: "test_egeos application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	EGEOS_TEST

inherit
	ARGUMENTS
	GEOS_EXTERNALS_R
	GEOS_EXTERNALS_NON_R

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			sv, hex: STRING
			any: ANY
			h: POINTER
			handler: POINTER
			geom: POINTER
			dims, byte_order, size: INTEGER
			p: POINT_NR
			vp: POINTER
			cs: COORDINATE_SEQUENCE_NR
			fd: FORMAT_DOUBLE
		do
			create fd.make (10, 6)
			create sv.make_empty
			create hex.make_from_string ("000000000140000000000000004010000000000000")
			--| Add your code here
			print ("Hello GEOS!%N")

			print ("geos major version:       " + c_geos_version_major.out   + nl)
			print ("geos minor version:       " + c_geos_version_minor.out   + nl)
			print ("geos patch version:       " + c_geos_version_patch.out   + nl)
			sv.from_c (c_geos_version)
			print ("geos version:             " + sv + nl)

			print ("geos capi major version:  " + c_geos_capi_version_major.out   + nl)
			print ("geos capi minor version:  " + c_geos_capi_version_minor.out   + nl)
			print ("geos capi patch version:  " + c_geos_capi_version_patch.out   + nl)
			sv.from_c (c_geos_capi_version)
			print ("geos capi version:        " + sv + nl)

			h := c_geos_init_r

			handler := c_geos_context_set_error_handler (h, $c_geos_default_message_handler)
			handler := c_geos_context_set_notice_handler (h, $handler)

			dims := c_geos_get_wkb_output_dims_r (h)
			print ("geos get wkb output dims: " + dims.out + nl)
			dims := c_geos_set_wkb_output_dims_r (h, dims)
			print ("geos set wkb output dims: " + dims.out + nl)

			byte_order := c_geos_get_wkb_byte_order (h)
			print ("geos get wkb byte order:  " + byte_order.out + nl)
			byte_order := c_geos_set_wkb_byte_order (h, byte_order)
			print ("geos set wkb byte order:  " + byte_order.out + nl)

			byte_order := c_geos_set_wkb_byte_order (h, geos_wkb_xdr)
			any := hex.to_c
			geom := c_geos_geom_from_hex_buf_r (h, $any, hex.count)

			sv.from_c(c_geos_geom_to_hex_buf_r (h, geom, $size))
			print ("Back and forth geom:      " + sv + nl)
			check sv.is_equal (hex) end

			c_geos_interrupt_request
			c_geos_interrupt_cancel

			c_geos_finish_r (h)

			c_init_geos (vp, vp)


			create cs.make (1, 3)
			io.put_string ("cs: " + cs.as_pointer.out + " [s: " + cs.size.out + ", d: " + cs.dimensions.out + "]" + nl)

			cs.x (0) := 1.1
			cs.y (0) := 2.2
			cs.z (0) := 3.3

			create p.make (cs)
			io.put_string ("p: " + p.as_pointer.out + nl)

			io.put_string ("p: (" + fd.formatted (p.x) + ", " + fd.formatted (p.y) + ", " + fd.formatted (p.z) + ")%N")



			p.dispose




			c_finish_geos

		end

feature -- Constants

	nl: STRING = "%N"

end
