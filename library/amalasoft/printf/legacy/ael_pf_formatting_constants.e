indexing
	description: "Constants used by the other members of the cluster. %
	%Also offers is_valid_first_fmt_char() to its descendents. %
	%Holds the shared error list (last_printf_errors) and provides %
        %a shared instanace of AEL_PF_FORMATTING_ROUTINES for descendents."
	license: "Eiffel Forumn License v2 - See license.txt"
	source: "{
		Amalasoft Corporation
		273 Harwood Avenue
		Littleton, MA 01460 USA
		}"
	status: "Copyright 1995-2008, Amalasoft";
	date: "$Date: 2008/04/21 $";
	revision: "$Revision: 003$";

class AEL_PF_FORMATTING_CONSTANTS

 --|========================================================================
feature {NONE} -- Constants
 --|========================================================================

	Printf_hex_digits: STRING is "0123456789abcdef"
	Printf_octal_digits: STRING is "01234567"

	K_printf_dflt_fp_fractional_width: INTEGER is 6
	K_printf_dflt_fp_whole_width: INTEGER is 1

	Ks_printf_missing_arg_stub: STRING is
		once
			Result := "Void"
		end

	Ks_printf_mismatch_type_stub: STRING is
		once
			Result := "** Arg Type Mismatch **"
		end

	Ks_printf_type_specifiers: STRING is "dsfxuocBLb"
			-- String containing all legal format characters,
			-- sorted in expected order of frequency of use

 --|========================================================================
feature {NONE} -- Format type codes
 --|========================================================================

	-- N.B. these correspond to char positions in Ks_printf_type_specifiers
	-- Keep them in synch

	K_printf_fmt_type_decimal: INTEGER is 1
	K_printf_fmt_type_string: INTEGER is 2
	K_printf_fmt_type_float: INTEGER is 3
	K_printf_fmt_type_hex: INTEGER is 4
	K_printf_fmt_type_unsigned: INTEGER is 5
	K_printf_fmt_type_octal: INTEGER is 6
	K_printf_fmt_type_character: INTEGER is 7
	K_printf_fmt_type_binary: INTEGER is 8
	K_printf_fmt_type_list: INTEGER is 9
	K_printf_fmt_type_boolean: INTEGER is 10

 --|========================================================================
feature {NONE} -- Error codes
 --|========================================================================

	K_printf_fmt_err_arg_count: INTEGER is 1
	K_printf_fmt_err_arg_type: INTEGER is 2

	K_printf_fmt_err_no_type: INTEGER is 11
	K_printf_fmt_err_unknown_type: INTEGER is 12

	K_printf_fmt_err_pad_char: INTEGER is 21

	K_printf_fmt_err_field_width: INTEGER is 31

	K_printf_fmt_err_internal: INTEGER is 99

 --|========================================================================
feature {NONE} -- Shared routines
 --|========================================================================

	printf_fmt_funcs: AEL_PF_FORMATTING_ROUTINES is
		once
			create Result
		end

	last_printf_errors: LINKED_LIST [ AEL_PF_FORMAT_ERROR ] is
		-- List of errors from most recent operation
		once
			create Result.make
		end

 --|========================================================================
feature {NONE} -- Validation
 --|========================================================================

	is_valid_printf_first_fmt_char (c: CHARACTER): BOOLEAN is
		do
			inspect c
			when '#', '-', '+', '=' then
				--| Decoration and alignment flags
				Result := True
			else
				if is_valid_printf_type_specifier (c) then
					Result := True
				else
					--| Field width
					Result := c.is_digit
				end
			end
		end

	--|--------------------------------------------------------------

	is_valid_printf_type_specifier (c: CHARACTER): BOOLEAN is
		do
			Result := Ks_printf_type_specifiers.has (c)
		end

 --|========================================================================
