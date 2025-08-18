note
	description: "Summary description for {RUNWAY_CONDITION_CODES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RUNWAY_CONDITION_CODES

feature -- Runway deposits

	rd_clear_and_dry:             CHARACTER = '0'
			-- clear and dry
	rd_damp:                      CHARACTER = '1'
			-- damp
	rd_wet:                       CHARACTER = '2'
			-- wet or water particles
	rd_rime:                      CHARACTER = '3'
			-- rime or frost covered (normally > 1 mm)
	rd_dry_snow:                  CHARACTER = '4'
			-- dry snow
	rd_wet_snow:                  CHARACTER = '5'
			-- wet snow
	rd_slush:                     CHARACTER = '6'
			-- slush
	rd_ice:                       CHARACTER = '7'
			-- ice
	rd_compacted_snow:            CHARACTER = '8'
			-- compacted or rolled snow
	rd_frozen:                    CHARACTER = '9'
			-- frozen ruts or ridges
	rd_not_reported:              CHARACTER = '/'

feature -- Extent of runway contamination - covering

	covered_less_10:              CHARACTER = '1'
			-- <10% contaminated (coverd)
	covered_11_to_25:             CHARACTER = '2'
			-- 11% to 25% contaminated (covered)
	covered_26_to_50:             CHARACTER = '5'
			-- 26% to 50% contaminated (covered)
	covered_51_to_100:            CHARACTER = '9'
			-- 51% to 100% contaminated (covered)
	covering_not_reported:        CHARACTER = '/'
			-- Not reported (runway clearance in progress)

feature -- Depth of deposit

	dd_less_than_1mm:                STRING = "00"
			-- less than 1 mm

	-- from "01" to "90" measurement in mm

	dd_10cm:                         STRING = "92"
			-- 10 cm
	dd_15cm:                         STRING = "93"
			-- 15 cm
	dd_20cm:                         STRING = "94"
			-- 20 cm
	dd_25cm:                         STRING = "95"
			-- 25 cm
	dd_30cm:                         STRING = "96"
			-- 30 cm
	dd_35cm:                         STRING = "97"
			-- 35 cm
	dd_40cm_or_more:                 STRING = "98"
			-- 40 cm or more
	dd_not_operational:              STRING = "99"
			-- Runway not operational due to snow,
			-- slush, ice, large drifts or runway
			-- clearance, depth not reported
	dd_not_measurable:               STRING = "//"
			-- Not operationally sgnificant or not
			-- meaurable

-- TODO Add descriptions

end
