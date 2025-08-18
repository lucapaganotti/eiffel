note
	description: "Summary description for {WEATHER_CODES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEATHER_CODES

feature -- Intensity

	light_intensity:                   STRING = "-"
			-- Light intensiy phenomena
	moderate_intensity:                STRING = ""
			-- Moderate intensity phenomena
	heavy_intensity:                   STRING = "+"
			-- Heavy intensity phenomena

feature -- Descriptors
	descriptor_in_the_vicinity:        STRING = "VC"
			-- In the vicinity (5–10 mi / 8–16 km from station); visible phenomena:
			-- TS, SH, FG, DS, SS, VA, PO, FC, BLSN, BLDU, BLSA
	descriptor_past_phenomenon:        STRING = "RE"
			-- Recent hour's most important past phenomenon with residues:
			-- TS, RA, FZRA, SN, BLSN, GR, GS, PL (e.g.: METAR ... Q1010 RERA=)
	descriptor_shallow:                STRING = "MI"
			-- Shallow [French: Mince] (fog descriptor)
	descriptor_partial:                STRING = "PR"
			-- Partial (fog descriptor)
	descriptor_patches:                STRING = "BC"
			-- Patches [French: Bancs] (fog descriptor)
	descriptors_low_drifting:          STRING = "DR"
			-- Low drifting below eye level; including: DRSN, DRSA, DRDU
	descriptor_blowing:                STRING = "BL"
			-- Blowing at or above eye level; including: BLSN, BLSA, BLDU
	descriptor_showers:                STRING = "SH"
			-- Showers (*also without precipitation: VCSH)
	descriptor_thunderstorm:           STRING = "TS"
			-- Thunderstorm (*also without precipitation: VCTS, RETS or as thunder)
	descriptor_freezing:               STRING = "FZ"
			-- Freezing; including: FZDZ, FZRA, FZFG

feature -- Precipitation

	precipitation_drizzle:             STRING = "DZ"
			-- 	Drizzle
	precipitation_rain:                STRING = "RA"
			-- Rain
	precipitation_snow_flakes:         STRING = "SN"
			-- Snow (snowflakes)
	precipitation_snow_grains:         STRING = "SG"
	        -- Snow grains
	precipitation_snow_graupels:       STRING = "GS"
			-- Graupel [French: Grésil], snow pellets and/or small hail (not in the US).[note 3][18]
			-- Elsewhere hail is GR when it is 5 mm or greater[19]
			-- Outside of the US when the hail is less than 5 mm the code GS is used.[19])
	precipitation_hail:                STRING = "GR"
			-- Hail [French: Grêle] (in the US includes small hail)
	precipitation_ice_pellets:         STRING = "PL"
			-- Ice pellets
	precipitation_ice_crystals:        STRING = "IC"
			-- Ice crystals
	precipitation_unknown:             STRING = "UP"
			-- Unknown precipitation

feature -- Obscuration

	obscuration_fog:                   STRING = "FG"
			-- Fog (visibility less than 1 km)
	obscuration_mist:                  STRING = "BR"
			-- 	Mist [French: Brume] (due to water droplets, visibility between 1 and 5 km)[
	obscuration_haze:                  STRING = "HZ"
			-- Haze (due to dry particulates, visibility between 1 and 5 km)[
	obscuration_volcanic_ash:          STRING = "VA"
			-- Volcanic ash
	obscuration_widespread_dust:       STRING = "DU"
			-- Widespread dust
	obscuration_smoke:                 STRING = "FU"
			-- Smoke [French: Fumée]
	obscuration_sand:                  STRING = "SA"
			-- Sand
	obscurtion_spray:                  STRING = "PY"
			-- Spray, only coded as BLPY

feature -- Other

	other_squall:                      STRING = "SQ"
			-- Squall
	other_dust:                        STRING = "PO"
			-- Dust [French: Poussière] or sand whirls
	other_dust_storm:                  STRING = "DS"
			-- Duststorm
	other_sand_storm:                  STRING = "SS"
			-- Sandstorm
	other_funnel_cloud:                STRING = "FC"
			-- 	Funnel cloud

feature -- Time

	time_began_at_time:                STRING = "B"
			-- Began at time
	time_ended_at_time:                STRING = "E"
			-- Ended at time

-- 2 digits --> minutes of current hour
-- 4 digits --> hour/minutes Zulu time

end
