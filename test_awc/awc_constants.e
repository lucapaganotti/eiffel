note
	description: "Summary description for {AWC_CONSTANTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AWC_CONSTANTS

feature -- Constants

	standard_metar_query: STRING = "httpparam?dataSource=metars&requestType=retrieve&format=xml&stationString=$ARPT_ICAO_CODE$&hoursBeforeNow=3&mostRecent=true"

end