feature {NONE} -- Alternate fill support
 --|========================================================================

	default_printf_fill_char: CHARACTER is
			-- Usually blank unless numeric and zero,
			-- can be changed to any valid character
		do
			Result := dflt_printf_fillchar_ref.item
		end

	set_default_printf_fill_char (v: CHARACTER) is
			-- Change the fill character from blank to 
			-- the given new value for ALL subsequent 
			-- printf calls in this process space
		do
			dflt_printf_fillchar_ref.put (v)
		end

	reset_default_printf_fill_char is
			-- Reset the default fill character to blank
		do
			dflt_printf_fillchar_ref.put (' ')
		end

	--|--------------------------------------------------------------

	set_default_printf_list_delimiter (v: STRING) is
			-- Change the default list delimiter string from a single
			-- blank character to the given string for ALL subsequent 
			-- printf calls in this process space
		do
			dflt_printf_list_delimiter.clear_all
			dflt_printf_list_delimiter.append (v)
		end

	reset_default_printf_list_delimiter is
			-- Reset the default list delimiter string
		do
			dflt_printf_list_delimiter.clear_all
			dflt_printf_list_delimiter.extend (' ')
		end

	--|--------------------------------------------------------------

	dflt_printf_fillchar_ref: CELL [CHARACTER] is
			-- Usually blank unless numeric and zero,
			-- can be changed to any valid character
		once
			create Result.put (' ')
		end

	dflt_printf_list_delimiter: STRING is
		-- Delimiter to use when representing List formats
		once
			create Result.make (1)
			Result.extend (' ')
		end

 --|========================================================================
feature -- Help
 --|========================================================================

	printf_help_message: STRING is
		do
			create Result.make (2000)
			Result.append ("{
 The various string formatting routines provide a means
 by which to format strings for output or other purposes
 in a manner reminiscent of the traditional printf functions 
 in C and similar languages.

  Format string construction (in order):

    %
    [<decoration_flag>]
    [<alignment_flag>]
    [<fill_specifier>]
    [<field_width>]
    <field_type>

  Where:

    <decoration_flag> ::=  '#'
      Decoration consumes part of the field width
      Decoration is applies as follows:
        "0x" preceding hexadecimal values
        "0" preceding octal values
        "b" following binary values
        Decimal values show commas at thousands

    <alignment_flag> ::=  '-' |   '+'  |  '='
                         (left   right  centered)

    <fill_specifier> ::=  <character>
      Fills remainder of field width
      with given character (default is blank)

    <field_width> ::=  <simple_width> | <complex_width>

    <field_type> ::=  <character>

      Field type can be at least on of the following:
        'B' denotes a BOOLEAN expression
            This shows as "True" or "False"
        'b' denotes a BINARY INTEGER expression
            This shows as ones and zeroes
        'c' denotes a single CHARACTER
        'd' denotes a DECIMAL INTEGER expression
        'f' denotes a REAL or DOUBLE expression
            Field width for floating point values
            are given in the form:
             <overall_width>"."<right_width>
             Where overall_width is the minimum
             width of the entire representation,
             and <right_width> is the width for
             the fractional part (a.k.a. precision)
             A precision of 0 results in a whole number
             representation, without decimal point
             (effectively rounded to integer)
        'o' denotes an OCTAL INTEGER expression
        's' denotes character STRING
        'u' denotes an UNSIGNED DECIMAL INTEGER expression
        'x' denotes a HEXADECIMAL INTEGER expression
        
 In use, a class calls one of the printf routines with at least
 a format string and an argument list.

 The argument list is any proper descendent of FINITE, and is most often
 a manifest ARRAY or a LINKED_LIST.  It can also be Void if there are no
 arguments.
 The argument list contains the arguments that align (positionally) with
 the format specifiers in the format string.

 Clients wishing access to the printf functions should inherit
 the AEL_PRINTF class.  It is also possible to instantiate the
 AEL_PF_FORMATTING_ROUTINES class for use as a supplier.
	}")
   end

end -- class AEL_PF_FORMATTING_CONSTANTS
