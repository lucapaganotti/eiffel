note
	description: "[
		Summary description for {BM_CONSTANTS}.
	
		0000 --> 0
		0001 --> 1
		0010 --> 2
		0011 --> 3
		0100 --> 4
		0101 --> 5
		0110 --> 6
		0111 --> 7
		1000 --> 8
		1001 --> 9
		1010 --> A --> 10
		1011 --> B --> 11
		1100 --> C --> 12
		1101 --> D --> 13
		1110 --> E --> 14
		1111 --> F --> 15
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"



class
	BM_CONSTANTS

feature -- Constants

	byte_size: INTEGER = 8

feature -- bitwise masks

	-- 87654321
	--
	-- 00000001
	-- 00000010
	-- ...
	-- 01000000
	-- 10000000

	bm0: INTEGER_8 = 0x00	--   0
	bm1: INTEGER_8 = 0x01	--   1
	bm2: INTEGER_8 = 0x02	--   2
	bm3: INTEGER_8 = 0x04	--   4
	bm4: INTEGER_8 = 0x08	--   8
	bm5: INTEGER_8 = 0x10	--  16
	bm6: INTEGER_8 = 0x20	--  32
	bm7: INTEGER_8 = 0x40	--  64
	bm8: INTEGER_8 = 0x80	-- 128

	-- 11111110
	-- 11111101
	-- ...
	-- 10111111
	-- 01111111

	nbm1: INTEGER_8 = 0xFE
	nbm2: INTEGER_8 = 0xFD
	nbm3: INTEGER_8 = 0xFB
	nbm4: INTEGER_8 = 0xF7
	nbm5: INTEGER_8 = 0xEF
	nbm6: INTEGER_8 = 0xDF
	nbm7: INTEGER_8 = 0xBF
	nbm8: INTEGER_8 = 0x7F

end
