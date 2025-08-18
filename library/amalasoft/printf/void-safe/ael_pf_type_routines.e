note
	description: "Support routines for type matching and assignment"
	license: "Eiffel Forumn License v2 - See license.txt"
	source: "{
		Amalasoft Corporation
		273 Harwood Avenue
		Littleton, MA 01460 USA
		}"
	status: "Copyright 1995-2009, Amalasoft";
	date: "$Date: 2009/07/14 $";
	revision: "$Revision: 005$"

class AEL_PF_TYPE_ROUTINES

inherit
	AEL_PF_FORMATTING_CONSTANTS

--|========================================================================
feature {NONE} -- Attachment shim
--|========================================================================

	is_attached (v: detachable ANY): BOOLEAN is
		do
			Result := attached v
		end

--|========================================================================
feature {NONE} -- Type conversion
--|========================================================================

	any_to_finite (v: detachable ANY): detachable FINITE [detachable ANY] is
		do
			if attached {FINITE [detachable ANY]} v as ta then
				Result := ta
			end
		end

	any_to_tuple (v: detachable ANY): detachable TUPLE [] is
		do
			if attached {TUPLE []} v as ta then
				Result := ta
			end
		end

	any_to_indexable (v: detachable ANY): detachable INDEXABLE [detachable ANY, INTEGER] is
		do
			if attached {INDEXABLE [detachable ANY,INTEGER]} v as ta then
				Result := ta
			end
		end

	any_to_string (v: detachable ANY): detachable STRING is
		do
			if attached {STRING} v as ta then
				Result := ta
			end
		end

	any_to_indexable_container (v: detachable ANY): detachable INDEXABLE [detachable CONTAINER[detachable ANY],INTEGER] is
		do
			if
				attached
				{INDEXABLE [detachable CONTAINER[detachable ANY],INTEGER]} v as ta
			 then
				 Result := ta
			end
		end

--|========================================================================
feature -- Basic type conversions
--|========================================================================

	any_to_string_8 (v: detachable ANY): detachable STRING_8 is
		do
			if attached {STRING_8} v as ta then
				Result := ta
			end
		end

	any_to_string_32 (v: detachable ANY): detachable STRING_32 is
		do
			if attached {STRING_32} v as ta then
				Result := ta
			end
		end

	--|--------------------------------------------------------------

	any_to_character_8_ref (v: detachable ANY): detachable CHARACTER_8_REF is
		do
			if attached {CHARACTER_8_REF} v as ta then
				Result := ta
			end
		end

	any_to_character_32_ref (v: detachable ANY): detachable CHARACTER_32_REF is
		do
			if attached {CHARACTER_32_REF} v as ta then
				Result := ta
			end
		end

	--|--------------------------------------------------------------

	any_to_integer_8_ref (v: detachable ANY): detachable INTEGER_8_REF is
		do
			if attached {INTEGER_8_REF} v as ta then
				Result := ta
			end
		end

	any_to_integer_16_ref (v: detachable ANY): detachable INTEGER_16_REF is
		do
			if attached {INTEGER_8_REF} v as ti8 then
				Result := ti8.to_integer_16
			elseif attached {INTEGER_16_REF} v as ta then
				Result := ta
			end
		end

	any_to_integer_32_ref (v: detachable ANY): detachable INTEGER_32_REF is
		do
			if attached {INTEGER_8_REF} v as ti8 then
				Result := ti8.to_integer_32
			elseif attached {INTEGER_16_REF} v as ta then
				Result := ta.to_integer_32
			elseif attached {INTEGER_32_REF} v as ta then
				Result := ta
			end
		end

	any_to_integer_64_ref (v: detachable ANY): detachable INTEGER_64_REF is
		do
			if attached {INTEGER_8_REF} v as ti8 then
				Result := ti8.to_integer_64
			elseif attached {INTEGER_16_REF} v as ta then
				Result := ta.to_integer_64
			elseif attached {INTEGER_32_REF} v as ta then
				Result := ta.to_integer_64
			elseif attached {INTEGER_64_REF} v as ta then
				Result := ta
			end
		end

	--|--------------------------------------------------------------

	any_to_natural_8_ref (v: detachable ANY): detachable NATURAL_8_REF is
		do
			if attached {NATURAL_8_REF} v as ta then
				Result := ta
			end
		end

	any_to_natural_16_ref (v: detachable ANY): detachable NATURAL_16_REF is
		do
			if attached {NATURAL_8_REF} v as ti8 then
				Result := ti8.to_natural_16
			elseif attached {NATURAL_16_REF} v as ta then
				Result := ta
			end
		end

	any_to_natural_32_ref (v: detachable ANY): detachable NATURAL_32_REF is
		do
			if attached {NATURAL_8_REF} v as ti8 then
				Result := ti8.to_natural_32
			elseif attached {NATURAL_16_REF} v as ta then
				Result := ta.to_natural_32
			elseif attached {NATURAL_32_REF} v as ta then
				Result := ta
			end
		end

	any_to_natural_64_ref (v: detachable ANY): detachable NATURAL_64_REF is
		do
			if attached {NATURAL_8_REF} v as ti8 then
				Result := ti8.to_natural_64
			elseif attached {NATURAL_16_REF} v as ta then
				Result := ta.to_natural_64
			elseif attached {NATURAL_32_REF} v as ta then
				Result := ta.to_natural_64
			elseif attached {NATURAL_64_REF} v as ta then
				Result := ta
			end
		end

	--|--------------------------------------------------------------

	any_to_real_32_ref (v: detachable ANY): detachable REAL_32_REF is
		do
			if attached {REAL_32_REF} v as ta then
				Result := ta
			end
		end

	any_to_real_64_ref (v: detachable ANY): detachable REAL_64_REF is
		do
			if attached {REAL_64_REF} v as ta then
				Result := ta
			end
		end

	--|--------------------------------------------------------------

	any_to_boolean_ref (v: detachable ANY): detachable BOOLEAN_REF is
		do
			if attached {BOOLEAN_REF} v as ta then
				Result := ta
			end
		end

end -- class AEL_PF_TYPE_ROUTINES
