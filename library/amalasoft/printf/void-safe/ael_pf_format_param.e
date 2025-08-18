note
	description: "Format string parsing and interpretation, argument coordination and output routines a single formatting error instance"
	license: "Eiffel Forumn License v2 - See license.txt"
	source: "{
		Amalasoft Corporation
		273 Harwood Avenue
		Littleton, MA 01460 USA
		}"
	status: "Copyright 1995-2009, Amalasoft";
	date: "$Date: 2009/07/14 $";
	revision: "$Revision: 005$"

class AEL_PF_FORMAT_PARAM

inherit
	AEL_PF_FORMATTING_CONSTANTS
	AEL_PF_FORMAT_ERROR_SUPPORT

create
	make_from_string

 --|========================================================================
feature {NONE} -- Creation and Initialization
 --|========================================================================

	make_from_string (v: STRING; spos: INTEGER) is
			-- Initialize this object from the given arguments
		require
			valid_position: (spos > 0) and (spos < v.count)
			long_enough: (v.count - spos) >= 1
			is_format: v.item(spos) = '%%'
		do
			core_make
			original_string := v
			original_position := spos
			extract_token
			-- init attachments
			argument := ""
		end

	--|--------------------------------------------------------------

	core_make is
		do
			create token.make (4)
		end

 --|========================================================================
feature {NONE} -- Parsing and initialization
 --|========================================================================

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
			--| Now get the type specifier
			extract_type_specifier (i)
			if is_typed and not has_format_error then
				if is_float then
					if not has_fractional_field_width then
						fractional_field_width := K_printf_dflt_fp_fractional_width
					end
					if not has_field_width then
						field_width := K_printf_dflt_fp_whole_width
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
			when 'd' then
				format_type := K_printf_fmt_type_decimal
			when 's' then
				format_type := K_printf_fmt_type_string
			when 'f' then
				format_type := K_printf_fmt_type_float
			when 'x' then
				format_type := K_printf_fmt_type_hex
			when 'u' then
				format_type := K_printf_fmt_type_unsigned
			when 'o' then
				format_type := K_printf_fmt_type_octal
			when 'c' then
				format_type := K_printf_fmt_type_character
			when 'b' then
				format_type := K_printf_fmt_type_binary
			when 'L' then
				format_type := K_printf_fmt_type_list
			when 'B' then
				format_type := K_printf_fmt_type_boolean
			else
				-- List format can accept a single optional separator 
				-- character here
				if pos < original_string.count
					and then original_string.item (pos+1) = 'L'
				 then
					 private_list_separator := type_specifier
					 type_specifier := original_string.item (pos+1)
					 token.extend (type_specifier)
					 format_type := K_printf_fmt_type_list
				else
					-- Bad type value, invalid format
--RFO					has_format_error := True
--RFO					add_unknown_type_error (original_string, pos, type_specifier)
				end
			end
		end

 --|========================================================================
feature {AEL_PF_FORMATTING_ROUTINES} -- Argument setting
 --|========================================================================

	set_argument (v: detachable ANY) is
			-- Associate the given argument with this format parameter
		do
			argument := v
			argument_defined := True
		ensure
			was_set: argument = v
			flag_set: argument_defined
		end

 --|========================================================================
feature {AEL_PF_FORMATTING_ROUTINES} -- Argument formatting
 --|========================================================================

	arg_out: STRING is
			-- Formatted representation of the associated argument
		local
			tstr: STRING
		do
			create Result.make (8)
			tstr := ""
			if argument_defined then
				if argument = Void then
					tstr := "Void"
					add_arg_type_error (original_string, original_position,
					expected_class_name, "Void")
				elseif is_string then
					tstr := string_arg_out
				elseif is_boolean then
					tstr := bool_arg_out
				elseif is_float then
					tstr := float_arg_out
				elseif is_character then
					tstr := char_arg_out
				elseif is_integer then
					tstr := int_arg_out
				elseif is_list then
					tstr := list_arg_out
				else
					check 
						untyped: not is_typed
					end
					if attached argument as ta then
						tstr := ta.out
					else
						tstr := "Void"
					end
				end
			end
			if has_arg_type_error then
				add_arg_type_error (original_string, original_position,
				expected_class_name, argument_class_name)
			end
			--| After formatting by type and decoration,
			--| align/justify the string within the field
			Result.append (aligned (tstr))
		end

 --|========================================================================
feature -- Context queries
 --|========================================================================

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

 --|========================================================================
