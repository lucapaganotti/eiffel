note
	description: "Summary description for {AIRCRAFT_IDENTIFICATION_ME_SEGMENT_DATA}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AIRCRAFT_IDENTIFICATION_ME_SEGMENT_DATA

inherit
	AIRCRAFT_CATEGORY_CONSTANTS
	ME_SEGMENT_DATA

create
	make_from_string

feature {NONE} -- Initialization

	make_from_string (t: STRING)
			-- Initialization for `Current'.
		do
			bin_text := t
			create callsign.make_empty
			decode
		end

feature -- Access

	callsign:          STRING   assign set_callsign
	aircraft_category: INTEGER  assign set_aircraft_category

	ac: detachable STRING
			--
		once
			if tc = 1 then
				Result := Ac_Reserved
			elseif tc = 2 then
				inspect aircraft_category
				when 0 then Result := ac_unknown
				when 1 then Result := ac_surface_emergency
				when 3 then Result := ac_surface_service
				when 4 then Result := ac_ground_obstruction
				when 5 then Result := ac_ground_obstruction
				when 6 then Result := ac_ground_obstruction
				when 7 then Result := ac_ground_obstruction
				else
					Result := ac_unknown
				end
			elseif tc = 3 then
				inspect aircraft_category
				when 0 then Result := ac_unknown
				when 1 then Result := ac_glider_sailplane
				when 2 then Result := ac_lighter_than_air
				when 3 then Result := ac_parachutist_skydiver
				when 4 then Result := ac_ultralight_hangglider_paraglider
				when 5 then Result := ac_reserved
				when 6 then Result := ac_unmanned_aerial_vehicle
				when 7 then Result := ac_space_or_transatmospheric_vehicle
				else
					Result := ac_unknown
				end
			elseif tc = 4 then
				inspect aircraft_category
				when 0 then Result := ac_unknown
				when 1 then Result := ac_light
				when 2 then Result := ac_medium_1
				when 3 then Result := ac_medium_2
				when 4 then Result := ac_high_vortex_aircraft
				when 5 then Result := ac_heavy
				when 6 then Result := ac_high_performance
				when 7 then Result := ac_rotorcraft
				else
					Result := ac_unknown
				end
			end
		end

feature -- Commands

	set_callsign (cs: STRING)
			--
		require
			cs_attached: attached cs
		do
			callsign.copy (cs)
		ensure
			callsign_set: callsign.is_equal (cs)
		end

	set_aircraft_category (ca: INTEGER)
			--
		do
			aircraft_category := ca
		end

feature -- Operations

	decode
			--
		do
			extract_cs
			extract_ca
		end

feature {NONE}

	extract_ca
			--
		do
			aircraft_category := bin2int (bin_text.substring (6, 8))
		end

	extract_cs
			--
		local
			c1, c2, c3, c4, c5, c6, c7, c8: INTEGER
		do
			c1 := bin2int (bin_text.substring ( 9, 14))
			c2 := bin2int (bin_text.substring (15, 20))
			c3 := bin2int (bin_text.substring (21, 26))
			c4 := bin2int (bin_text.substring (27, 32))
			c5 := bin2int (bin_text.substring (33, 38))
			c6 := bin2int (bin_text.substring (39, 44))
			c7 := bin2int (bin_text.substring (45, 50))
			c8 := bin2int (bin_text.substring (51, 56))

			callsign := cs_charmap.item (c1).as_upper.out + cs_charmap.item (c2).as_upper.out + cs_charmap.item (c3).as_upper.out + cs_charmap.item (c4).as_upper.out +
			            cs_charmap.item (c5).as_upper.out + cs_charmap.item (c6).as_upper.out + cs_charmap.item (c7).as_upper.out + cs_charmap.item (c8).as_upper.out
		end

end
