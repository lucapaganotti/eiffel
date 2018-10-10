note
	description: "Summary description for {CFG_EXTERNAL_DEFINES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CFG_EXTERNAL_DEFINES

feature -- Version constants

	c_major_version: INTEGER
			-- libconfig major version
		external
			"C inline use %"libconfig.h%""
		alias
			"return LIBCONFIG_VER_MAJOR"
		end

	c_minor_version: INTEGER
			-- libconfig minor version
		external
			"C inline use %"libconfig.h%""
		alias
			"return LIBCONFIG_VER_MINOR"
		end

	c_revision_version: INTEGER
			-- libconfig revision
		external
			"C inline use %"libconfig.h%""
		alias
			"return LIBCONFIG_VER_REVISION"
		end

feature -- Settings types constants

	c_config_type_none: INTEGER
			-- #define CONFIG_TYPE_NONE 0
		external
			"C inline use %"libconfig.h%""
		alias
			"return CONFIG_TYPE_NONE"
		end

	c_config_type_group: INTEGER
			-- #define CONFIG_TYPE_GROUP 1
		external
			"C inline use %"libconfig.h%""
		alias
			"return CONFIG_TYPE_GROUP"
		end

	c_config_type_int: INTEGER
			-- #define CONFIG_TYPE_INT 2
		external
			"C inline use %"libconfig.h%""
		alias
			"return CONFIG_TYPE_INT"
		end

	c_config_type_int64: INTEGER
			-- #define CONFIG_TYPE_INT64 2
		external
			"C inline use %"libconfig.h%""
		alias
			"return CONFIG_TYPE_INT64"
		end

	c_config_type_float: INTEGER
			-- #define CONFIG_TYPE_FLOAT 4
		external
			"C inline use %"libconfig.h%""
		alias
			"return CONFIG_TYPE_FLOAT"
		end

	c_config_type_string: INTEGER
			-- #define CONFIG_TYPE_STRING 5
		external
			"C inline use %"libconfig.h%""
		alias
			"return CONFIG_TYPE_STRING"
		end

	c_config_type_bool: INTEGER
			-- #define CONFIG_TYPE_BOOL 6
		external
			"C inline use %"libconfig.h%""
		alias
			"return CONFIG_TYPE_BOOL"
		end

	c_config_type_array: INTEGER
			-- #define CONFIG_TYPE_ARRAY 7
		external
			"C inline use %"libconfig.h%""
		alias
			"return CONFIG_TYPE_ARRAY"
		end

	c_config_type_list: INTEGER
			-- #define CONFIG_TYPE_LIST 8
		external
			"C inline use %"libconfig.h%""
		alias
			"return CONFIG_TYPE_LIST"
		end

feature -- config format constants

	c_config_format_default: INTEGER
			-- #define CONFIG_FORMAT_DEFAULT 0
		external
			"C inline use %"libconfig.h%""
		alias
			"return CONFIG_FORMAT_DEFAULT"
		end

	c_config_format_hex: INTEGER
			-- #define CONFIG_FORMAT_HEX 1
		external
			"C inline use %"libconfig.h%""
		alias
			"return CONFIG_FORMAT_HEX"
		end

feature -- Config options constants

	c_config_option_autoconvert: INTEGER
			-- #define CONFIG_OPTION_AUTOCONVERT 0x01
		external
			"C inline use %"libconfig.h%""
		alias
			"return CONFIG_OPTION_AUTOCONVERT"
		end

	c_config_option_semicolon_separators: INTEGER
			-- #define CONFIG_OPTION_SEMICOLON_SEPARATORS 0x02
		external
			"C inline use %"libconfig.h%""
		alias
			"return CONFIG_OPTION_SEMICOLON_SEPARATORS"
		end

	c_config_option_colon_assignment_for_groups: INTEGER
			-- #define CONFIG_OPTION_COLON_ASSIGNMENT_FOR_GROUPS 0x04
		external
			"C inline use %"libconfig.h%""
		alias
			"return CONFIG_OPTION_COLON_ASSIGNMENT_FOR_GROUPS"
		end

	c_config_option_colon_assignment_for_non_groups: INTEGER
			-- #define CONFIG_OPTION_COLON_ASSIGNMENT_FOR_NON_GROUPS 0x08
		external
			"C inline use %"libconfig.h%""
		alias
			"return CONFIG_OPTION_COLON_ASSIGNMENT_FOR_NON_GROUPS"
		end

	c_config_option_open_brace_on_separate_line: INTEGER
			-- #define CONFIG_OPTION_OPEN_BRACE_ON_SEPARATE_LINE 0x10
		external
			"C inline use %"libconfig.h%""
		alias
			"return CONFIG_OPTION_COLON_ASSIGNMENT_FOR_NON_GROUPS"
		end

feature -- Bool values redefinition

	c_config_true: INTEGER
			-- #define CONFIG_TRUE (1)
		external
			"C inline use %"libconfig.h%""
		alias
			"return CONFIG_TRUE"
		end

	c_config_false: INTEGER
			-- #define CONFIG_FALSE (0)
		external
			"C inline use %"libconfig.h%""
		alias
			"return CONFIG_FALSE"
		end

end