feature {NONE} -- Private context queries
 --|========================================================================

	type_specifier: CHARACTER
			-- Character in format string denoting type

	argument: detachable ANY
			-- Argument associated with this format

	argument_defined: BOOLEAN
			-- Has the argument value been defined yet?

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

	list_separator: STRING is
			-- STRING used to separate list elements
		do
			if private_list_separator /= '%U' then
				Result := private_list_separator.out
			else
				if is_decorated then
					Result := ""
				else
					Result := dflt_printf_list_delimiter
				end
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
			Result := ""
			if is_decorated then
				if is_hex then
					Result := "0x"
				elseif is_octal then
					Result := "0"
				end
			end
		end

 --|========================================================================
feature {AEL_PF_FORMATTING_ROUTINES} -- Type queries
 --|========================================================================

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

	is_boolean: BOOLEAN is
			-- Does format expects a boolean argument?
		do
			Result := format_type = K_printf_fmt_type_boolean
		end

	is_binary: BOOLEAN is
			-- Does format expect an integer argument?
			-- Shows in binary format
		do
			Result := format_type = K_printf_fmt_type_binary
		end

	is_char: BOOLEAN is
			-- Does format expect a character argument?
		do
			Result := format_type = K_printf_fmt_type_character
		end

	is_decimal: BOOLEAN is
			-- Does format expect an integer argument?
			-- Shows in decimal format
		do
			Result := format_type = K_printf_fmt_type_decimal
		end

	is_float: BOOLEAN is
			-- Does format expect a floating point argument?
			-- (REAL OR DOUBLE)
		do
			Result := format_type = K_printf_fmt_type_float
		end

	is_octal: BOOLEAN is
			-- Does format expect an integer argument?
			-- Shows in octal format
		do
			Result := format_type = K_printf_fmt_type_octal
		end

	is_string: BOOLEAN is
			-- Does format expect a string argument?
		do
			Result := format_type = K_printf_fmt_type_string
		end

	is_unsigned: BOOLEAN is
			-- Does format expect an integer argument?
			-- Shows in unsigned decimal format
		do
			Result := format_type = K_printf_fmt_type_unsigned
		end

	is_hex: BOOLEAN is
			-- Does format expect an integer argument?
			-- Shows in hexadecimal format
		do
			Result := format_type = K_printf_fmt_type_hex
		end

	is_list: BOOLEAN is
			-- Does format expect a list or container argument?
			-- Shows in delimited format
		do
			Result := format_type = K_printf_fmt_type_list
		end

	--|--------------------------------------------------------------

	arg_matches_type (arg: detachable ANY): BOOLEAN is
		do
			if arg = Void then
				Result := True
			else
				if is_integer then
					Result :=
						attached {INTEGER_8_REF} arg or
						attached {INTEGER_16_REF} arg or
						attached {INTEGER_32_REF} arg or
						attached {INTEGER_64_REF} arg or
						attached {NATURAL_8_REF} arg or
						attached {NATURAL_16_REF} arg or
						attached {NATURAL_32_REF} arg or
						attached {NATURAL_64_REF} arg
				else
					inspect format_type
					when K_printf_fmt_type_float then
						Result :=
							attached {REAL_32_REF} arg or
							attached {REAL_64_REF} arg
					when K_printf_fmt_type_string then
						Result :=
							attached {STRING_8} arg or
							attached {STRING_32} arg
					when K_printf_fmt_type_character then
						Result :=
							attached {CHARACTER_8_REF} arg or
							attached {CHARACTER_32_REF} arg
					when K_printf_fmt_type_boolean then
						Result :=
							attached {BOOLEAN_REF} arg
					when K_printf_fmt_type_list then
						Result :=
							attached {FINITE [ANY]} arg or
							attached {TUPLE []} arg
					else
						-- False
					end
				end
			end
		end

--|========================================================================
feature {AEL_PF_FORMATTING_ROUTINES} -- Visible type queries
--|========================================================================

	is_typed: BOOLEAN is
			-- Was a valid type specifier found?
		do
			Result := format_type > 0
--RFO			Result := is_integer or is_string or is_float
--RFO				or is_boolean or is_character or is_list
		end

	--|--------------------------------------------------------------

	format_type: INTEGER
			-- Defined format type (if any, else 0)

	--|--------------------------------------------------------------

	minus_is_withheld: BOOLEAN
			-- Is the minus sign being withheld until
			-- after alignment for a negative decimal
			-- integer argument value?

 --|========================================================================
