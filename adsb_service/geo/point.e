note
	description: "Summary description for {POINT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	POINT

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

end
