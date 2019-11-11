note
	description: "Summary description for {AWC_XML_METAR_TAGS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AWC_XML_METAR_TAGS

feature -- AWC XML METAR tags constants

	metar_tag:						STRING = "METAR"
			--
	raw_text_tag:					STRING = "raw_text"
			--
	station_id_tag:					STRING = "station_id"
			--
	observation_time_tag:			STRING = "observation_time"
			--
	latitude_tag:					STRING = "latitude"
			--
	longitude_tag:					STRING = "longitude"
			--
	temp_c_tag:						STRING = "temp_c"
			--
	dew_point_c_tag:				STRING = "dew_point_c"
			--
	wind_dir_degrees_tag:			STRING = "wind_dir_degrees"
			--
	wind_speed_kt_tag:				STRING = "wind_speed_kt"
			--
	visibility_statute_mi_tag:		STRING = "visibility_statute_mi"
			--
	altim_in_hg_tag:				STRING = "altim_in_hg"
			--
	quality_control_flags_tag:		STRING = "quality_control_flags"
			--
	qcf_no_signal_tag:				STRING = "no_signal"
			--
	sky_condition_tag:				STRING = "sky_condition"
			--
	sc_sky_cover_attribute:			STRING = "sky_cover"
			--
	sc_cloud_base_ft_agl_atribute:	STRING = "cloud_base_ft_agl"
			--
	flight_category_tag:			STRING = "flight_category"
			--
	metar_type_tag:					STRING = "metar_type"
			--
	elevation_m_tag:				STRING = "elevation_m"
			--
end
