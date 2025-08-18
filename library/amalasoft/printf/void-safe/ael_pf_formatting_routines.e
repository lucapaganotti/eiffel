note
	description: "Core formatting routines of the ael_printf cluster"
	license: "Eiffel Forumn License v2 - See license.txt"
	source: "{
		Amalasoft Corporation
		273 Harwood Avenue
		Littleton, MA 01460 USA
		}"
	status: "Copyright 1995-2009, Amalasoft";
	date: "$Date: 2009/07/14 $";
	revision: "$Revision: 005$"

class AEL_PF_FORMATTING_ROUTINES

inherit
	AEL_PF_FORMATTING_CONSTANTS
	AEL_PF_FORMAT_ERROR_SUPPORT
	AEL_PF_TYPE_ROUTINES

 --|========================================================================
feature -- Core formatter
 --|========================================================================

	pf_formatted (fmt: STRING; args: detachable ANY): STRING is
			-- A string formatted according to the format 'fmt'
			-- and arguments 'args' given, in the manner of printf
			--
			-- 'args' can be:
			--   A TUPLE containing arguments
			--   A data structure conforming to FINITE
			--   An individual object reference relating to a single 
			--   format item
			--   Or, if no arguments are needed, simply Void
			--
			-- A complete description is embedded within the help_message
			-- function elsewhere in this class.
		local
			pos, lim, idx, fp_count, tok_width: INTEGER
			c: CHARACTER
			fp: AEL_PF_FORMAT_PARAM
			tis: detachable INDEXABLE [detachable ANY,INTEGER]
			tic: detachable INDEXABLE [detachable CONTAINER[detachable ANY],INTEGER]
			ts: detachable STRING
			tok: AEL_PF_FORMAT_TOKEN
			tokens: LINKED_LIST [AEL_PF_FORMAT_TOKEN]
			arg_count: INTEGER
			arglist: detachable FINITE [detachable ANY]
			argtuple: detachable TUPLE []
			arg: detachable ANY
		do
			create tokens.make
			if args /= Void then
				arglist := any_to_finite (args)
				if arglist /= Void then
					ts := any_to_string (args)
					if ts /= Void then
						-- Strings are indexable, but we want the 
						-- whole string, not each character
						arglist := << ts >>
					end
					arg_count := arglist.count
				else
					argtuple := any_to_tuple (args)
					if argtuple /= Void then
						arg_count := argtuple.count
					else
						arg_count := 1
						arglist := << args >>
					end
				end
				last_printf_errors.wipe_out
				create tok.make (1)
				tokens.extend (tok)
				lim := fmt.count
				from pos := 1
				until pos > lim
				loop
					c := fmt.item (pos)
					tok_width := 1
					if c /= '%%' then
						--| Not a format param
						--| Add char directly to Result
						tok.extend (c)
					elseif fmt.count <= pos then
						--| Not big enough to be a format param
						--| Add char directly to Result
						--| fmt.count is last fmt char, pos is current index
						--| if count = pos, then pct is last char and cannot
						--| be a format, but if count = pos + 1, it can be,
						--| but not much more
						tok.extend (c)
					else
						--| We have what we think is a format parameter
						--| Create a new format parameter
						create fp.make_from_string (fmt, pos)
						if (not tok.is_empty) or tok.is_format then
							-- In use
							create tok.make (pos)
							tokens.extend (tok)
						end
						--| Reposition past the format parameter
						tok_width := fp.original_length
						if fp.is_typed then
							if not fp.has_format_error then
								fp_count := fp_count + 1
								tok.set_format (fp)
							else
								-- Need to handle an actual error,
								-- already recorded in param
							end
						else
							-- Not a format token, just a string
							tok.set_string_value (fp.token)
						end

						create tok.make (pos+tok_width)
						tokens.extend (tok)
					end
					pos := pos + tok_width
				end -- end format parse loop
			end -- if args /= Void
			if fp_count = 0 then
				-- No format, then args are irrelevant
				if args /= Void then
					add_arg_count_error (fmt, fmt.count, fp_count, arg_count)
				end
				Result := fmt
			else
				Result := ""
				if fp_count > 1 then
					-- Must have a container or tuple argument list
					if arglist = Void and argtuple = Void then
						add_arg_count_error (fmt, fmt.count, fp_count, arg_count)
						Result := fmt
					end
				end
			end
			--| RFO Is this too harsh?
			if fp_count > 0 and Result.is_empty then
				create Result.make (fmt.count)
				-- Walk the tokens and match up with arguments
				from
					tokens.start
					idx := 0
				until tokens.exhausted
				loop
					tok := tokens.item
					if not attached tok.format as t then
						Result.append (tok.string_value)
					else
						fp := t
						if fp.has_format_error then
							-- A bad format specifier, or just text that 
							-- looks like one, copy to output unchanged and 
							-- assume there is not corresponding argument
							Result.append (fp.token)
						else
							--| Bump the argument index
							idx := idx + 1
							--| Check the argument index to make sure we didn't 
							--| run out of arguments
							if idx > arg_count then
								-- Ran out of arguments
								add_arg_count_error (fmt, tok.position, idx, arg_count)
								Result.append (Ks_printf_missing_arg_stub)
							else
								--| Get the positional argument for the format
								arg := Void
								if argtuple /= Void then
									arg := argtuple.item (idx)
								else
									-- To gain access to indexability of arglist
									tis := any_to_indexable (arglist)
									ts := any_to_string (arglist)
									tic := any_to_indexable_container (arglist)
									if tis /= Void then
										if ts /= Void then
											-- Strings are indexable, but we want the 
											-- whole string, not the idxth character
											arg := ts
										elseif (idx = 1 and fp_count = 1 and fp.is_list)
											and tic = Void
										 then
											 --RFO
											-- If the arg is supposed to be a container,
											 -- check fmt count.  If there is only one 
											 -- arg and the fmt calls for a container, 
											 -- then the arg list might be the arg.
											 -- Can happen only w/ a single arg
											 -- Argv is the argument itself
											 arg := tis
										else
											arg := tis.item (idx)
										end
									else -- not indexable
										Result.append (Ks_printf_missing_arg_stub)
										add_internal_error (
											fmt, tok.position,
											"Possible corrupted args list")
									end
								end
								fp.set_argument (arg)
								if fp.arg_matches_type (arg) then
									Result.append (fp.arg_out)
								else
									-- Not a match, consume the arg but
									-- show an error
									add_arg_type_error (
										fmt, tok.position,
										fp.expected_class_name,
										fp.argument_class_name)
									Result.append (Ks_printf_mismatch_type_stub)
								end
							end
						end
					end
					tokens.forth
				end
				--RFO should this be done before walking the arg list?
				if fp_count /= arg_count then
					-- Have too many args (too few already caught)
					add_arg_count_error (fmt, fmt.count, fp_count, arg_count)
				end
			end
		end

 --|========================================================================
