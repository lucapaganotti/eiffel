note
	description: "Summary description for {METAR_DATA}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	METAR_DATA

inherit
	ANY
	CLOUD_COVERAGE_CODES
		undefine
			is_equal, copy
		end
	WMO_CLOUD_TYPES
		undefine
			is_equal, copy
		end
	WEATHER_CODES
		undefine
			is_equal, copy
		end

create
	make_from_string

feature {NONE} -- Initialization

	make_from_string (txt: STRING)
			-- Initialization for `Current'.
		require
			txt_attached: attached txt and not txt.is_empty
		do
			metar_string := txt
			create timestamp.make_now
			create precipitation.make_empty
			create cloud_cover.make_empty
		ensure
			metar_string_set: metar_string.is_equal (txt)
		end

	metar_string: STRING

feature -- Access

    timestamp:           DATE_TIME
	temperature:		 DOUBLE
	dew_point:           DOUBLE
	barometric_pressure: INTEGER
	wind_direction:      INTEGER
	wind_speed:          DOUBLE
	visibility:          DOUBLE
	precipitation:       STRING
	cloud_cover:         STRING
	cloud_height:        DOUBLE

feature -- Commands

	set_temperature (t: DOUBLE)
			--
		do
			temperature := t
		end

	se_dew_point (p: DOUBLE)
			--
		do
			dew_point := p
		end

	set_barometric_pressure (p: INTEGER)
			--
		do
			barometric_pressure := p
		end

	set_wind_direction (wd: INTEGER)
			--
		do
			wind_direction := wd
		end

	set_wind_speed (ws: DOUBLE)
			--
		do
			wind_speed := ws
		end

	set_visibility (v: DOUBLE)
			--
		do
			visibility := v
		end

	set_precipitation (p: STRING)
			--
		do
			precipitation := p
		end

	set_cloud_cover (c: STRING)
			--
		do
			cloud_cover := c
		end

	set_cloud_height (h: DOUBLE)
			--
		do
			cloud_height := h
		end

feature -- Status

	is_valid: BOOLEAN
			--
		do

		end

feature -- Operations

	parse: BOOLEAN
			--
		do

		end

feature -- Parsing

	lex_builder: detachable LEX_BUILDER

end
