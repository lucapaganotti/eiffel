note
	description: "Summary description for {AIRPORT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AIRPORT

inherit
	ANY
		redefine
			out
		end

create
	make,
	make_from_params

feature -- Access

	id:           INTEGER
	name:         STRING
	municipality: STRING
	icao:         STRING
	iata:         STRING
	country:      STRING
	country_iso:  STRING
	arp:          POINT
	mrt:          POINT
	runways:      ARRAYED_LIST [RWY]

feature -- Commands

	set_id (i: INTEGER)
			--
		do
			id := i
		end

	set_name (n: STRING)
			--
		require
			n_attached: attached n
		do
			name := n
		ensure
			name_set: name.is_equal (n)
		end

	set_municipality (m: STRING)
			--
		require
			m_attached: attached m
		do
			municipality := m
		ensure
			municipality_set: municipality.is_equal (m)
		end

	set_icao (c: STRING)
			--
		require
			c_attached: c /= Void
		do
			icao := c
		ensure
			icao_set: icao.is_equal (c)
		end

	set_iata (c: STRING)
			--
		require
			c_attached: c /= Void
		do
			iata := c
		ensure
			iata_set: iata.is_equal (c)
		end

	set_country (c: STRING)
			--
		require
			c_attached: attached c
		do
			country := c
		ensure
			country_set: country.is_equal (c)
		end

	set_country_iso (c: STRING)
			--
		require
			c_attached: attached c
		do
			country_iso := c
		ensure
			country_iso_set: country_iso.is_equal (c)
		end

	set_arp (p: POINT)
			--
		require
			p_attached: attached p
		do
			arp := p
		ensure
			arp_set: arp = p
		end

	set_mrt (p: POINT)
			--
		require
			p_attached: attached p
		do
			mrt := p
		ensure
			mrt_set: mrt = p
		end

	set_runways (r: ARRAYED_LIST[RWY])
			--
		require
			r_attached: attached r
		do
			runways := r
		ensure
			runways_set: runways = r
		end

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create name.make_empty
			create municipality.make_empty
			create icao.make_empty
			create iata.make_empty
			create country.make_empty
			create country_iso.make_empty
			create arp.make
			create mrt.make
			create runways.make (0)
		end

	make_from_params (i: INTEGER n, mu, ic, ia, c, c_iso: STRING a, m: POINT rs: ARRAYED_LIST [RWY])
			--
		do
			id           := i
			name         := n
			icao         := ic
			iata         := ia
			country      := c
			country_iso  := c_iso
			municipality := mu
			arp          := a
			mrt          := m
			runways      := rs
		end

feature -- IO

	out: STRING
			--
		do
			create Result.make_empty
			Result.append (name + " - " + icao + " - " + iata)
		end

end
