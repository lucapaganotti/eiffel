indexing
	description: "Core formatting routines of the ael_printf cluster"
	license: "Eiffel Forumn License v2 - See license.txt"
	source: "{
		Amalasoft Corporation
		273 Harwood Avenue
		Littleton, MA 01460 USA
		}"
	status: "Copyright 1995-2008, Amalasoft";
	date: "$Date: 2008/04/21 $";
	revision: "$Revision: 003$";

class AEL_PF_FORMATTING_ROUTINES

inherit
	AEL_PF_FORMATTING_CONSTANTS
	AEL_PF_FORMAT_ERROR_SUPPORT

feature -- Core formatter

	pf_formatted (fmt: STRING; args: FINITE [ANY]): STRING is
			-- A string formatted according to the format 'fmt'
			-- and arguments 'args' given, in the manner of printf
			--
			-- A complete description is embedded within the help_message
			-- function elsewhere in this class.
		require
			format_string_exists: fmt /= Void
		local
			pos, lim, idx, fp_count: INTEGER
			c: CHARACTER
			fp: AEL_PF_FORMAT_PARAM
			fp_exp: STRING
			tok_width: INTEGER
			tis: INDEXABLE [ANY,INTEGER]
		do
			if args = Void then
				Result := fmt
			else
				last_printf_errors.wipe_out
				create Result.make (fmt.count)
				-- To gain access to indexability
				tis ?= args
				lim := fmt.count
				from pos := 1
				until pos > lim
				loop
					c := fmt.item (pos)
					tok_width := 1
					if c /= '%%' then
						--| Not a format param
						--| Add char directly to Result
						Result.extend (c)
					elseif fmt.count < (pos+1) then
						--| Not big enough to be a format param
						--| Add char directly to Result
						Result.extend (c)
					else
						--| We have what we think is a format parameter
						--| Create a new format parameter
						create fp.make_from_string (fmt, pos)
						if fp.has_format_error then
							fp_exp := fp.token
						else
							fp_count := fp_count + 1
							--| Bump the argument index
							idx := idx + 1
							--| Check the argument index to make sure we didn't 
							--| run out of arguments
							if idx > args.count then
								add_arg_count_error (fmt, pos, idx, args.count)
								fp_exp := Ks_missing_arg_stub
							else
								--RFO Is reverse assign needed here for INDEXABLE?
								fp.set_argument (tis.item(idx))
								fp_exp := fp.arg_out
							end
						end
						Result.append (fp_exp)
						--| Skip over the format parameter
						tok_width := fp.original_length
					end
					pos := pos + tok_width
				end -- end loop
				if fp_count /= args.count then
					-- Have too many args (too few already caught)
					add_arg_count_error (fmt, fmt.count, fp_count, args.count)
				end
			end
		ensure
			exists: Result /= Void
		end

