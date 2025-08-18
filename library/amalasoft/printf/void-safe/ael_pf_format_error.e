note
	description: "A class representing a single formatting error instance"
	license: "Eiffel Forumn License v2 - See license.txt"
	source: "{
		Amalasoft Corporation
		273 Harwood Avenue
		Littleton, MA 01460 USA
		}"
	status: "Copyright 1995-2008, Amalasoft";
	date: "$Date: 2008/04/21 $";
	revision: "$Revision: 003$"

class AEL_PF_FORMAT_ERROR

inherit
	AEL_PF_FORMATTING_CONSTANTS
		redefine
			out
		end;

create
	make

feature {NONE} -- Creation

	make (fmt: STRING; pos: INTEGER) is
		require
			format_exists: fmt /= Void and then not fmt.is_empty
			valid_error_position: pos > 0
		do
			format_string := fmt.twin
			position := pos
			-- Init variables
			actual_arg_type := ""
			expected_arg_type := ""
		end

feature -- Error context

	format_string: STRING
		-- Copy of original format string

	position: INTEGER
		-- Position within format string where error occurred

	error_code: INTEGER
		-- Identity of error

	expected_arg_count: INTEGER
	actual_arg_count: INTEGER 

	expected_arg_type: STRING
	actual_arg_type: STRING 

	type_character: CHARACTER

	internal_error_msg: detachable STRING

feature {NONE} -- Private context setting

	set_error_code (v: INTEGER) is
		do
			error_code := v
		end

feature {AEL_PF_FORMAT_ERROR_SUPPORT} -- Context setting

	set_arg_count_error (expected, actual: INTEGER) is
		-- Set the error to be an arg count mismatch
		do
			set_error_code (K_printf_fmt_err_arg_count)
			expected_arg_count := expected
			actual_arg_count := actual
		end

	--|--------------------------------------------------------------

	set_arg_type_error (expected, actual: STRING) is
		-- Set the error to be an arg type mismatch
		do
			set_error_code (K_printf_fmt_err_arg_type)
			expected_arg_type := expected
			actual_arg_type := actual
		end

	--|--------------------------------------------------------------

	set_unknown_type_error (tc: CHARACTER) is
		do
			set_error_code (K_printf_fmt_err_unknown_type)
			type_character := tc
		end

	--|--------------------------------------------------------------

	set_internal_error (s: STRING) is
		do
			set_error_code (K_printf_fmt_err_internal)
			internal_error_msg := s
		end

feature -- External representation

	description: STRING is
		-- Conscise description of error
		do
			Result := ""
			inspect error_code
			when K_printf_fmt_err_arg_count then
				if expected_arg_count > actual_arg_count then
					Result := "Missing arguments"
				else
					Result := "Too many arguments"
				end
			when K_printf_fmt_err_arg_type then
				Result := "Argument type mismatch"
			when K_printf_fmt_err_pad_char then
				Result := "Incompatible padding character"
			when K_printf_fmt_err_no_type then
				Result := "Missing type specifier"
			when K_printf_fmt_err_unknown_type then
				Result := "Unrecognized type specifier"
			when K_printf_fmt_err_internal then
				if attached internal_error_msg as ts then
					Result := ts
				else
					Result := "Internal error"
				end
			else
			end
		end

	--|--------------------------------------------------------------

	expected_value: STRING is
		do
			inspect error_code
			when K_printf_fmt_err_arg_count then
				Result := expected_arg_count.out
			when K_printf_fmt_err_arg_type then
				Result := expected_arg_type
			else
				Result := ""
			end
		ensure
			exists: Result /= Void
		end

	--|--------------------------------------------------------------

	actual_value: STRING is
		do
			inspect error_code
			when K_printf_fmt_err_arg_count then
				Result := actual_arg_count.out
			when K_printf_fmt_err_arg_type then
				Result := actual_arg_type
			when K_printf_fmt_err_unknown_type then
				Result := type_character.out
			else
				Result := ""
			end
		ensure
			exists: Result /= Void
		end

	--|--------------------------------------------------------------

	out: STRING is
		-- Context information in STRING form
		do
			create Result.make (32)
			Result.append ("Code: " + error_code.out + " " + description)
			Result.append ("%N   Position: " + position.out)
			Result.append ("%N   Format string: " + format_string)
		end

invariant
	format_string_exists: format_string /= Void
	valid_position: position > 0

end -- class AEL_PF_FORMAT_ERROR
