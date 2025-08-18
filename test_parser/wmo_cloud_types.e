note
	description: "Summary description for {WMO_CLOUD_TYPES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WMO_CLOUD_TYPES

feature -- WMO cloud types

	low_clouds_none:                                                          INTEGER = 0
	midlle_clouds_none:                                                       INTEGER = 0
	high_clouds_none:                                                         INTEGER = 0

	low_clouds_cumulus_fair_weather:                                          INTEGER = 1
	middle_clouds_altostratus_thin:                                           INTEGER = 1
	high_clouds_cirrus_filaments:                                             INTEGER = 1

	low_clouds_cumulus_towering:                                              INTEGER = 2
	middle_clouds_altostratus_thick:                                          INTEGER = 2
	high_clouds_cirrus_dense:                                                 INTEGER = 2

	low_clouds_cumulonimbus_no_anvil:                                         INTEGER = 3
	middle_clouds_altocumulus_thin:                                           INTEGER = 3
	high_clouds_cirrus_often_with_cumulonimbus:                               INTEGER = 3

	low_clouds_stratocumulus_from_cumulus:                                    INTEGER = 4
	middle_clouds_altocumulus_patchy:                                         INTEGER = 4
	high_clouds_cirrus_thickening:                                            INTEGER = 4

	low_clouds_stratocumulus_not_cumulus:                                     INTEGER = 5
	middle_clouds_altocumulus_thickening:                                     INTEGER = 5
	high_clouds_cirrus_or_cirrustratus_low_in_sky:                            INTEGER = 5

	low_clouds_stratus_or_fractostratus_fair:                                 INTEGER = 6
	middle_clouds_altocumulus_from_cumulus:                                   INTEGER = 6
	high_clouds_cirrus_or_cirrusstratus_high_in_sky:                          INTEGER = 6

	low_clouds_fractocumulus_or_fractostratus_bad_weather:                    INTEGER = 7
	middle_clouds_altocumulus_with_altocumulus_altostratus_nimbusstratus:     INTEGER = 7
	high_clouds_cirrus_stratus_entire_sky:                                    INTEGER = 7

	low_clouds_cumulus_and_stratocumulus:                                     INTEGER = 8
	middle_clouds_altocumulus_with_turrets:                                   INTEGER = 8
	high_clouds_cirrusstratus_partial:                                        INTEGER = 8

	low_clouds_cumulonimbus_thunderstorm:                                     INTEGER = 9
	middle_clouds_altocumulus_chaotic:                                        INTEGER = 9
	high_clouds_cirruscumulus_or_cirruscumulus_cirrus_cirrusstratus:          INTEGER = 9

	low_clouds_not_valid:                                                     CHARACTER = '/'
	middle_clouds_above_overcast:                                             CHARACTER = '/'
	high_clouds_above_overcast:                                               CHARACTER = '/'

end
