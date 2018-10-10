note
	description: "Summary description for {SBS_MSG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SBS_MSG

	inherit
		MSG

create
	make,
	make_with_text

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create text.make_empty
			create t.make_empty
			create h.make_empty
			create d_gen.make_now_utc
			create t_gen.make_now_utc
			create d_log.make_now_utc
			create t_log.make_now_utc
			create c.make_empty
		end

	make_with_text (txt: STRING)
			--
		require
			attached_t: attached txt
		do
			create text.make_empty
			create t.make_empty
			create h.make_empty
			create d_gen.make_now_utc
			create t_gen.make_now_utc
			create d_log.make_now_utc
			create t_log.make_now_utc
			create c.make_empty
			set_text(txt)
			parse
		end

feature -- Access

	type: STRING
			-- Message type
		do
			Result := t
		end

	transmission: INTEGER
			-- MSG sub types 1 to 8. Not used by other message types.
		do
			Result := tx
		end

	session: INTEGER
			-- Database Session record number
		do
			Result := s
		end

	aircraft: INTEGER
			-- Database Aircraft record number
		do
			Result := a
		end

	hex: STRING
			-- Aircraft Mode S hexadecimal code
		do
			Result := h
		end

	flight: INTEGER
			-- Database Flight record number
		do
			Result := f
		end

	date_msg_generated: DATE
			-- Date message generated
		do
			Result := d_gen
		end

	time_msg_generated: TIME
			-- Time message generated
		do
			Result :=  t_gen
		end

	date_msg_logged: DATE
			-- Date message logged
		do
			Result :=  d_log
		end

	time_msg_logged: TIME
			-- Time message logged
		do
			Result := t_log
		end

	callsign: STRING
			-- An eight digit flight ID - can be flight number or registration (or even nothing).
		do
			Result := c
		end

	altitude: INTEGER
			-- Mode C altitude. Height relative to 1013.2mb (Flight Level). Not height AMSL.
		do
			Result := alt
		end

	ground_speed: DOUBLE
			-- Speed over ground (not indicated airspeed)
		do
			Result := g_speed
		end

	track: DOUBLE
			-- Track of aircraft (not heading). Derived from the velocity E/W and velocity N/S
		do
			Result := tk
		end

	latitude: DOUBLE
			-- North and East positive. South and West negative.
		do
			Result := lat
		end

	longitude: DOUBLE
			-- North and East positive. South and West negative.
		do
			Result := lon
		end

	vertical_rate: DOUBLE
			-- 64ft resolution
		do
			Result := vr
		end

	squawk: INTEGER
			-- Assigned Mode A squawk code.
		do
			Result := sqk
		end

	alert, squawk_change: INTEGER
			-- Flag to indicate squawk has changed. (Squawk change)
		do
			Result := alrt
		end

	emergency: INTEGER
			-- Flag to indicate emergency code has been set
		do
			Result := er
		end

	spi: INTEGER
			-- Flag to indicate transponder Ident has been activated. (Ident)
		do
			Result := sp
		end

	on_ground: INTEGER
			-- Flag to indicate ground squat switch is active
		do
			Result := og
		end

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

	debug_output
			--
		do
			io.put_string ("Type:            " + type                                                   + nl.out)
			io.put_string ("Transmission:    " + transmission.out                                       + nl.out)
			io.put_string ("Session:         " + session.out                                            + nl.out)
			io.put_string ("Aircraft:        " + aircraft.out                                           + nl.out)
			io.put_string ("Hex ID:          " + hex                                                    + nl.out)
			io.put_string ("Flight:          " + flight.out                                             + nl.out)
			io.put_string ("Generation date: " + date_msg_generated.formatted_out (default_date_format) + nl.out)
			io.put_string ("Generation time: " + time_msg_generated.formatted_out (default_time_format) + nl.out)
			io.put_string ("Logging date:    " + date_msg_logged.formatted_out (default_date_format)    + nl.out)
			io.put_string ("Logging time:    " + time_msg_logged.formatted_out (default_time_format)    + nl.out)
			io.put_string ("Callsign:        " + callsign                                               + nl.out)
			io.put_string ("Altitude:        " + altitude.out                                           + nl.out)
			io.put_string ("Ground speed:    " + ground_speed.out                                       + nl.out)
			io.put_string ("Track:           " + track.out                                              + nl.out)
			io.put_string ("Latitude:        " + latitude.out                                           + nl.out)
			io.put_string ("Longitude:       " + longitude.out                                          + nl.out)
			io.put_string ("Vertical rate:   " + vertical_rate.out                                      + nl.out)
			io.put_string ("Squawk:          " + squawk.out                                             + nl.out)
			io.put_string ("Alert:           " + alert.out                                              + nl.out)
			io.put_string ("Emergency:       " + emergency.out                                          + nl.out)
			io.put_string ("Spi:             " + spi.out                                                + nl.out)
			io.put_string ("On ground:       " + on_ground.out                                          + nl.out)
			io.put_string ("**********----------**********" + nl.out)
		end

