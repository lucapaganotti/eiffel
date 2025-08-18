indexing
	description: "Token within a format string"
	license: "Eiffel Forumn License v2 - See license.txt"
	source: "{
		Amalasoft Corporation
		273 Harwood Avenue
		Littleton, MA 01460 USA
		}"
	status: "Copyright 1995-2009, Amalasoft";
	date: "$Date: 2009/07/14 $";
	revision: "$Revision: 005$";

class AEL_PF_FORMAT_TOKEN

create
	make, make_from_string

--|========================================================================
feature {NONE} -- Creation
--|========================================================================

	make (p: INTEGER) is
		do
			create string_value.make (16)
			core_make (p)
		end

	make_from_string (v: STRING; p: INTEGER; tf: BOOLEAN) is
		do
			string_value := v
			core_make (p)
		end

	core_make (p: INTEGER) is
		do
			position := p
		end

 --|========================================================================
feature
 --|========================================================================

	string_value: STRING
			-- Whole original token string

	position: INTEGER
			-- Position in stream where token starts

	format: AEL_PF_FORMAT_PARAM

	is_format: BOOLEAN is
			-- Is the token a format specifier?
		do
			Result := format /= Void
		end

	is_empty: BOOLEAN is
		do
			Result := string_value.is_empty
		end

	has_format_error: BOOLEAN is
		do
			Result := is_format and then format.has_format_error
		end

--|========================================================================
feature -- Value setting
--|========================================================================

	set_format (v: like format) is
		do
			format := v
		end

	set_string_value (v: STRING) is
		do
			string_value := v
		end

	set_position (v: INTEGER) is
		do
			position := v
		end

	extend (v: CHARACTER) is
		do
			string_value.extend (v)
		end

end -- class AEL_PF_FORMAT_TOKEN