feature -- Conversion functions

	integer_to_hex (v: INTEGER_64): STRING is
			-- Hexadecimal string representation of given integer,
			-- with no padding.
			--
			-- Hex format uses 1 position (digit) for each nibble (4 bits)
			-- The idea is to capture the least significant nibble from
			-- the original value, convert that into a hex character,
			-- then shift the original value by	4 bits, repeating the
			-- process until all bits are exhausted
			-- From a print standpoint, it's exhausted when the value
			-- remaining is zero, regardless of the number of bits in a
			-- theoretical integer.
		local
			tmps: STRING
			tv, tm: NATURAL_64
		do
			if v = 0 then
				Result := "0"
			else
				tv := v.to_natural_64
				--| Build the result string backwards, then flip it
				create tmps.make (8)
				from
				until tv = 0
				loop
					tm := tv \\ 16
					tmps.extend (Hex_digits.item (tm.as_integer_32 + 1))
					tv := tv // 16
				end
				Result := tmps.mirrored
			end
		ensure
			exists: Result /= Void and then not Result.is_empty
		end

	--|--------------------------------------------------------------

	integer_to_octal (v: INTEGER_64): STRING is
			-- Octal string representation of given integer,
			-- with no padding
			--
			-- Octal format uses 1 position (digit) for each 3 bits
			-- The idea is to capture the least significant 3 bits from
			-- the original value, convert that into an octal character,
			-- then shift the original value by	3 bits, repeating the
			-- process until all bits are exhausted
			-- From a print standpoint, it's exhausted when the value
			-- remaining is zero, regardless of the number of bits in a
			-- theoretical integer
		local
			tmps: STRING
			tv, tm: NATURAL_64
		do
			if v = 0 then
				Result := "0"
			else
				tv := v.to_natural_64
				--| Build the result string backwards, then flip it
				create tmps.make (10)
				from
				until tv = 0
				loop
					tm := tv \\ 8
					tmps.extend (Octal_digits.item (tm.as_integer_32 + 1))
					tv := tv // 8
				end
				Result := tmps.mirrored
			end
		ensure
			exists: Result /= Void and then not Result.is_empty
		end

	--|--------------------------------------------------------------

	integer_to_binary (v: INTEGER_64): STRING is
			-- Binary string representation of the given integer
			-- Integer argument can be of any size
			-- Representation presents smallest possible complete
			-- set of bit values (e.g. a value that fits into an
			-- INTEGER_16, but not into an INTEGER_8 shows as 16 bits)
		local
			i, first_bit: INTEGER
		do
			first_bit := 63
			if v < 0 then
				if v >= {INTEGER_8}.min_value then
					first_bit := 7
				elseif v >= {INTEGER_16}.min_value then
					first_bit := 15
				elseif v >= {INTEGER}.min_value then
					first_bit := 31
				end
			else
				if v <= {INTEGER_8}.max_value then
					first_bit := 7
				elseif v <= {INTEGER_16}.max_value then
					first_bit := 15
				elseif v <= {INTEGER}.max_value then
					first_bit := 31
				end
			end
			create Result.make (first_bit)
			from i := first_bit
			until i < 0
			loop
				if v.bit_test (i) then
					Result.extend ('1')
				else
					Result.extend ('0')
				end
				i := i - 1
			end
		ensure
			exists: Result /= Void and then not Result.is_empty
		end

	--|--------------------------------------------------------------

	double_parts_out (whole_out: STRING; fract_part, factor: INTEGER_64; right_w: INTEGER): STRING is
			-- String representation of floating point component values, with 
			-- fractional part conforming to the fractional field width 
			-- (right_w)
		require
			whole_exists: whole_out /= Void and then not whole_out.is_empty
		do
			--| Traditional printf renders floats with
			--| zero precision as rounded to Integers
			if right_w = 0 then
				Result := whole_out
			else
				create Result.make (8)
				Result.append (whole_out)
				Result.extend ('.')
				Result.append (fract_part_out (fract_part, factor, right_w))
			end
		ensure
			exists: Result /= Void and then not Result.is_empty
		end

	--|--------------------------------------------------------------

	double_to_parts (v:DOUBLE; rt_width:INTEGER): ARRAY [INTEGER_64] is
			-- Decomposition of the given floating point number into a pair
			-- of INTEGERs (the whole part and the factional part)
		local
			is_neg: BOOLEAN
			factor: INTEGER_64
			whole_part, fract_part: INTEGER_64
		do
			create Result.make (1, 3)
			is_neg := v < v.zero
			if is_neg then
				whole_part := v.ceiling.to_integer_64
			else
				whole_part := v.floor.to_integer_64
			end
			factor := ((10.0) ^ rt_width).truncated_to_integer_64
			fract_part := ((v - whole_part)*factor).truncated_to_integer_64.abs
			Result := << whole_part, fract_part, factor >>
		ensure
			exists: Result /= Void and then Result.count = 3
		end

feature {NONE}	-- Supporting routines

	fract_part_out (v, factor: INTEGER_64; w: INTEGER): STRING is
			-- Decimal integer value 'v' (representing the fractional 
			-- part of a floating point value), left-justified
			-- to a field of at most 'w' digits, with '0' padding 
		require
			valid_width: w > 0
		local
			i: INTEGER
		do
			if factor = 0 then
				create Result.make_filled ('0', w)
			else
				Result := v.out.substring (1, w)
				if Result.count < w then --| Pad it
					from i := Result.count
					until i = w
					loop
						Result.extend ('0')
						i := i + 1
					end
				end
			end
		ensure
			exists: Result /= Void and then not Result.is_empty
		end

feature -- Help

	help_message: STRING is
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

end -- class AEL_PF_FORMATTING_ROUTINES
