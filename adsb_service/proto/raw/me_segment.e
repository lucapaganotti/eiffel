note
	description: "Summary description for {ME_SEGMENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ME_SEGMENT

inherit
	TYPE_CODE_CONSTANTS
		redefine
			out
		end
	BASE_RAW_TEXT_MSG
	redefine
		make_from_string,
		out
	end

create
	make_from_string

feature {NONE} -- Initialization

	make_from_string (t: STRING)
			-- Initialization for `Current'.
		do
			Precursor (t)
			extract_tc
		end

feature -- Access

	type_code:      INTEGER assign set_type_code

	identification: detachable AIRCRAFT_IDENTIFICATION_ME_SEGMENT_DATA assign set_identification

feature -- Command

	set_type_code (c: INTEGER)
			--
		do
			type_code := c
		end

	set_identification (i: detachable AIRCRAFT_IDENTIFICATION_ME_SEGMENT_DATA)
			--
		do
			identification := i
		end

feature -- IO

	out: STRING
			--
		do
			Result := type_code.out
		end

feature {NONE} -- Operations

	extract_tc
			--
		require
			bin_text_attached_and_valid: attached bin_text and bin_text.count = bin_me_segment_length
		do
			type_code := bin2int (bin_text.head (5))
		end

end
