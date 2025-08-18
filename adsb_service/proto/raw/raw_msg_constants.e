note
	description: "Summary description for {RAW_MSG_CONSTANTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RAW_MSG_CONSTANTS

feature -- Initialization

	asterisk:               CHARACTER = '*'
    semicolon:              CHARACTER = ';'

    short_hex_msg_length:   INTEGER   =  14
    long_hex_msg_length:    INTEGER   =  28
    hex_me_segment_length:  INTEGER   =   6

	short_bin_msg_length:	INTEGER   =  56
	long_bin_msg_length:    INTEGER   = 112
	bin_me_segment_length:  INTEGER   =  24

end
