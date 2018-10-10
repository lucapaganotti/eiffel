note
	description: "Summary description for {AIRCRAFT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AIRCRAFT

create
	make

feature {NONE} -- Initialization

	make
			--
		do
			create h.make_empty
			create c.make_from_string ({MSG_CONSTANTS}.not_assigned)
			create last_upd.make_now_utc
			create b.make (0)
		end

feature -- Access

	hex: STRING
			--
		do
			Result := h
		end

	callsign: STRING
			--
		do
			Result := c
		end

	squawk: INTEGER
			--
		do
			Result := s
		end

	alert: INTEGER
			--
		do
			Result := a
		end

	emergency: INTEGER
			--
		do
			Result := e
		end

	spi: INTEGER
			--
		do
			Result := p
		end

	on_ground: INTEGER
			--
		do
			Result := g
		end

	last_updated: DATE_TIME
			--
		do
			Result := last_upd
		end

	beats: ARRAYED_LIST[BEAT]
			--
		do
			Result := b
		end

feature -- Measurement

feature -- Status report

	debug_output
			--
		local
			intfd: FORMAT_INTEGER
			dblfd: FORMAT_DOUBLE
		do
			create intfd.make (5)
			create dblfd.make (10, 6)
			io.put_string (lbracket.out +
							hex + space.out +
							callsign + space.out +
							intfd.formatted (squawk) + space.out +
							intfd.formatted (alert) + space.out +
							intfd.formatted (emergency) + space.out +
							intfd.formatted (spi) + space.out +
							intfd.formatted (on_ground) + space.out +
							intfd.formatted (beats.count))
			if beats.count > 0 then
				io.put_string (space.out + lcurly.out + beats.last.time.formatted_out ({MSG_CONSTANTS}.default_date_time_format) + space.out +
							dblfd.formatted (beats.last.longitude) + space.out +
							dblfd.formatted (beats.last.latitude) + space.out +
							dblfd.formatted (beats.last.elevation) + rcurly.out)
			end
			io.put_string (rbracket.out + nl.out)
		end

feature -- Status setting

	set_hex (a_hex: STRING)
			--
		require
			attached_a_hex: attached a_hex
		do
			h := a_hex.twin
		end

	set_callsign (a_callsign: STRING)
			--
		require
			attached_a_callsign: attached a_callsign
		do
			c := a_callsign.twin
		end

	set_squawk (a_squawk: INTEGER)
			--
		do
			s := a_squawk
		end

	set_alert (a_alert: INTEGER)
			--
		do
			a := a_alert
		end

	set_emergency (a_emergency: INTEGER)
			--
		do
			e := a_emergency
		end

	set_spi (a_spi: INTEGER)
			--
		do
			p := a_spi
		end

	set_on_ground (og: INTEGER)
			--
		do
			g := og
		end

	set_last_updated (dt: DATE_TIME)
			--
		require
			attached_dt: attached dt
		do
			last_upd := dt.twin
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

feature -- Constants

	lbracket: CHARACTER = '['
			--
	rbracket: CHARACTER = ']'
			--
	lcurly: CHARACTER = '{'
			--
	rcurly: CHARACTER = '}'
			--
	space: CHARACTER = ' '
			--
	nl: CHARACTER = '%N'
			--

feature {NONE} -- Implementation

	h: STRING
			-- `hex`

	c: STRING
			-- `callsign`

	s: INTEGER
			-- `squawk`

	a: INTEGER
			-- `alert`

	e: INTEGER
			-- `emergency`

	p: INTEGER
			-- `spi`

	g: INTEGER
			-- `on_ground`

	last_upd: DATE_TIME
			-- `last_updated`

	b: ARRAYED_LIST[BEAT]
			-- `beats`

invariant
	invariant_clause: True -- Your invariant here

end
