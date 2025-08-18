note
	description: "A class containing routines to interface with the shared error list"
	license: "Eiffel Forumn License v2 - See license.txt"
	source: "{
		Amalasoft Corporation
		273 Harwood Avenue
		Littleton, MA 01460 USA
		}"
	status: "Copyright 1995-2008, Amalasoft";
	date: "$Date: 2008/04/21 $";
	revision: "$Revision: 003$"

class AEL_PF_FORMAT_ERROR_SUPPORT

inherit
	AEL_PF_FORMATTING_CONSTANTS

feature -- Error setting

	add_arg_count_error (fmt: STRING; pos: INTEGER;
	num_params, num_args: INTEGER) is
			-- Create a new format error with the given
			-- values and add it to the last_errors list
		require
			format_exists: fmt /= Void
			valid_position: pos > 0 and pos <= fmt.count
			valid_counts: num_params >= 0 and num_args >= 0
		do
			add_error (fmt, pos)
			last_printf_errors.last.set_arg_count_error (num_params, num_args)
		end

	--|--------------------------------------------------------------

	add_unknown_type_error (fmt: STRING; pos: INTEGER; tc: CHARACTER) is
			-- Create a new format error with the given
			-- values and add it to the last_printf_errors list
		require
			format_exists: fmt /= Void
			valid_position: pos > 0 and pos <= fmt.count
		do
			add_error (fmt, pos)
			last_printf_errors.last.set_unknown_type_error (tc)
		end

	--|--------------------------------------------------------------

	add_arg_type_error (fmt: STRING; pos: INTEGER; exp, act: STRING) is
			-- Create a new format error with the given
			-- values and add it to the last_printf_errors list
		require
			format_exists: fmt /= Void
			valid_position: pos > 0 and pos <= fmt.count
			expected_exists: exp /= Void
			actual_exists: act /= Void
		do
			add_error (fmt, pos)
			last_printf_errors.last.set_arg_type_error (exp, act)
		end

	--|--------------------------------------------------------------

	add_internal_error (fmt: STRING; pos: INTEGER; msg: STRING) is
			-- Create a new format internal error with the given
			-- values and add it to the last_printf_errors list
		require
			format_exists: fmt /= Void
			valid_position: pos > 0 and pos <= fmt.count
		do
			add_error (fmt, pos)
			if attached msg then
				last_printf_errors.last.set_internal_error (msg)
			end
		end

feature {NONE} -- Implementation

	add_error (fmt: STRING; pos: INTEGER) is
			-- Create a new format error with the given
			-- values and add it to the last_printf_errors list
		require
			format_exists: fmt /= Void
			valid_position: pos > 0 and pos <= fmt.count
		do
			last_printf_errors.extend (create {AEL_PF_FORMAT_ERROR}.make(fmt,pos))
		ensure
			added: last_printf_errors.count = old last_printf_errors.count + 1
		end

end -- class AEL_PF_FORMAT_ERROR_SUPPORT
