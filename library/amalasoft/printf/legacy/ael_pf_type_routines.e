indexing
	description: "Support routines for type matching and assignment"
	license: "Eiffel Forumn License v2 - See license.txt"
	source: "{
		Amalasoft Corporation
		273 Harwood Avenue
		Littleton, MA 01460 USA
		}"
	status: "Copyright 1995-2009, Amalasoft";
	date: "$Date: 2009/07/14 $";
	revision: "$Revision: 005$";

class AEL_PF_TYPE_ROUTINES

inherit
	AEL_PF_FORMATTING_CONSTANTS

--|========================================================================
feature {NONE} -- Attachment shim
--|========================================================================

	is_attached (v: ANY): BOOLEAN is
		do
			Result := v /= Void
		end

--|========================================================================
feature {NONE} -- Type conversion
--|========================================================================

	any_to_finite (v: ANY): FINITE [ANY] is
		do
			Result ?= v
		end

	any_to_tuple (v: ANY): TUPLE [] is
		do
			Result ?= v
		end

	any_to_indexable (v: ANY): INDEXABLE [ANY, INTEGER] is
		do
			Result ?= v
		end

	any_to_string (v: ANY): STRING is
		do
			Result ?= v
		end

	any_to_indexable_container (v: ANY): INDEXABLE [CONTAINER[ANY],INTEGER] is
		do
			Result ?= v
		end

--|========================================================================
feature -- Basic type conversions
--|========================================================================

	any_to_string_8 (v: ANY): STRING_8 is
		do
			Result ?= v
		end

	any_to_string_32 (v: ANY): STRING_32 is
		do
			Result ?= v
		end

	--|--------------------------------------------------------------

	any_to_character_8_ref (v: ANY): CHARACTER_8_REF is
		do
			Result ?= v
		end

	any_to_character_32_ref (v: ANY): CHARACTER_32_REF is
		do
			Result ?= v
		end

	--|--------------------------------------------------------------

	any_to_integer_8_ref (v: ANY): INTEGER_8_REF is
		do
			Result ?= v
		end

	any_to_integer_16_ref (v: ANY): INTEGER_16_REF is
		local
			ti8: INTEGER_8_REF
		do
			ti8 ?= v
			if ti8 /= Void then
				Result := ti8.to_integer_16
			else
				Result ?= v
			end
		end

	any_to_integer_32_ref (v: ANY): INTEGER_32_REF is
		local
			ti8: INTEGER_8_REF
			ti16: INTEGER_16_REF
		do
			ti8 ?= v
			if ti8 /= Void then
				Result := ti8.to_integer_32
			else
				ti16 ?= v
				if ti16 /= Void then
					Result := ti16.to_integer_32
				else
					Result ?= v
				end
			end
		end

	any_to_integer_64_ref (v: ANY): INTEGER_64_REF is
		local
			ti8: INTEGER_8_REF
			ti16: INTEGER_16_REF
			ti32: INTEGER_32_REF
		do
			ti8 ?= v
			if ti8 /= Void then
				Result := ti8.to_integer_64
			else
				ti16 ?= v
				if ti16 /= Void then
					Result := ti16.to_integer_64
				else
					ti32 ?= v
					if ti32 /= Void then
						Result := ti32.to_integer_64
					else
						Result ?= v
					end
				end
			end
		end

	--|--------------------------------------------------------------

	any_to_natural_8_ref (v: ANY): NATURAL_8_REF is
		do
			Result ?= v
		end

	any_to_natural_16_ref (v: ANY): NATURAL_16_REF is
		local
			ti8: NATURAL_8_REF
		do
			ti8 ?= v
			if ti8 /= Void then
				Result := ti8.to_natural_16
			else
				Result ?= v
			end
		end

	any_to_natural_32_ref (v: ANY): NATURAL_32_REF is
		local
			ti8: NATURAL_8_REF
			ti16: NATURAL_16_REF
		do
			ti8 ?= v
			if ti8 /= Void then
				Result := ti8.to_natural_32
			else
				ti16 ?= v
				if ti16 /= Void then
					Result := ti16.to_natural_32
				else
					Result ?= v
				end
			end
		end

	any_to_natural_64_ref (v: ANY): NATURAL_64_REF is
		local
			ti8: NATURAL_8_REF
			ti16: NATURAL_16_REF
			ti32: NATURAL_32_REF
		do
			ti8 ?= v
			if ti8 /= Void then
				Result := ti8.to_natural_64
			else
				ti16 ?= v
				if ti16 /= Void then
					Result := ti16.to_natural_64
				else
					ti32 ?= v
					if ti32 /= Void then
						Result := ti32.to_natural_64
					else
						Result ?= v
					end
				end
			end
		end

	--|--------------------------------------------------------------

	any_to_real_32_ref (v: ANY): REAL_32_REF is
		do
			Result ?= v
		end

	any_to_real_64_ref (v: ANY): REAL_64_REF is
		do
			Result ?= v
		end

	--|--------------------------------------------------------------

	any_to_boolean_ref (v: ANY): BOOLEAN_REF is
		do
			Result ?= v
		end


end -- class AEL_PF_TYPE_ROUTINES
