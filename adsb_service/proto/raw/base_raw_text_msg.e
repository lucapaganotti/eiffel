note
	description: "Summary description for {BASE_RAW_TEXT_MSG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BASE_RAW_TEXT_MSG

	inherit
		RAW_MSG_CONSTANTS
		RAW_UTILS

create
	make_from_string

feature {NONE} -- Initialization

	make_from_string (t: STRING)
			--
		require
			t_attached: attached t
		do
			create hmap.make_map
			if t.has (asterisk) then
				t.prune_all_leading (asterisk)
			end
			if t.has (semicolon) then
				t.prune_all_trailing (semicolon)
			end
			text := t

			check text.count = short_hex_msg_length or text.count = long_hex_msg_length or text.count = hex_me_segment_length end

			create bin_text.make_empty
			to_bin
		ensure
			text_set: text = t
		end

feature -- Access

	text:     STRING assign set_text
	bin_text: STRING
	hmap:     HEX_TO_BIN_MAP

feature -- Commands

	set_text (t: STRING)
			--
		require
			t_attached: attached t
		do
			text := t
		ensure
			text_set: text = t
		end

feature {NONE} -- Operations

	to_bin
			--
		local
			i: INTEGER
		do
			from i := 1
			until i = text.count
			loop
				if attached hmap.map.item (text.item (i)) as l_i then
					bin_text.append (l_i)
				end
			end

			check bin_text.count = short_bin_msg_length or bin_text.count = long_bin_msg_length or bin_text.count = bin_me_segment_length end
		end

end
