note
	description: "Summary description for {MSG_CONSTANTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MSG_CONSTANTS

feature -- Constants

	nl: CHARACTER = '%N'
			--
	comma: CHARACTER = ','
			--
	space: CHARACTER = ' '
			--

	not_assigned: STRING = "N.A."
			--

	default_date_format: STRING = "yyyy/[0]mm/[0]dd"
			--

	default_time_format: STRING = "[0]hh:[0]mi:[0]ss.ff3"
			--

	default_date_time_format: STRING = "yyyy/[0]mm/[0]dd [0]hh:[0]mi:[0]ss.ff3"
			--

end
