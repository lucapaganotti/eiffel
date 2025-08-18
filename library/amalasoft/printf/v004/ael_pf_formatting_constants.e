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

feature {NONE} -- Constants

	Hex_digits: STRING is "0123456789abcdef"
	Octal_digits: STRING is "01234567"

	K_dflt_fp_fractional_width: INTEGER is 6
	K_dflt_fp_whole_width: INTEGER is 1

	Ks_missing_arg_stub: STRING is
		once
			Result := "Void"
		end

feature {NONE} -- Error codes

	K_fmt_err_arg_count: INTEGER is 1
	K_fmt_err_arg_type: INTEGER is 2

	K_fmt_err_no_type: INTEGER is 11
	K_fmt_err_unknown_type: INTEGER is 12

	K_fmt_err_pad_char: INTEGER is 21

	K_fmt_err_field_width: INTEGER is 31

feature {NONE} -- Shared routines

	fmt_funcs: AEL_PF_FORMATTING_ROUTINES is
		once
			create Result
		end

	last_printf_errors: LINKED_LIST [ AEL_PF_FORMAT_ERROR ] is
		-- List of errors from most recent operation
		once
			create Result.make
		end

feature {NONE} -- Validation

	is_valid_first_fmt_char (c: CHARACTER): BOOLEAN is
		do
			inspect c
			when '#', '-', '+', '=' then
				--| Decoration and alignment flags
				Result := True
			when 'b', 'B', 'c', 'd', 'f', 'o', 's', 'u', 'x' then
				--| Type flags
				Result := True
			else
				--| Field width
				Result := c.is_digit
			end
		end

feature {NONE} -- Alternate fill support

	default_fill_char: CHARACTER is
			-- Usually blank unless numeric and zero,
			-- can be changed to any valid character
		do
			Result := dflt_fillchar_ref.item
		end

	set_default_fill_char (v: CHARACTER) is
			-- Change the fill character from blank to 
			-- the given new value for ALL subsequent 
			-- printf calls in this process space
		do
			dflt_fillchar_ref.set_item (v)
		end

	reset_default_fill_char is
			-- Reset the default fill character to blank
		do
			dflt_fillchar_ref.set_item (' ')
		end

	dflt_fillchar_ref: CHARACTER_REF is
			-- Usually blank unless numeric and zero,
			-- can be changed to any valid character
		once
			create Result
			Result.set_item (' ')
		end

end -- class AEL_PF_FORMATTING_CONSTANTS
