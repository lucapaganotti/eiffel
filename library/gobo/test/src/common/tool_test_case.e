indexing

	description:

		"Tools test cases"

	copyright: "Copyright (c) 2001-2002, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

deferred class TOOL_TEST_CASE

inherit

	PROGRAM_TEST_CASE

feature {NONE} -- Implementation

	program_dirname: STRING is
			-- Name of program source directory
		do
			Result := file_system.nested_pathname ("${GOBO}", <<"src", program_name>>)
			Result := Execution_environment.interpreted_string (Result)
		end

end
