note
	description: "Summary description for {POINT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	POINT

inherit
	DOUBLE_MATH

create
	make,
	make_from_coordinates

feature {NONE} -- Initialization

	make
			--
		do
			x := 0.0
			y := 0.0
			z := 0.0
		end

	make_from_coordinates (ax, ay, az: DOUBLE)
			-- Initialization for `Current'.
		do
			x := ax
			y := ay
			z := az
		end

feature -- Access

	x: DOUBLE
	y: DOUBLE
	z: DOUBLE

feature -- Status

	is_valid: BOOLEAN
			--
		do
			Result := not (x.is_nan or x.is_negative_infinity or x.is_positive_infinity) and
			          not (y.is_nan or y.is_negative_infinity or y.is_positive_infinity) and
			          not (z.is_nan or z.is_negative_infinity or z.is_positive_infinity)
		end

feature -- Commands

	setx (ax: DOUBLE)
			--
		do
			x := ax
		end

	sety (ay: DOUBLE)
			--
		do
			y := ay
		end

	setz (az: DOUBLE)
			--
		do
			z := az
		end

	transform (pj4src, pj4dst: STRING): INTEGER
			--
		local
			pj_const: PROJ_CONSTANTS
			pj:       PROJ_EXTERNALS
			pjsrc:    POINTER
			pjdst:    POINTER

			px,py,pz: MANAGED_POINTER
		do
			create pj_const
			create pj

			pjsrc := pj.c_pj_init_plus (pj4src.area.base_address)
			pjdst := pj.c_pj_init_plus (pj4dst.area.base_address)

			create px.make (8)
			create py.make (8)
			create pz.make (8)

			if pj.c_pj_is_latlong (pjsrc) and pj.c_pj_is_geocent (pjdst) then
				x := x * pj_const.pj_deg_to_rad
				y := y * pj_const.pj_deg_to_rad

				px.put_real_64 (x, 0)
				py.put_real_64 (y, 0)
				pz.put_real_64 (z, 0)

				Result := pj.c_pj_transform (pjsrc, pjdst, 1, 0, px.item, py.item, pz.item)

				x := px.read_real_64 (0)
				y := py.read_real_64 (0)
				z := pz.read_real_64 (0)

				--px.dispose
				--py.dispose
				--pz.dispose

			elseif pj.c_pj_is_geocent (pjsrc) and pj.c_pj_is_latlong (pjdst) then

				px.put_real_64 (x, 0)
				py.put_real_64 (y, 0)
				pz.put_real_64 (z, 0)

				Result := pj.c_pj_transform (pjdst, pjsrc, 1, 0, px.item, py.item, pz.item)

				px.put_real_64 (px.read_real_64 (0) * pj_const.pj_rad_to_deg, 0)
            	py.put_real_64 (py.read_real_64 (0) * pj_const.pj_rad_to_deg, 0)

            	x := px.read_real_64 (0)
				y := py.read_real_64 (0)
				z := pz.read_real_64 (0)

			end

			pj.c_pj_free (pjsrc)
			pj.c_pj_free (pjdst)


		end

	distance (other: like Current d3: BOOLEAN): DOUBLE
			--
		do
			if d3 then
				Result := sqrt (pow (x - other.x, 2.0) + pow (y - other.y, 2.0) + pow (z - other.z, 2.0))
			else
				Result := sqrt (pow (x - other.x, 2.0) + pow (y - other.y, 2.0))
			end
		end

	to_wkt: STRING
			--
		do
			Result := "POINT(" + x.out + " " + y.out + " " + z.out + ")"
		end

	from_wkt (wkt: STRING)
			--
		local
			text:   STRING
			tokens: LIST[STRING]
		do
			text := wkt
			text.prune_all ('(')
			text.prune_all (')')
			text.replace_substring_all ("POINT", "")
			tokens := text.split (' ')

			if attached {STRING} tokens.at (1) as l_x and then
			   attached {STRING} tokens.at (2) as l_y and then
			   attached {STRING} tokens.at (3) as l_z then
			   	if l_x.is_double then
			   		x := l_x.to_double
			   	end
				if l_y.is_double then
					y := l_y.to_double
				end
				if l_z.is_double then
					z := l_z.to_double
				end
			end
		end

feature {NONE}

	pow (base, exponent: DOUBLE): DOUBLE
			--
		external
			"C inline use %"math.h%""
		alias
			"pow($base, $exponent)"
		end

end
