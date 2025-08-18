note
	description: "Summary description for {CALLABLE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CALLABLE

feature
	inside
		local
			current_addr: POINTER
		do
			current_addr := $Current
			io.put_string ("We're inside at address: " + current_addr.to_integer_32.out)
			io.put_new_line
		end

	routine: POINTER
		do
			result := $inside
		end
end
