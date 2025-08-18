indexing
	description: "Format string parsing and interpretation, argument coordination and output routines a single formatting error instance"
	license: "Eiffel Forumn License v2 - See license.txt"
	source: "{
		Amalasoft Corporation
		273 Harwood Avenue
		Littleton, MA 01460 USA
		}"
	status: "Copyright 1995-2008, Amalasoft";
	date: "$Date: 2008/12/03 $";
	revision: "$Revision: 004$";

class AEL_PF_FORMAT_PARAM

inherit
	AEL_PF_FORMATTING_CONSTANTS
	AEL_PF_FORMAT_ERROR_SUPPORT

create
	make_from_string

feature {NONE} -- Creation and Initialization

	make_from_string (v: STRING; spos: INTEGER) is
			-- Initialize this object from the given arguments
		require
			exists: v /= Void
			valid_position: (spos > 0) and (spos < v.count)
			long_enough: (v.count - spos) >= 1
			is_format: v.item(spos) = '%%'
		do
			core_make
			original_string := v
			original_position := spos
			extract_token
		end

	--|--------------------------------------------------------------

	core_make is
		do
			create token.make (4)
		end

feature {NONE} -- Parsing and initialization

	extract_token is
			-- Extract the actual format parameter from the 
			-- original format string,
			-- beginning at the given position
		local
			i, lim: INTEGER
			iref: INTEGER_REF
		do
			lim := original_string.count

			i := original_position
			--| The character at spos is, per contract,
			--| the leading percent sign
			token.extend (original_string.item (i))
			i := i + 1
			if original_string.item (i) = '#' then --| Decoration tag
				token.extend (original_string.item (i))
				i := i + 1
			end
			inspect original_string.item (i)
			when '-', '=', '+' then
				token.extend (original_string.item (i))
				set_alignment (original_string.item (i))
				i := i + 1
			else
			end
			if original_string.item (i).is_digit then --| Field width
				create iref
				iref.set_item (i)
				extract_field_width (iref)
				i := iref.item
			end
			--| Now get the type tag
			--| It must be a single character
			extract_type_specifier (i)
			if not has_format_error then
				if is_float then
					if not has_fractional_field_width then
						fractional_field_width := K_dflt_fp_fractional_width
					end
					if not has_field_width then
						field_width := K_dflt_fp_whole_width
					end
				end
			end
		ensure
			string_unchanged: original_string.is_equal(old original_string)
		end

	--|--------------------------------------------------------------

	set_alignment (v: CHARACTER) is
		do
			inspect v
			when '-' then
				is_left_aligned := True
			when '=' then
				is_center_aligned := True
			when '+' then
				is_right_aligned := True
			end
		end

	--|--------------------------------------------------------------

	extract_field_width (iref: INTEGER_REF) is
			-- From the given string, beginning at the position
			-- indicated by iref, extract the overall and,
			-- for floating point values, fractional field widths
		require
			position_exists: iref /= Void
			position_large_enough: iref.item > 0
			position_small_enough: iref.item <= original_string.count
			first_char_is_digit: original_string.item (iref.item).is_digit
		local
			i, lim: INTEGER
		do
			lim := original_string.count
			i := iref.item
			if original_string.item(i) = '0' then
				private_pad_character := '0'
			end
			from
			until (i > lim) or not original_string.item (i).is_digit
			loop
				has_field_width := True
				token.extend (original_string.item (i))
				field_width := (field_width * 10) + original_string.item (i).out.to_integer
				i := i + 1
			end
			if original_string.item (i) = '.' then --| Floating point
				token.extend (original_string.item (i))
				from i := i + 1
				until i > lim or not original_string.item (i).is_digit
				loop
					has_fractional_field_width := True
					token.extend (original_string.item (i))
					fractional_field_width := (fractional_field_width * 10)
					+ original_string.item (i).out.to_integer
					i := i + 1
				end
			end
			iref.set_item (i)
		ensure
			field_flag_set:	has_field_width = True
			no_flag_no_frac: (not has_fractional_field_width)
				implies fractional_field_width = 0
		end

	--|--------------------------------------------------------------

	extract_type_specifier (pos: INTEGER) is
		require
			valid_position: pos > 0 and pos <= original_string.count
		do
			type_specifier := original_string.item (pos)
			token.extend (type_specifier)

			inspect type_specifier
			when 'B' then
				is_boolean := True
			when 'b' then
				is_binary := True
			when 'c' then
				is_char := True
			when 'd' then
				is_decimal := True
			when 'f' then
				is_float := True
			when 'o' then
				is_octal := True
			when 's' then
				is_string := True
			when 'u' then
				is_unsigned := True
			when 'x' then
				is_hex := True
			else
				-- Bad type value, invalid format
				has_format_error := True
				add_unknown_type_error (original_string, pos, type_specifier)
			end
		end

