note
	description: "Summary description for {AIRLINE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AIRLINE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create name.make_empty
			create icao.make_empty
			create iata.make_empty
			create country.make_empty
			create country_iso.make_empty
			create callsign.make_empty
		end

feature -- Access

	name: STRING assign set_name
	icao: STRING assign set_icao
	iata: STRING assign set_iata
	country: STRING assign set_country
	country_iso: STRING assign set_country_iso
	callsign: STRING assign set_callsign

feature -- Commands

	set_name (n: STRING)
			--
		require
			n_attached: attached n
		do
			name.copy (n)
		ensure
			name_set: name.is_equal (n)
		end

	set_icao (c: STRING)
			--
		require
			c_attached: attached c
		do
			icao.copy (c)
		ensure
			icao_set: icao.is_equal (c)
		end

	set_iata (c: STRING)
			--
		require
			c_attached: attached c
		do
			iata.copy (c)
		ensure
			iata_set: iata.is_equal (c)
		end

	set_country (c: STRING)
			--
		require
			c_attached: attached c
		do
			country.copy (c)
		ensure
			country_set: country.is_equal (c)
		end

	set_country_iso (c: STRING)
			--
		require
			c_attached: attached c
		do
			country_iso.copy (c)
		ensure
			country_iso_set: country_iso.is_equal (c)
		end

	set_callsign (c: STRING)
			--
		require
			c_attached: attached c
		do
			callsign.copy (c)
		ensure
			callsign_set: callsign.is_equal (c)
		end

end
