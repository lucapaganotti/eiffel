note
	description: "Summary description for {POSITION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	POSITION

inherit
	POINT
	redefine
		make, make_from_coordinates, out, distance
	end

create
	make,
	make_from_coordinates,
	make_from_point

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			x := 0.0
			y := 0.0
			z := 0.0
			create t.make_now
			on_ground := false
		end

	make_from_coordinates (ax, ay, az: DOUBLE)
			--
		do
			Precursor (ax, ay, az)
			create t.make_now
			on_ground := false
		end

	make_from_point (pt: POINT)
			--
		do
			x := pt.x
			y := pt.y
			z := pt.z
			create t.make_now
			on_ground := false
		end

feature -- Access

    t:         DATE_TIME
	on_ground: BOOLEAN

	gs:        DOUBLE
	trk:       DOUBLE
	vr:        INTEGER

feature -- Commands

	set_on_ground
			--
		do
			on_ground := true
		end

	set_t (dt: DATE_TIME)
			--
		do
			t := dt
		end

	set_ground_speed (s: DOUBLE)
			--
		do
			gs := s
		end

	set_track_angle (a: DOUBLE)
			--
		do
			trk := a
		end

	set_vertical_rate (r: INTEGER)
			--
		do
			vr := r
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

feature -- IO

	out: STRING
			--
		local
			fd_coord: FORMAT_DOUBLE
			fd:       FORMAT_DOUBLE
		do
			create fd_coord.make (10, 5)
			create fd.make (6, 2)
			Result := fd_coord.formatted (x) + " " + fd_coord.formatted (y) + " " + fd.formatted (z) + " " +
			          fd.formatted (gs) + " " + fd.formatted (trk) + " " + vr.out
		end

feature -- Conversion

	to_point: POINT
			--
		do
			create Result.make_from_coordinates (x, y, z)
		end

end
