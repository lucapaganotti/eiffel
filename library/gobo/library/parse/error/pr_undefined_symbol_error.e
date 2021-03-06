indexing

	description:

		"Error: Undefined symbol"

	library: "Gobo Eiffel Parse Library"
	copyright: "Copyright (c) 1999, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2008-10-06 09:53:14 +0200 (Mon, 06 Oct 2008) $"
	revision: "$Revision: 6531 $"

class PR_UNDEFINED_SYMBOL_ERROR

inherit

	UT_ERROR

create

	make

feature {NONE} -- Initialization

	make (filename: STRING; a_name: STRING) is
			-- Create a new error reporting that the symbol
			-- `a_name' has not been defined as a token or
			-- in a rule.
		require
			filename_not_void: filename /= Void
			a_name_not_void: a_name /= Void
		do
			create parameters.make (1, 2)
			parameters.put (filename, 1)
			parameters.put (a_name, 2)
		end

feature -- Access

	default_template: STRING is "%"$1%": undefined symbol $2"
			-- Default template used to built the error message

	code: STRING is "PR0010"
			-- Error code

invariant

--	dollar0: $0 = program name
--	dollar1: $1 = filename
--	dollar2: $2 = symbol name

end
