note
	description: "Summary description for {ME_SEGMENT_DATA}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ME_SEGMENT_DATA

inherit
	RAW_UTILS

feature -- Access

	bin_text:          STRING   assign set_bin_text

	tc: INTEGER
    		--
    	once
    		Result := bin2int (bin_text.substring (1, 5))
    	end

feature -- Commands

	set_bin_text (t: STRING)
			--
		require
			t_attached: attached t
		do
			bin_text.copy (t)
		ensure
			bin_text_set: bin_text.is_equal (t)
		end

feature -- Operations

	decode
			--
		deferred end

end
