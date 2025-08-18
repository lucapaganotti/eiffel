indexing
	description: "Primary interface into the ael_printf cluster"
	license: "Eiffel Forumn License v2 - See license.txt"
	source: "{
		Amalasoft Corporation
		273 Harwood Avenue
		Littleton, MA 01460 USA
		}"
	status: "Copyright 1995-2008, Amalasoft";
	date: "$Date: 2008/04/21 $";
	revision: "$Revision: 003$";

class AEL_PRINTF

inherit
	AEL_PF_FORMATTING_CONSTANTS

feature -- Formatting

	aprintf (fmt: STRING; args: FINITE [ANY]): STRING is
			-- A new string object formatted according to
			-- the given format 'fmt' and arguments 'args'
		require
			format_string_exists: fmt /= Void
		do
			create Result.make (128)
			Result.append (fmt_funcs.pf_formatted (fmt, args))
		ensure
			exists: Result /= Void
		end

	--|--------------------------------------------------------------

	fprintf (f: FILE; fmt: STRING; args: FINITE [ANY]) is
			-- Write to the end of given open FILE a string formatted
			-- according to the given format 'fmt' and arguments 'args'
		require
			exists: f /= Void
			file_exists: f.exists
			file_is_open: f.is_open_write or f.is_open_append
			format_string_exists: fmt /= Void
		do
			f.put_string (fmt_funcs.pf_formatted (fmt, args))
		end

	--|--------------------------------------------------------------

	printf (fmt: STRING; args: FINITE [ANY]) is
			-- Write to the standard output a string formatted
			-- according to the given format 'fmt' and arguments 'args'
		require
			format_string_exists: fmt /= Void
		do
			print (fmt_funcs.pf_formatted (fmt, args))
		end

	--|--------------------------------------------------------------

	sprintf (buf: STRING; fmt: STRING; args: FINITE [ANY]) is
			-- Replace the given STRING 'buf''s contents
			-- with a string formatted according to
			-- the format 'fmt' and arguments 'args'
		require
			buffer_exists: buf /= Void
			format_string_exists: fmt /= Void
		do
			buf.clear_all
			buf.append (fmt_funcs.pf_formatted (fmt, args))
		end

feature -- Error Status

	last_printf_successful: BOOLEAN is
			-- Was the most recent printf operation a success?
		do
			Result := last_printf_errors.is_empty
		ensure
			no_false_positive: Result implies last_printf_errors.is_empty
			no_misses: (not Result) implies not last_printf_errors.is_empty
			positive_inverse: (not last_printf_errors.is_empty) implies not Result
			negative_inverse: last_printf_errors.is_empty implies Result
		end

	--|--------------------------------------------------------------

	last_printf_error_out: STRING is
			-- Description from most recent error (if any)
		local
			te: like last_printf_error
		do
			te := last_printf_error
			if te = Void then
				Result := ""
			else
				Result := te.description
			end
		ensure
			exists: Result /= Void
		end

	--|--------------------------------------------------------------

	last_printf_error: AEL_PF_FORMAT_ERROR is
			-- Most recent error, from most recent operation
			-- Void if no errors occurred
		do
			if not last_printf_errors.is_empty then
				Result := last_printf_errors.last
			end
		end

feature -- Help

	printf_help_message: STRING is
		do
			Result := fmt_funcs.help_message
		ensure
			exists: Result /= Void
		end

end -- class AEL_PRINTF