feature -- Constants

	type_position: INTEGER = 1
			-- Message type

	transmission_position: INTEGER = 2
			-- Transmission position
			-- MSG sub types 1 to 8. Not used by other message types.

	session_position: INTEGER = 3
			-- Database Session record number position

	aircraft_position: INTEGER = 4
			-- Database Aircraft record number position

	hex_position: INTEGER = 5
			-- Aircraft Mode S hexadecimal code position

	flight_position: INTEGER = 6
			-- Database Flight record number position

	date_msg_generated_position: INTEGER = 7
			-- Date message generated position

	time_msg_generated_position: INTEGER = 8
			-- Time message generated position

	date_msg_logged_position: INTEGER = 9
			-- Date message logged position

	time_msg_logged_position: INTEGER = 10
			-- Time message logged

	callsign_position: INTEGER = 11
			-- Callsign position
			-- An eight digit flight ID - can be flight number or registration (or even nothing).

	altitude_position: INTEGER = 12
			-- Mode C altitude. Height relative to 1013.2mb (Flight Level). Not height AMSL.

	ground_speed_position: INTEGER = 13
			-- Ground speed position
			-- Speed over ground (not indicated airspeed)

	track_position: INTEGER = 14
			-- Track position
			-- Track of aircraft (not heading). Derived from the velocity E/W and velocity N/S

	latitude_position: INTEGER = 15
			-- Latitude position
			-- North and East positive. South and West negative.

	longitude_position: INTEGER = 16
			-- Longitude position
			-- North and East positive. South and West negative.

	vertical_rate_position: INTEGER = 17
			-- Vertical rate position
			-- 64ft resolution

	squawk_position: INTEGER = 18
			-- Squawk position
			-- Assigned Mode A squawk code.

	alert_position, squawk_change_position: INTEGER = 19
			-- Alert position
			-- Flag to indicate squawk has changed. (Squawk change)

	emergency_position: INTEGER = 20
			-- Emergency position
			-- Flag to indicate emergency code has been set

	spi_position: INTEGER = 21
			-- Spi position
			-- Flag to indicate transponder Ident has been activated. (Ident)

	on_ground_position: INTEGER = 22
			-- On ground position
			-- Flag to indicate ground squat switch is active

