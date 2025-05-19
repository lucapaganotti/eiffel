note
	description: "Summary description for {SBS_MSG_CONSTANTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SBS_MSG_CONSTANTS

feature {NONE} -- Constants

    str_space:                      STRING  = " "

	sbs_msg_type:	                STRING  = "MSG"
	sbs_sel_type:                   STRING  = "SEL"	-- not used
	sbs_id_type:                    STRING  = "id" 	-- not used
	sbs_air_type:                   STRING  = "AIR"	-- not used
	sbs_sta_type:                   STRING  = "STA"	-- not used
	sbs_clk_type:                   STRING  = "CLK"	-- not used

	sbs_tx_type_identification:     INTEGER = 1	-- Idententification and category DF17 BDS 0,8
	sbs_tx_type_surface_position:   INTEGER = 2	-- Surface position DF17 BDS 0,6
	sbs_tx_type_airborne_position:  INTEGER = 3	-- Airborne position DF17 BDS 0,5
	sbs_tx_type_velocity:           INTEGER = 4	-- Airborne velocity DF17 BDS 0,9
	sbs_tx_type_surveillance_alt:   INTEGER = 5	-- Surveillance alt DF4 DF20
	sbs_tx_type_surveillance_id:    INTEGER = 6	-- Surveillance id DF4
	sbs_tx_type_air_to_air:         INTEGER = 7	-- DF16 not included in SBS output
	sbs_tx_type_all_call_reply:     INTEGER = 8	-- Broadcast o from ground radar DF11

	sbs1_datetime_format_code:      STRING  = "yyyy/[0]mm/[0]dd [0]hh:[0]mi:[0]ss.ff3"
	not_assigned:                   STRING  = "NA"

end
