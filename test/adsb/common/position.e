note
	description: "Summary description for {POSITION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	POSITION

inherit
	ANY
	redefine
		is_equal
	end

create
	make,
	make_with_parameters,
	make_from_position


feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			longitude := 0.0
			latitude := 0.0
			elevation := 0.0
		end

	make_with_parameters (a_x, a_y, a_z: like longitude)
			--
		do
			longitude := a_x
			latitude := a_y
			elevation := a_z
		end

	make_from_position (p: like Current)
			--
		require
			p_attached: attached p
		do
			longitude := p.longitude
			latitude := p.latitude
			elevation := p.elevation
		end

feature -- Access

	longitude: DOUBLE assign set_longitude
			--

	latitude: DOUBLE assign set_latitude
			--

	elevation: DOUBLE assign set_elevation
			--

feature -- Measurement

	is_equal (other: like Current): BOOLEAN
			--
		do
			Result := longitude = other.longitude and
					  latitude = other.latitude and
					  elevation = other.elevation
		end

feature -- Status report

feature -- Status setting

	set_longitude (lon: DOUBLE)
			--
		require
			valid_longitude: lon >= -180.0 and lon <= 180.0
		do
			longitude := lon
		end

	set_latitude (lat: DOUBLE)
			--
		require
			valid_latitude: lat >= -90.0 and lat <= 90.0
		do
			latitude := lat
		end

	set_elevation (elev: DOUBLE)
			--
		do
			elevation := elev
		end

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end
