note
	description: "Summary description for {METAR_MESSAGE_TYPE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	METAR_MESSAGE_TYPE

feature -- Constants

	metar_message_type:        STRING = "METAR"
			--
	speci_message_type:        STRING = "SPECI"
			--
	auto_message_type:         STRING = "AUTO"
			--

	metar_type_description:    STRING = "routine weather report"
			--
	speci_type_description:    STRING = "special weather report, triggered by a weather change"
			--
	auto_type_description:     STRING = "ASOS/AWOS generated report"
			--
	unknown_type_description:  STRING = "Unknown message type"
			--
end
