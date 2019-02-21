note
	description: "Summary description for {WORD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WORD

inherit
	BM_CONSTANTS

create
	make,
	make_with_byte

feature {NONE} -- Creation

	make
			--
		do
		end

	make_with_byte (b: INTEGER_8)
			--
		do
			item := b
		end

feature -- Access

	value: like item
			--
		do
			Result := item
		end

	bit (i: INTEGER_8): INTEGER_8
			--
		require
			valid_position: i >=1 and i <= 8
		local
			l_bit: INTEGER_8
		do
			l_bit := item

			Result := (l_bit |>> i) & bm1

		end

feature -- Status setting

	set_value (v: like item)
			--
		do
			item := v
		end

	high_bit (i: like item)
			--
		require
			valid_position: i >=1 and i <= 8
		local
			mask: INTEGER_8
		do
			inspect
				i
			when 1 then
				mask := bm1
			when 2 then
				mask := bm2
			when 3 then
				mask := bm3
			when 4 then
				mask := bm4
			when 5 then
				mask := bm5
			when 6 then
				mask := bm6
			when 7 then
				mask := bm7
			when 8 then
				mask := bm8
			end
			item := item | mask
		end

	low_bit (i: INTEGER)
			--
		require
			valid_position: i >=1 and i <= 8
		local
			mask: INTEGER_8
		do
			inspect
				i
			when 1 then
				mask := bm1
			when 2 then
				mask := bm2
			when 3 then
				mask := bm3
			when 4 then
				mask := bm4
			when 5 then
				mask := bm5
			when 6 then
				mask := bm6
			when 7 then
				mask := bm7
			when 8 then
				mask := bm8
			end
			item := item & (mask.bit_not)
		end


feature {NONE} -- Implementation

	item: INTEGER_8

end