feature {AEL_PF_FORMATTING_ROUTINES} -- Argument setting

	set_argument (v: ANY) is
			-- Associate the given argument with this format parameter
		require
			exists: v /= Void
		do
			argument := v
		ensure
			was_set: argument = v
		end

feature {AEL_PF_FORMATTING_ROUTINES} -- Argument formatting

	arg_out: STRING is
			-- Formatted representation of the associated argument
		local
			tstr: STRING
		do
			create Result.make (8)
			if argument /= Void then
				if is_string then
					tstr := string_arg_out
				elseif is_boolean then
					tstr := bool_arg_out
				elseif is_float then
					tstr := float_arg_out
				elseif is_character then
					tstr := char_arg_out
				elseif is_integer then
					tstr := int_arg_out
				else
					check 
						untyped: not is_typed
					end
					tstr := argument.out
				end
			end
			if has_arg_type_error then
				add_arg_type_error (original_string, original_position,
				expected_class_name, argument_class_name)
			end
			--| After formatting by type and decoration,
			--| align/justify the string within the field
			Result.append (aligned (tstr))
		ensure
			exists:	Result /= Void
		end

feature -- Context queries

	original_length: INTEGER is
			-- Length of original token
		do
			Result := token.count
		ensure
			non_negative: Result >= 0
		end

	--|--------------------------------------------------------------

	original_string: STRING
			-- Reference to the whole original format string given

	original_position: INTEGER
			-- Original starting position in the format string

	token: STRING
			-- Original format token, captured from input
	
	has_format_error: BOOLEAN
			-- Has a format error been encountered?

	has_arg_type_error: BOOLEAN
			-- Has an argument type mismatch been encountered?

feature {NONE} -- Private context queries

	type_specifier: CHARACTER
			-- Character in format string denoting type

	argument: ANY
			-- Argument associated with this format

	--|--------------------------------------------------------------

	is_decorated: BOOLEAN is
			-- Was a decoration specifier found?
		do
			Result := (token.count > 1) and then (token.item (2) = '#')
		end

	--|--------------------------------------------------------------

	is_aligned: BOOLEAN is
			-- Does the format call for special aligment?
			-- By default, all formats are left-aligned
		do
			Result := is_right_aligned or is_center_aligned
		end

	--|--------------------------------------------------------------

	is_left_aligned: BOOLEAN
			-- Should formatted arg begin at left edge of field?

	is_right_aligned: BOOLEAN
			-- Should formatted arg end at right edge of field?

	is_center_aligned: BOOLEAN
			-- Should formatted arg be centered in field?

	--|--------------------------------------------------------------

	is_zero_padded (fw, aw: INTEGER): BOOLEAN is
			-- Does the format result in leading zero padding?
		do
			Result := (is_right_aligned or is_center_aligned or not is_aligned)
				and (fw > aw) and (pad_character = '0')
		end

	--|--------------------------------------------------------------

	pad_character: CHARACTER is
			-- Character used to align and justify in field
		do
			if (is_float or (is_integer and not is_binary)) then
				Result := private_pad_character
			end
			if Result = '%U' then
				Result := ' '
			end
		end

	--|--------------------------------------------------------------

	has_field_width: BOOLEAN
	has_fractional_field_width: BOOLEAN

	field_width: INTEGER
			-- Overall field width for non-floating point values
			-- For floating point values, the whole part field width

	fractional_field_width: INTEGER
			-- For floating point values, the width of the
			-- fractional part (right of decimal point)

	--|--------------------------------------------------------------

	decoration: STRING is
			-- String to apply as context-specific decoration
		do
			if is_decorated then
				if is_hex then
					Result := "0x"
				elseif is_octal then
					Result := "0"
				end
			end
			if Result = Void then
				Result := ""
			end
		ensure
			exists: Result /= Void
		end

