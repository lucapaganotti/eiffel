note
	description: "Summary description for {AIRBORNE_POSITION_ME_SEGMENT_DATA}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AIRBORNE_POSITION_ME_SEGMENT_DATA

inherit
	ME_SEGMENT_DATA
	CPR_FORMAT_CONSTANTS
	CPR_DECODING_UTILS
	SURVEILLANCE_STATUS_CONSTANTS

create
	make_from_string

feature {NONE} -- Initialization

	make_from_string (txt: STRING dt: DATE_TIME)
			-- Initialization for `Current'.
		require
			attached_txt_and_dt: attached txt and attached dt
		do
			bin_text       := txt
			reception_time := dt
			decode
		end

feature -- Access

	surveillance_status:       INTEGER
			-- Surveillance Status
	single_antenna_flag:       INTEGER
			-- Single Antenna Flag
	encoded_altitude:          INTEGER
			-- Encoded Altitude
	time:                      INTEGER
			-- Time
	cpr_format:                INTEGER
			-- CPR format
			-- 0: even frame
			-- 1: odd  frame
	encoded_cpr_latitude:      INTEGER
			-- Encoded Latitude
	encoded_cpr_longitude:     INTEGER
			-- Encoded Longitude
	reception_time:            DATE_TIME

feature -- Operations

	decode
			--
		do
			extract_ss
			extract_saf
			extract_alt
			extract_t
			extract_f
			extract_lat_cpr
			extract_lon_cpr
		end

feature {NONE}

	extract_ss
			--
		do
			surveillance_status := bin2int (bin_text.substring (6, 7))
		end

	extract_saf
			--
		do
			single_antenna_flag := bin2int (bin_text.substring (8, 8))
		end

	extract_alt
			--
		do
			encoded_altitude := bin2int (bin_text.substring (9, 20))
		end

	extract_t
			--
		do
			time := bin2int (bin_text.substring (21, 21))
		end

	extract_f
			--
		do
			cpr_format := bin2int (bin_text.substring (22, 22))
		end

	extract_lat_cpr
			--
		do
			encoded_cpr_latitude := bin2int (bin_text.substring (23, 39))
		end

	extract_lon_cpr
			--
		do
			encoded_cpr_longitude := bin2int (bin_text.substring (40, 56))
		end

end
