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

	id: INTEGER
	name: STRING
	icao: STRING
	iata: STRING
	arp: POINT
	mrt: POINT
	rwys: ARRAYED_LIST[RWY]

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create name.make_empty
			create icao.make_empty
			create iata.make_empty
			create arp.make
			create mrt.make
			create rwys.make (0)
		end

	make_from_params (i: INTEGER n, ic, ia: STRING a, m: POINT rs: ARRAYED_LIST[RWY])
			--
		do
			id := i
			name := n
			icao := ic
			iata := ia
			arp := a
			mrt := m
			rwys := rs
		end

feature -- IO

	out: STRING
			--
		do
			create Result.make_empty
			Result.append (name + " - " + icao + " - " + iata)
		end

end
