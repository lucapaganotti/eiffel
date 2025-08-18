note
	description: "Summary description for {HEX_TO_BIN_MAP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HEX_TO_BIN_MAP

create
	make_map

feature {NONE} -- Initialization

	make_map
			-- Initialization for `Current'.
		do
			create map.make (0)
			init
		end

	init
			--
		once
			map.extend ("0000", '0')
			map.extend ("0001", '1')
			map.extend ("0010", '2')
			map.extend ("0011", '3')
			map.extend ("0100", '4')
			map.extend ("0101", '5')
			map.extend ("0110", '6')
			map.extend ("0111", '7')
			map.extend ("1000", '8')
			map.extend ("1001", '9')
			map.extend ("1010", 'A')
			map.extend ("1011", 'B')
			map.extend ("1100", 'C')
			map.extend ("1101", 'D')
			map.extend ("1110", 'E')
			map.extend ("1111", 'F')
		end

feature -- Access

	map: HASH_TABLE[STRING, CHARACTER_8]

end
