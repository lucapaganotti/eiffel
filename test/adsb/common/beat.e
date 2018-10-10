note
	description: "Summary description for {BEAT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BEAT

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create p.make
			create t.make_now_utc
		end

feature -- Access

	position: POSITION
			--
		do
			result := p
		end

	longitude: DOUBLE
			--
		do
			Result := p.longitude
		end

	latitude: DOUBLE
			--
		do
			Result := p.latitude
		end

	elevation: DOUBLE
			--
		do
			Result := p.elevation
		end

	time: DATE_TIME
			--
		do
			Result := t
		end

feature -- Measurement

feature -- Status report

feature -- Status setting

	set_position (pos: like p)
			--
		require
			attached_pos: attached pos
		do
			p := pos
		end

	set_longitude (lon: like p.longitude)
			--
		require
			attached_position: attached position
			valid_longitude: lon >= -180.0 and lon <= 180.0
		do
			p.set_longitude (lon)
		end

	set_latitude (lat: like p.latitude)
			--
		require
			attached_position: attached position
			valid_latitude: lat >= -90.0 and lat <= 90.0
		do
			p.set_latitude (lat)
		end

	set_elevation (elev: like p.elevation)
			--
		require
			attached_position: attached position
		do
			p.set_elevation (elev)
		end

	set_time (dt: like t)
			--
		require
			attached_dt: attached dt
		do
			t := dt.twin
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

	p: POSITION
			--
	t: DATE_TIME
			--

invariant
	invariant_clause: True -- Your invariant here

end