feature {NONE} -- Private type queries

	is_typed: BOOLEAN is
			-- Was a valid type specifier found?
		do
			Result := is_integer or is_string or is_float
				or is_boolean or is_character
		end

	--|--------------------------------------------------------------

	is_character: BOOLEAN is
			-- Does format expect a character argument?
		do
			Result := is_char
		end

	--|--------------------------------------------------------------

	is_integer: BOOLEAN is
			-- Does format expect an integer argument?
		do
			Result := is_decimal or is_hex or is_octal or is_binary or is_unsigned
		end

	--|--------------------------------------------------------------

	is_boolean: BOOLEAN
			-- Does format expects a boolean argument?

	is_binary: BOOLEAN
			-- Does format expect an integer argument?
			-- Shows in binary format

	is_char: BOOLEAN
			-- Does format expect a character argument?

	is_decimal: BOOLEAN
			-- Does format expect an integer argument?
			-- Shows in decimal format

	is_float: BOOLEAN
			-- Does format expect a floating point argument?
			-- (REAL OR DOUBLE)

	is_octal: BOOLEAN
			-- Does format expect an integer argument?
			-- Shows in octal format

	is_string: BOOLEAN
			-- Does format expect a string argument?

	is_unsigned: BOOLEAN
			-- Does format expect an integer argument?
			-- Shows in unsigned decimal format

	is_hex: BOOLEAN
			-- Does format expect an integer argument?
			-- Shows in hexadecimal format

	minus_is_withheld: BOOLEAN
			-- Is the minus sign being withheld until
			-- after alignment for a negative decimal
			-- integer argument value?

