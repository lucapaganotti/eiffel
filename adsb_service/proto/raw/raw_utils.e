note
	description: "Summary description for {RAW_UTILS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RAW_UTILS

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do

		end

	cs_charmap: STRING
			--
		once
			Result := "#ABCDEFGHIJKLMNOPQRSTUVWXYZ##### ###############0123456789######"
		end

feature -- Operations

	bin2int (t: STRING): INTEGER
			--
		local
			i: INTEGER
		do
			from i := 1
			until i = t.count
			loop
				Result := Result + (t.at (i).out.to_integer * pow (2.0, i.to_double).truncated_to_integer)
			end
		end



feature {NONE} -- Externals

	pow (n, e: DOUBLE): DOUBLE
			--
		external
			"C signature (double, double): double use <math.h>"
		end

	floor (x: DOUBLE): DOUBLE
			--
		external
			"C signature (double): double use <math.h>"
		end

end