feature {NONE} -- Implementation
 --|========================================================================

	string_arg_out: STRING is
			-- Formatted string argument
		do					
			if attached {STRING} argument as tsa then
				Result := tsa
			else
				--| Argument doesn't match
				has_arg_type_error := True
				if attached argument as ta then
					Result := ta.out
				else
					Result := "Void"
				end
			end
		end

	--|--------------------------------------------------------------

	bool_arg_out: STRING is
			-- Formatted boolean argument
		do
			if attached {BOOLEAN_REF} argument as tba then
				if tba.item then
					Result := "True"
				else
					Result := "False"
				end
			else
				--| Argument doesn't match
				has_arg_type_error := True
				if attached argument as ta then
					Result := ta.out
				else
					Result := "Void"
				end
			end
		end

	--|--------------------------------------------------------------

	float_arg_out: STRING is
			-- Formatted floating point argument
		local
			tda: detachable REAL_64_REF
			tra: detachable REAL_32_REF
			tia: detachable INTEGER_REF
			parts: ARRAY [ INTEGER_64 ]
			whole_part, fract_part, factor: INTEGER_64
			whole_out: STRING
		do
			-- Set default value
			if attached argument as ta then
				Result := ta.out
			else
				Result := "Void"
			end
			if attached {REAL_64_REF} argument as ta then
				tda := ta
			else
				if attached {REAL_32_REF} argument as ta then
					tra := ta
					tda := tra.to_double
				else
					if not attached {INTEGER_REF} argument as ta then
						--| Argument doesn't match
						has_arg_type_error := True
					else
						tia := ta
						tda := tia.to_double
					end
				end
			end
			if not attached tda then
				--| Argument type mismatch
				has_arg_type_error := True
			else
				parts := printf_fmt_funcs.double_to_parts (tda, fractional_field_width)
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
					Result := printf_fmt_funcs.double_parts_out (whole_out, fract_part,
					factor,
					fractional_field_width)
				end
			end
		end

	--|--------------------------------------------------------------

	char_arg_out: STRING is
			-- Formatted character argument
		do
			if attached {CHARACTER_8_REF} argument as tca then
				Result := tca.out
			elseif attached {CHARACTER_32_REF} argument as tca then
				--RFO need MUCH better Ucode support than this!!!!!!!!!
				if tca.is_character_8 then
					Result := tca.to_character_8.out
				else
					Result := tca.out
				end
			else
				--| Argument doesn't match
				has_arg_type_error := True
				Result := ""
			end
		end

	--|--------------------------------------------------------------

	int_arg_out: STRING is
			-- Formatted integer argument
		local
			tia8: detachable INTEGER_8_REF
			tia16: detachable INTEGER_16_REF
			tia32: detachable INTEGER_32_REF
			tia64: detachable INTEGER_64_REF
			tian8: detachable NATURAL_8_REF
			tian16: detachable NATURAL_16_REF
			tian32: detachable NATURAL_32_REF
			tian64: detachable NATURAL_64_REF
			ti: INTEGER_64
			tn: NATURAL_64
			nb, i, j, lim: INTEGER
			ts, tout: STRING
		do
			create Result.make (8)
			if attached {INTEGER_8_REF} argument as ta then
				nb := 1
				tia8 := ta
				if is_unsigned then
					tian32 := tia8.as_natural_32
					tian64 := tian32.as_natural_64
				else
					tia64 := tia8.as_integer_64
				end
			elseif attached {INTEGER_16_REF} argument as ta then
				nb := 2
				tia16 := ta
				if is_unsigned then
					tian32 := tia16.as_natural_32
					tian64 := tian32.as_natural_64
				else
					tia64 := tia16.as_integer_64
				end
			elseif attached {INTEGER_32_REF} argument as ta then
				nb := 4
				tia32 := ta
				if is_unsigned then
					tian32 := tia32.as_natural_32
					tian64 := tian32.as_natural_64
				else
					tia64 := tia32.as_integer_64
				end
			elseif attached {INTEGER_64_REF} argument as ta then
				nb := 8
				tia64 := ta
				if is_unsigned then
					tian64 := tia64.as_natural_64
				end
			else
				if attached {NATURAL_8_REF} argument as ta then
					nb := 1
					tian8 := ta
					tian64 := tian8.as_natural_64
--					is_unsigned := True
					format_type := K_printf_fmt_type_unsigned
				elseif attached {NATURAL_16_REF} argument as ta then
					nb := 2
					tian16 := ta
					tian64 := tian16.as_natural_64
--					is_unsigned := True
					format_type := K_printf_fmt_type_unsigned
				elseif attached {NATURAL_32_REF} argument as ta then
					nb := 4
					tian32 := ta
					tian64 := tian32.as_natural_64
--					is_unsigned := True
					format_type := K_printf_fmt_type_unsigned
				elseif attached {NATURAL_64_REF} argument as ta then
					nb := 8
					tian64 := ta