feature -- Basic operations

	clear
			--
		do
			t.wipe_out
			tx := 0
			s := 0
			a := 0
			h.wipe_out
			f := 0
			d_gen.set_date (1970, 1, 1)
			t_gen.set_hour (0)
			t_gen.set_minute (0)
			t_gen.set_second (0)
			d_log.set_date (1970, 1, 1)
			t_log.set_hour (0)
			t_log.set_minute (0)
			t_log.set_second (0)
			c.wipe_out
			alt := 0
			g_speed := 0.0
			tk := 0.0
			lat := 0.0
			lon := 0.0
			vr := 0.0
			sqk := 0
			alrt := 0
			er := 0
			sp := 0
			og := 0

			set_text ("")
		end

	parse
			-- from `MSG`
		local
			tokens: LIST[STRING]
			i:      INTEGER
			dt:     DATE
			tm:     TIME
		do
			create dt.make_now_utc
			create tm.make_now_utc

			if attached text as it then
				tokens := it.split (comma)
				from tokens.start
				until tokens.after
				loop
					i := i + 1
					inspect i
					when type_position then
						t := tokens.item.twin
					when transmission_position then
						if tokens.item.is_integer then
							tx := tokens.item.to_integer
						end
					when session_position then
						if tokens.item.is_integer then
							s := tokens.item.to_integer
						end
					when aircraft_position then
						if tokens.item.is_integer then
							a := tokens.item.to_integer
						end
					when hex_position then
						h := tokens.item.twin
					when flight_position then
						if tokens.item.is_integer then
							f := tokens.item.to_integer
						end
					when date_msg_generated_position then
						-- "yyyy-[0]mm-[0]dd hh:[0]mi:[0]ss.ff"
						if dt.date_valid (tokens.item, default_date_format) then
							create dt.make_from_string (tokens.item, default_date_format)
							d_gen := dt.twin
						end
					when time_msg_generated_position then
						if tm.time_valid (tokens.item, default_time_format) then
							create tm.make_from_string (tokens.item, default_time_format)
							t_gen := tm.twin
						end
					when date_msg_logged_position then
						-- "yyyy-[0]mm-[0]dd hh:[0]mi:[0]ss.ff"
						if dt.date_valid (tokens.item, default_date_format) then
							create dt.make_from_string (tokens.item, default_date_format)
							d_log := dt.twin
						end
					when time_msg_logged_position then
						if tm.time_valid (tokens.item, default_time_format) then
							create tm.make_from_string (tokens.item, default_time_format)
							t_log := tm.twin
						end
					when callsign_position then
						c := tokens.item.twin
					when altitude_position then
						if tokens.item.is_integer then
							alt := tokens.item.to_integer
						end
					when ground_speed_position then
						if tokens.item.is_double then
							g_speed := tokens.item.to_double
						end
					when track_position then
						if tokens.item.is_double then
							tk := tokens.item.to_double
						end
					when latitude_position then
						if tokens.item.is_double then
							lat := tokens.item.to_double
						end
					when longitude_position then
						if tokens.item.is_double then
							lon := tokens.item.to_double
						end
					when vertical_rate_position then
						if tokens.item.is_double then
							vr := tokens.item.to_double
						end
					when squawk_position then
						if tokens.item.is_integer then
							sqk := tokens.item.to_integer
						end
					when alert_position then
						if tokens.item.is_integer then
							alrt := tokens.item.to_integer
						end
					when emergency_position then
						if tokens.item.is_integer then
							er := tokens.item.to_integer
						end
					when spi_position then
						if tokens.item.is_integer then
							sp := tokens.item.to_integer
						end
					when on_ground_position then
						if tokens.item.is_integer then
							og := tokens.item.to_integer
						end
					else
						io.put_string ("NOT an SBS1 valid token%N")
					end

					tokens.forth
				end
			end
		end

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	t: STRING
			-- Message type

	tx: INTEGER
			-- MSG sub types 1 to 8. Not used by other message types.

	s: INTEGER
			-- Database Session record number

	a: INTEGER
			-- Database Aircraft record number

	h: STRING
			-- Aircraft Mode S hexadecimal code

	f: INTEGER
			-- Database Flight record number

	d_gen: DATE
			-- Date message generated

	t_gen: TIME
			-- Time message generated

	d_log: DATE
			-- Date message logged

	t_log: TIME
			-- Time message logged

	c: STRING
			-- An eight digit flight ID - can be flight number or registration (or even nothing).

	alt: INTEGER
			-- Mode C altitude. Height relative to 1013.2mb (Flight Level). Not height AMSL.

	g_speed: DOUBLE
			-- Speed over ground (not indicated airspeed)

	tk: DOUBLE
			-- Track of aircraft (not heading). Derived from the velocity E/W and velocity N/S

	lat: DOUBLE
			-- North and East positive. South and West negative.

	lon: DOUBLE
			-- North and East positive. South and West negative.

	vr: DOUBLE
			-- 64ft resolution

	sqk: INTEGER
			-- Assigned Mode A squawk code.

	alrt: INTEGER
			-- Flag to indicate squawk has changed. (Squawk change)

	er: INTEGER
			-- Flag to indicate emergency code has been set

	sp: INTEGER
			-- Flag to indicate transponder Ident has been activated. (Ident)

	og: INTEGER
			-- Flag to indicate ground squat switch is active


invariant
	invariant_clause: True -- Your invariant here

end
