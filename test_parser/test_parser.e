note
	description: "test_parser application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_PARSER

inherit
	ARGUMENTS_32

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
			create lexer.make
		end

	lexer: METAR_LEXER

end
