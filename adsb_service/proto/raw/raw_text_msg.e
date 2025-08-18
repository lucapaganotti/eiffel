note
	description: "Summary description for {RAW_TEXT_MSG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RAW_TEXT_MSG

inherit
	BASE_RAW_TEXT_MSG
		redefine
			make_from_string, out
		end

create
	make_from_string

feature {NONE} -- Initialization

	make_from_string (t: STRING)
			-- Initialization for `Current'.
		do
			Precursor (t)
			create addr.make_empty
			create pi.make_empty

			extract_df
			extract_ca
			extract_addr
			extract_me
			extract_pi
		end

	dff: DF17_ME_FACTORY

feature -- Access

	df:             INTEGER
	ca:             INTEGER
	addr:           STRING
	me:             ME_SEGMENT
	pi:             STRING

feature -- Commands

	set_df (d: INTEGER)
			--
		do
			df := d
		end

	set_ca (c: INTEGER)
			--
		do
			ca := c
		end

	set_addr(a: STRING)
			--
		require
			a_attached: attached a
		do
			addr := a
		ensure
			addr_set: addr.is_equal (a)
		end

feature -- IO

	out: STRING
			--
		do
			Result := df.out + " " + ca.out + " " + addr + " " + me.out + " " + pi
		end

feature {NONE} -- Decoding

	extract_df
			--
		require
			bin_text_attached_and_valid: attached bin_text and (bin_text.count = short_bin_msg_length or bin_text.count = long_bin_msg_length)
		do
			df := bin2int (bin_text.head (5))
		end

	extract_ca
			--
		require
			bin_text_attached_and_valid: attached bin_text and (bin_text.count = short_bin_msg_length or bin_text.count = long_bin_msg_length)
		do
			ca := bin2int (bin_text.substring (6, 8))
		end

	extract_addr
			--
		require
			hex_text_attached_and_valid: attached text and (text.count = short_hex_msg_length or text.count = long_hex_msg_length)
		do
			addr := text.substring (3, 8)
		end

	extract_me
			--
		require
			hex_text_attached_and_valid: attached text and (text.count = short_hex_msg_length or text.count = long_hex_msg_length)
		local
			sd: ME_SEGMENT_DATA
		do
			create me.make_from_string (text.substring (9, 14))
			sd := dff.create_df17_me_segment (me.type_code, me.text)
			if attached {AIRCRAFT_IDENTIFICATION_ME_SEGMENT_DATA} sd as l_sd then
				me.identification := l_sd
			end
		end

	extract_pi
			--
		require
			bin_text_attached_and_valid: attached bin_text and (bin_text.count = short_bin_msg_length or bin_text.count = long_bin_msg_length)
		do
			pi := bin_text.tail (24)
		end

end
