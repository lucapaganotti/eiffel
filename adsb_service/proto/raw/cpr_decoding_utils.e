note
	description: "Summary description for {CPR_DECODING_UTILS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CPR_DECODING_UTILS

inherit
	RAW_UTILS

feature -- Constants

	NZ:					INTEGER = 15


feature -- Functions

	cpr_floor (x: DOUBLE) : INTEGER
			-- `floor (x)` returns the greatest integer value `k`
			-- where `k` <= `x`
		do
			Result := x.floor.as_integer_32
		end

    cpr_mod (x, y: DOUBLE): DOUBLE
    		--
    	require
    		y_not_zero: y /= 0.0
    	do
    		Result := x - y * cpr_floor (x / y)
    	end

    cpr_nl (lat: INTEGER): INTEGER
    		-- Longitude Zone Number
    	do
    		if lat = 0 then
    			Result := 59
    		elseif lat = 87 or lat = -87 then
    			Result := 2
    		elseif lat > 87 or lat < -87 then
    			Result := 1
    		else
    			Result := cpr_floor (2.0 * {MATH_CONST}.pi / ( {DOUBLE_MATH}.arc_cosine ( 1.0 - (1.0 - {DOUBLE_MATH}.cosine ({MATH_CONST}.pi / (2.0 * NZ) ) ) / pow ({DOUBLE_MATH}.cosine ({MATH_CONST}.pi / 180.0 * lat), 2.0 ) ) ) )
    		end
    	end

end
