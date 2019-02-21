note
	description: "Summary description for {BITMAP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BITMAP

inherit
	BM_CONSTANTS

create

	make,
	make_with_word_size,
	make_with_pizel_size

feature {NONE} -- Creation

	make
			--
		local
			l_w: WORD
		do
			create l_w.make
			create data.make_filled (l_w, 0, 0)
		end

	make_with_word_size (h, w: INTEGER)
			--
		local
			l_w: WORD
		do
			height := h
			width  := w * byte_size
			create l_w.make
			create data.make_filled (l_w, h, w)
		end

	make_with_pizel_size (h, w: INTEGER)
			--
		local
			l_w: WORD
		do
			height := h
			width  := w
			create l_w.make
			create data.make_filled (l_w, height, width)
		end


feature {NONE} -- Implementation

	height: INTEGER
			--
	width:  INTEGER
			--

	data: detachable ARRAY2[WORD]

end
