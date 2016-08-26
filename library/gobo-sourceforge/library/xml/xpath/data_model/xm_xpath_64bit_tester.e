indexing

	description:

		"XPath 64-bit equality testers"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class XM_XPATH_64BIT_TESTER

inherit

	KL_EQUALITY_TESTER [XM_XPATH_64BIT_NUMERIC_CODE]
		redefine
			test
		end

feature -- Status report

	test (v, u: XM_XPATH_64BIT_NUMERIC_CODE): BOOLEAN is
			-- Are `v' and `u' considered equal?
		do
			if v = u then
				Result := True
			elseif v = Void then
				Result := False
			elseif u = Void then
				Result := False
			else
				Result := v.is_equal (u)
			end
		end

end