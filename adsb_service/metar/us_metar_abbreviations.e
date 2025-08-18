note
	description: "Summary description for {US_METAR_ABBREVIATIONS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	US_METAR_ABBREVIATIONS

feature -- METAR and TAF abbreviations and acronyms:

	maintenance_check_indicator:                           STRING = "$"
			-- Maintenance check indicator
	visual_range_data_follows:                             STRING = "/"
			-- indicator that visual range data follows; separator between temperature and dew point data
	altocumulus_castellanus	:                              STRING = "ACC"
			-- altocumulus castellanus
	aircraft_mishap:                                       STRING = "ACFT MSHP"
			-- aircraft mishap
	altocumulus_standing_lenticular_cloud:                 STRING = "ACSL"
			-- altocumulus standing lenticular cloud
	airport_location_point:                                STRING = "ALP"
			-- airport location point
	all_quadrants_official:                                STRING = "ALQDS"
			-- all quadrants (official)
	all_quadrants_unofficial:                              STRING = "ALQS"
			-- all quadrants (unofficial)
	automated_station_no_precipitation_discriminator:      STRING = "AO1"
			-- automated station without precipitation discriminator
	automated_station_with_precipitation_discriminator:    STRING = "AO2"
			-- automated station with precipitation discriminator
	approach:                                              STRING = "APCH"
			-- approach
	apparent:                                              STRING = "APRNT"
			-- apparent
	approximately:                                         STRING = "APRX"
			-- approximately
	airport_traffic_control_tower:                         STRING = "ATCT"
			-- airport traffic control tower
	auto:                                                  STRING = "AUTO"
			-- fully automated report
	center:                                                STRING = "C"
			-- center (with reference to runway designation)
	cloud_air_lightning:                                   STRING = "CA"
			-- cloud-air lightning
	cumulonimbus_cloud:                                    STRING = "CB"
			-- cumulonimbus cloud
	cumulonimbus_mammatus_cloud:                           STRING = "CBMAM"
			-- cumulonimbus mammatus cloud
	cloud_cloud_lightning:                                 STRING = "CC"
			-- cloud-cloud lightning
	cirrocumulus_standing_lenticular_cloud:                STRING = "CCSL"
			-- cirrocumulus standing lenticular cloud
	candela:                                               STRING = "cd"
			-- candela
	cloud_ground_lightning:                                STRING = "CG"
			-- cloud-ground lightning
	cloud_height_indicator:                                STRING = "CHI"
			-- cloud-height indicator
	sky_condition_at_secondary_location_not_available:     STRING = "CHINO"
			--	sky condition at secondary location not available
	ceiling:                                               STRING = "CIG"
			-- ceiling
	continuous:                                            STRING = "CONS"
			-- continuous
	correction_to_a_previously_disseminated_observation:   STRING = "COR"
			-- correction to a previously disseminated observation
	department_of_commerce:                                STRING = "DOC"
			-- Department of Commerce
	department_of_defense:                                 STRING = "DOD"
			-- 	Department of Defense
	department_of_transportation:                          STRING = "DOT"
			-- 	Department of Transportation
	dissipating:                                           STRING = "DSIPTG"
			-- dissipating
	distant:                                               STRING = "DSNT"
			-- distant
	dispatch_visual_range:                                 STRING = "DVR"
			-- dispatch visual range
	east_ended_estimated_ceiling:                          STRING = "E"
			-- east, ended, estimated ceiling (SAO)
	federal_aviation_administration:                       STRING = "FAA"
			-- Federal Aviation Administration
	filed_but_impracticable_to_transmit:                   STRING = "FIBI"
			-- filed but impracticable to transmit
	first_observation_after_a_break_in_coverage:           STRING = "FIRST"
			--	first observation after a break in coverage at manual station
	federal_meteorological_handbook_no_1:                  STRING = "FMH-1"
			-- Federal Meteorological Handbook No.1, Surface Weather Observations & Reports (METAR)
	federal_meteorologica_handbook_no_2:                   STRING = "FMH-2"
			-- Federal Meteorological Handbook No.2, Surface Synoptic Codes
	frontal_passage:                                       STRING = "FROPA"
			-- frontal passage
	frost_on_the_indicator:                                STRING = "FROIN"
			-- frost on the indicator
	frequent:                                              STRING = "FRQ"
			-- frequent
	feet:                                                  STRING = "FT"
			-- feet
	freezing_rain_sensor_not_available:                    STRING = "FZRANO"
			-- freezing rain sensor not available
	gust:                                                  STRING = "G"
			-- gust
	hailstone:                                             STRING = "HLSTO"
			-- hailstone
	international_civil_aviation_organization:             STRING = "ICAO"
			-- International Civil Aviation Organization
	






end