--					is_unsigned := True
					format_type := K_printf_fmt_type_unsigned
				else
					has_arg_type_error := True
				end
			end
			if not has_arg_type_error then
				check
					unsigned_natural: is_unsigned implies attached tian64
				end
				if attached tia64 then
					ti := tia64
				end
				if attached tian64 then
					tn := tian64
				end
				if is_hex then
					Result := printf_fmt_funcs.integer_to_hex (ti, nb)
				elseif is_octal then
					Result := printf_fmt_funcs.integer_to_octal (ti, nb)
				elseif is_binary then
					Result := printf_fmt_funcs.integer_to_binary (ti)
					if is_decorated then
						Result.extend ('b')
					end
					if field_width < Result.count then
						prune_leading_zeroes (Result, field_width)
					end
				elseif is_unsigned then
					Result := printf_fmt_funcs.natural_out (tn, nb)
				else -- Decimal
					tout := ti.out
					if not is_decorated then
						ts := tout
					else
						create ts.make (tout.count + tout.count // 3)
						lim := tout.count
						from i := lim
						until i <= 0
						loop
							from j := 1
							until j > 3 or i <= 0
							loop
								ts.extend (tout.item (i))
								i := i - 1
								j := j + 1
							end
							if i > 0 then
								ts.extend (',')
							end
						end
						ts.mirror
					end
					if ((ti < ti.zero) and
						is_zero_padded (field_width, ts.count)) then
							minus_is_withheld := True
							Result := (-ti).out
					else
						Result := ts
					end
				end
			end
		end

	--|--------------------------------------------------------------

	list_arg_out: STRING is
			-- Formatted container argument
		local
			tla: LINEAR [detachable ANY]
			sep: STRING
		do
			Result := ""
			sep := list_separator
			if not attached {CONTAINER [detachable ANY]} argument as tca then
				--| Argument doesn't match
				has_arg_type_error := True
				if attached argument as t then
					Result := t.out
				else
					Result := "Void"
				end
			else
				tla := tca.linear_representation
				from tla.start
				until tla.exhausted
				loop
					if attached tla.item as ta then
						Result.append (ta.out)
					else
						Result.append ("Void")
					end
					tla.forth
					if not tla.exhausted then
						Result.append (sep)
					end
				end
			end
		ensure
			exists: Result /= Void
		end

	--|--------------------------------------------------------------

	aligned (tstr: STRING): STRING is
			-- Copy of given string aligned into field width
			-- per current parameters
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
			big_enough: Result.count >= field_width
		end

	--|--------------------------------------------------------------

	prune_leading_zeroes (ts: STRING; fw: INTEGER) is
			-- Prune leading zeroes in 'ts', to no less than length fw
		local
			i, lim, nz: INTEGER
		do
			lim := ts.count - fw
			from i := 1
			until i > lim
			loop
				if ts.item (i) = '0' then
					nz := nz + 1
					i := i + 1
				else
					i := lim + 1
				end
			end
			ts.keep_tail (ts.count - nz)
		end

	--|--------------------------------------------------------------

	private_pad_character: CHARACTER
			-- Padding character to use instead of default

	private_list_separator: CHARACTER
			-- Separator character to use instead of default

 --|========================================================================
feature {AEL_PF_FORMATTING_ROUTINES} -- Type representation
 --|========================================================================

	argument_class_name: STRING is
			-- The name of the class to which argument belongs
		do
			if argument_defined then
				if attached argument as ta then
					Result := (create {INTERNAL}).class_name (ta)
				else
					Result := "** Argument is Void **"
				end
			else
				Result := "** Not Yet Defined **"
			end
		ensure
			exists: not Result.is_empty
		end

	--|--------------------------------------------------------------

	expected_class_name: STRING is
			-- The name of the class expected by the type parameter
		local
			tc: CHARACTER
			ts: STRING
			ti: INTEGER
		do
			if is_character then
--				Result := "CHARACTER"
				Result := (create {INTERNAL}).class_name (tc)
			elseif is_boolean then
				Result := "BOOLEAN"
			elseif is_integer then
--				Result := "INTEGER"
				Result := (create {INTERNAL}).class_name (ti)
			elseif is_float then
				Result := "DOUBLE/REAL"
			elseif is_string then
--				Result := "STRING"
				ts := ""
				Result := (create {INTERNAL}).class_name (ts)
			else
				Result := "** Undefined **"
			end
		ensure
			exists: not Result.is_empty
		end

invariant
	position_is_valid: original_position > 0 and
	original_position <= original_string.count

end -- class AEL_PF_FORMAT_PARAM