feature {NONE} -- Implementation

	string_arg_out: STRING is
			-- Formatted string argument
		local
			tsa: STRING
		do					
			tsa ?= argument
			if tsa = Void then --| Argument doesn't match
				has_arg_type_error := True
				Result := argument.out
			else
				Result := tsa
			end
		ensure
			exists: Result /= Void
		end

	--|--------------------------------------------------------------

	bool_arg_out: STRING is
			-- Formatted boolean argument
		local
			tba: BOOLEAN_REF
		do
			tba ?= argument
			if tba = Void then --| Argument doesn't match
				has_arg_type_error := True
				Result := argument.out
			else
				if tba.item then
					Result := "True"
				else
					Result := "False"
				end
			end
		ensure
			exists: Result /= Void
		end

	--|--------------------------------------------------------------

	float_arg_out: STRING is
			-- Formatted floating point argument
		local
			tda: DOUBLE_REF
			tra: REAL_REF
			tia: INTEGER_REF
			parts: ARRAY [ INTEGER_64 ]
			whole_part, fract_part, factor: INTEGER_64
			whole_out: STRING
		do
			tda ?= argument
			if tda = Void then
				tra ?= argument
				if tra = Void then
					tia ?= argument
					if tia = Void then --| Argument doesn't match
						has_arg_type_error := True
						Result := argument.out
					else
						tda := tia.to_double
					end
				else
					tda := tra.to_double
				end
			end
			if tda = Void then --| Argument type mismatch
				has_arg_type_error := True
				Result := argument.out
			else
				parts := fmt_funcs.double_to_parts (tda, fractional_field_width)
				whole_part := parts.item (1)
				fract_part := parts.item (2)
				factor := parts.item (3)
				whole_out := whole_part.out
				if (whole_part < whole_part.zero and
					is_zero_padded (field_width, whole_out.count))
				 then
					 minus_is_withheld := True
					 whole_out := (-whole_part).out
				end
				if fractional_field_width = 0 then
					Result := whole_out
				else
					Result := fmt_funcs.double_parts_out (whole_out, fract_part,
					factor,
					fractional_field_width)
				end
			end
		ensure
			exists: Result /= Void
		end

	--|--------------------------------------------------------------

	char_arg_out: STRING is
			-- Formatted character argument
		local
			tca: CHARACTER_REF
		do
			tca ?= argument
			if tca = Void then --| Argument doesn't match
				has_arg_type_error := True
			else
				Result := tca.out
			end
		ensure
			exists: Result /= Void
		end

	--|--------------------------------------------------------------

	int_arg_out: STRING is
			-- Formatted integer argument
		local
			tia: INTEGER_REF
			tia8: INTEGER_8_REF
			tia16: INTEGER_16_REF
			tia64: INTEGER_64_REF
			tian8: NATURAL_8_REF
			tian16: NATURAL_16_REF
			tian32: NATURAL_32_REF
			tian64: NATURAL_64_REF
			ts: STRING
		do
			create Result.make (8)
			tia8?= argument
			tia16?= argument
			tia64?= argument
			tia ?= argument
			if tia8 /= Void then
				if is_unsigned then
					tian32 := tia8.as_natural_32
					tian64 := tian32.as_natural_64
				else
					tia64 := tia8.as_integer_64
				end
			elseif tia16 /= Void then
				if is_unsigned then
					tian32 := tia16.as_natural_32
					tian64 := tian32.as_natural_64
				else
					tia64 := tia16.as_integer_64
				end
			elseif tia /= Void then
				if is_unsigned then
					tian32 := tia.as_natural_32
					tian64 := tian32.as_natural_64
				else
					tia64 := tia.as_integer_64
				end
			elseif tia64 /= Void then
				if is_unsigned then
					tian64 := tia64.as_natural_64
				end
			else
				tian8 ?= argument
				tian16 ?= argument
				tian32 ?= argument
				tian64 ?= argument
				if tian8 /= Void then
					tian64 := tian8.as_natural_64
					is_unsigned := True
				elseif tian16 /= Void then
					tian64 := tian16.as_natural_64
					is_unsigned := True
				elseif tian32 /= Void then
					tian64 := tian32.as_natural_64
					is_unsigned := True
				elseif tian64 /= Void then
					is_unsigned := True
				else
					has_arg_type_error := True
				end
			end
			if not has_arg_type_error then
				check
					unsigned_natural: is_unsigned implies tian64 /= Void
				end
				if is_hex then
					Result := fmt_funcs.integer_to_hex (tia64)
				elseif is_octal then
					Result := fmt_funcs.integer_to_octal (tia64)
				elseif is_binary then
					Result := fmt_funcs.integer_to_binary (tia64)
				elseif is_unsigned then
					Result := tian64.out
				else -- Decimal
					ts := tia64.out
					if ((tia64 < tia64.zero) and
						is_zero_padded (field_width, ts.count)) then
							minus_is_withheld := True
							Result := (-tia64).out
					else
						Result := ts
					end
				end
			end
		ensure
			exists:	Result /= Void
		end

	--|--------------------------------------------------------------

	aligned (tstr: STRING): STRING is
			-- Copy of given string aligned into field width
			-- per current parameters
		require
			str_exists: tstr /= Void
		local
			pad_len, minus_pad_len: INTEGER
			pre_str, post_str: STRING
		do
			create Result.make (field_width.max (tstr.count))
			pre_str := ""
			post_str := ""
			if tstr.count < field_width then
				if minus_is_withheld then
					minus_pad_len := 1
				end
				pad_len := (field_width - tstr.count 
				- minus_pad_len - decoration.count).max (0)
				if is_center_aligned then
					create pre_str.make_filled (pad_character, pad_len // 2)
					create post_str.make_filled (' ', pad_len - pre_str.count)
				else
					if is_left_aligned then
						create post_str.make_filled (' ', pad_len)
					else
						create pre_str.make_filled (pad_character, pad_len)
					end
				end
			end
			if minus_is_withheld then
				Result.extend ('-')
			end
			if is_zero_padded (field_width, tstr.count) then
				Result.append (decoration)
			end
			Result.append (pre_str)
			if not is_zero_padded (field_width, tstr.count) then
				Result.append (decoration)
			end
			Result.append (tstr)
			Result.append (post_str)
		ensure
			exists: Result /= Void
			big_enough: Result.count >= field_width
		end

	--|--------------------------------------------------------------

	private_pad_character: CHARACTER
			-- Padding character to use instead of default

feature {NONE} -- Type representation

	argument_class_name: STRING is
			-- The name of the class to which argument belongs
		do
			if argument /= Void then
				Result := (create {INTERNAL}).class_name (argument)
			else
				Result := "** Not Yet Defined **"
			end
		ensure
			exists: Result /= Void and then not Result.is_empty
		end

	--|--------------------------------------------------------------

	expected_class_name: STRING is
			-- The name of the class expected by the type parameter
		do
			if is_character then
				Result := "CHARACTER"
			elseif is_boolean then
				Result := "BOOLEAN"
			elseif is_integer then
				Result := "INTEGER"
			elseif is_float then
				Result := "DOUBLE/REAL"
			elseif is_string then
				Result := "STRING"
			else
				Result := "** Undefined **"
			end
		ensure
			exists: Result /= Void and then not Result.is_empty
		end

invariant
	format_string_exists: original_string /= Void
	position_is_valid: original_position > 0 and
	original_position <= original_string.count
	token_exists: token /= Void

end -- class AEL_PF_FORMAT_PARAM
