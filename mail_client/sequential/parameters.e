note
	description: "Shared parameters"
	author: "Bertrand Meyer"
	date: "$Date$"
	revision: "$Revision$"

class
	PARAMETERS

feature -- Constants

	Max_messages: INTEGER = 10
			-- Number of messages to be generated

	Milli:INTEGER_64 = 1_000_000
			-- Number of nanoseconds in a millisecond. Facilitates parameterizing random wait times.


end