feature -- Conversion functions
 --|========================================================================

	natural_out (v: NATURAL_64; nb: INTEGER): STRING is
			-- Decimal string representation of given unsigned integer,
			-- with no padding, and respectful of integer size (nb)
		do
			if v = 0 then
				Result := "0"
			else
				inspect nb
				when 1 then
					Result := v.to_natural_8.out
				when 2 then
					Result := v.to_natural_16.out
				when 4 then
					Result := v.to_natural_32.out
				else
					Result := v.out
				end
			end
		ensure
			exists: not Result.is_empty
		end

	--|--------------------------------------------------------------

	integer_to_hex (v: INTEGER_64; nb: INTEGER): STRING is
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
					tmps.extend (Printf_hex_digits.item (tm.as_integer_32 + 1))
					tv := tv // 16
				end
				Result := tmps.mirrored
				Result.keep_tail (nb*2)
			end
		ensure
			exists: not Result.is_empty
		end

	--|--------------------------------------------------------------

	integer_to_octal (v: INTEGER_64; nb: INTEGER): STRING is
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
				inspect nb
				when 1 then
					Result := natural_8_to_octal (v.to_natural_8)
				when 2 then
					Result := natural_16_to_octal (v.to_natural_16)
				when 4 then
					Result := natural_32_to_octal (v.to_natural_32)
				else
					tv := v.to_natural_64
					--| Build the result string backwards, then flip it
					create tmps.make (10)
					from
					until tv = 0
					loop
						tm := tv \\ 8
						tmps.extend (Printf_octal_digits.item (tm.as_integer_32 + 1))
						tv := tv // 8
					end
					Result := tmps.mirrored
				end
			end
		ensure
			exists: not Result.is_empty
		end

	--|--------------------------------------------------------------

	natural_8_to_octal (v: NATURAL_8): STRING is
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
			tv, tm: NATURAL_8
		do
			if v = 0 then
				Result := "0"
			else
				tv := v
				--| Build the result string backwards, then flip it
				create tmps.make (10)
				from
				until tv = 0
				loop
					tm := tv \\ 8
					tmps.extend (Printf_octal_digits.item (tm.as_integer_32 + 1))
					tv := tv // 8
				end
				Result := tmps.mirrored
			end
		ensure
			exists: Result /= Void and then not Result.is_empty
		end

	--|--------------------------------------------------------------

	natural_16_to_octal (v: NATURAL_16): STRING is
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
			tv, tm: NATURAL_16
		do
			if v = 0 then
				Result := "0"
			else
				tv := v
				--| Build the result string backwards, then flip it
				create tmps.make (10)
				from
				until tv = 0
				loop
					tm := tv \\ 8
					tmps.extend (Printf_octal_digits.item (tm.as_integer_32 + 1))
					tv := tv // 8
				end
				Result := tmps.mirrored
			end
		ensure
			exists: Result /= Void and then not Result.is_empty
		end

	--|--------------------------------------------------------------

	natural_32_to_octal (v: NATURAL_32): STRING is
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
			tv, tm: NATURAL_32
		do
			if v = 0 then
				Result := "0"
			else
				tv := v
				--| Build the result string backwards, then flip it
				create tmps.make (10)
				from
				until tv = 0
				loop
					tm := tv \\ 8
					tmps.extend (Printf_octal_digits.item (tm.as_integer_32 + 1))
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
			exists: not Result.is_empty
		end

	--|--------------------------------------------------------------

	double_parts_out (whole_out: STRING; fract_part, factor: INTEGER_64; right_w: INTEGER): STRING is
			-- String representation of floating point component values, with 
			-- fractional part conforming to the fractional field width 
			-- (right_w)
		require
			whole_exists: not whole_out.is_empty
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
			exists: not Result.is_empty
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
			exists: Result.count = 3
		end

 --|========================================================================
feature {NONE}	-- Supporting routines
 --|========================================================================

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
			exists: not Result.is_empty
		end

end -- class AEL_PF_FORMATTING_ROUTINES
