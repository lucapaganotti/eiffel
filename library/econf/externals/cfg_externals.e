note
	description: "Summary description for {CFG_EXTERNALS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CFG_EXTERNALS

feature -- Initialization and deinitialization

	c_config_t_size: INTEGER
			-- sizeof(config_t)
		external
			"C inline use %"libconfig.h%""
		alias
			"return sizeof(struct config_t)"
		end

	c_config_init (handle: POINTER)
			-- void config_init(config_t *config)
		external
			"C inline use %"libconfig.h%""
		alias
			"config_init($handle)"
		end

	c_config_destroy (handle: POINTER)
			-- void config_destroy(config_t *config)
		external
			"C inline use %"libconfig.h%""
		alias
			"config_destroy($handle)"
		end

feature -- File I/O

	c_config_read (handle, stream: POINTER): INTEGER
			-- int config_read(config_t *config, FILE *stream)
		require
			handle_attached: attached handle
			stream_attached: attached stream
		external
			"C inline use %"libconfig.h%""
		alias
			"return config_read($handle, $stream)"
		end

	c_config_write (handle, stream: POINTER)
			-- int config_write(const config_t *config, FILE *stream)
		require
			handle_attached: attached handle
			stream_attached: attached stream
		external
			"C inline use %"libconfig.h%""
		alias
			"return config_write($handle, $stream)"
		end

	c_config_read_file (handle, filename: POINTER): INTEGER
			-- int config_read_file(config_t *config, const char *filename)
		require
			handle_attached: attached handle
			flename_attached: attached filename
		external
			"C inline use %"libconfig.h%""
		alias
			"return config_read_file($handle, $filename)"
		end

	c_config_write_file (handle, filename: POINTER): INTEGER
			-- int config_write_file(config_t *config, const char *filename)
		require
			handle_attached: attached handle
			flename_attached: attached filename
		external
			"C inline use %"libconfig.h%""
		alias
			"return config_write_file($handle, $filename)"
		end

feature -- Config formats

	c_config_set_default_format (handle: POINTER; format: INTEGER)
			-- void config_set_default_format(config_t *config, short format)
		require
			handle_attached: attached handle
		external
			"C inline use %"libconfig.h%""
		alias
			"config_set_default_format((config_t*)$handle, $format)"
		end

feature -- Config options

	c_config_set_options (handle: POINTER; options: INTEGER)
			-- void config_set_options(config_t *config, int options)
		require
			handle_attached: attached handle
		external
			"C inline use %"libconfig.h%""
		alias
			"config_set_options($handle, $options)"
		end

	c_config_get_options (handle: POINTER): INTEGER
			-- int config_get_options(const config_t *config)
		require
			handle_attached: attached handle
		external
			"C inline use %"libconfig.h%""
		alias
			"return config_get_options($handle)"
		end

	c_config_set_auto_convert (handle: POINTER; flag: INTEGER)
			-- void config_set_auto_convert(config_t *config, int flag)
		require
			handle_attached: attached handle
		external
			"C inline use %"libconfig.h%""
		alias
			"config_set_auto_convert($handle, $flag)"
		end

	c_config_get_auto_convert (handle: POINTER): INTEGER
			-- int config_get_auto_convert(const config_t *config)
		require
			handle_attached: attached handle
		external
			"C inline use %"libconfig.h%""
		alias
			"return config_get_auto_convert($handle)"
		end

	c_config_set_include_dir (handle, include_dir: POINTER)
			-- void config_set_include_dir(config_t *config, const char *include_dir)
		require
			handle_attached: attached handle
			dir_attached: attached include_dir
		external
			"C inline use %"libconfig.h%""
		alias
			"config_set_include_dir($handle, $include_dir)"
		end

feature -- Basic operations

	c_config_read_string (handle, str: POINTER): INTEGER
			-- int config_read_string(config_t *config, const char *str)
		require
			handle_attached: attached handle
			string_attached: attached str
		external
			"C inline use %"libconfig.h%""
		alias
			"return config_read_string($handle, $str)"
		end

feature -- Settings

	c_config_setting_get_int (setting: POINTER): INTEGER
			-- int config_setting_get_int(const config_setting_t *setting)
		require
			setting_attached: attached setting
		external
			"C inline use %"libconfig.h%""
		alias
			"return config_setting_get_int($setting)"
		end

	c_config_setting_get_int64 (setting: POINTER): INTEGER_64
			-- long long config_setting_get_int64(const config_setting_t *setting)
		require
			setting_attached: attached setting
		external
			"C inline use %"libconfig.h%""
		alias
			"return config_setting_get_int64($setting)"
		end

	c_config_setting_get_float (setting: POINTER): DOUBLE
			-- double config_setting_get_float(const config_setting_t *setting)
		require
			setting_attached: attached setting
		external
			"C inline use %"libconfig.h%""
		alias
			"return config_setting_get_float($setting)"
		end

	c_config_setting_get_bool (setting: POINTER): BOOLEAN
			-- int config_setting_get_bool(const config_setting_t *setting)
		require
			setting_attached: attached setting
		external
			"C inline use %"libconfig.h%""
		alias
			"return config_setting_get_bool($setting)"
		end

	c_config_setting_get_string (setting: POINTER): POINTER
			-- const char *config_setting_get_string(const config_setting_t *setting)
		require
			setting_attached: attached setting
		external
			"C inline use %"libconfig.h%""
		alias
			"return (char*)config_setting_get_string($setting)"
		end

	c_config_setting_set_int (setting: POINTER; value: INTEGER): INTEGER
			-- int config_setting_set_int(config_setting_t *setting, int value)
		require
			setting_attached: attached setting
		external
			"C inline use %"libconfig.h%""
		alias
			"return config_setting_set_int($setting, $value)"
		end

	c_config_setting_set_int64 (setting: POINTER; value: INTEGER_64): INTEGER
			-- int config_setting_set_int64(config_setting_t *setting, long long value)
		require
			setting_attached: attached setting
		external
			"C inline use %"libconfig.h%""
		alias
			"return config_setting_set_int64($setting, $value)"
		end

	c_config_setting_set_float (setting: POINTER; value: DOUBLE): INTEGER
			-- int config_setting_set_float(config_setting_t *setting, double value)
		require
			setting_attached: attached setting
		external
			"C inline use %"libconfig.h%""
		alias
			"return config_setting_set_float($setting, $value)"
		end

	c_config_setting_set_bool (setting: POINTER; value: INTEGER): INTEGER
			-- int config_setting_set_bool(config_setting_t *setting, int value)
		require
			setting_attached: attached setting
		external
			"C inline use %"libconfig.h%""
		alias
			"return config_setting_set_bool($setting, $value)"
		end

	c_config_setting_set_string (setting, value: POINTER): INTEGER
			-- int config_setting_set_string(config_setting_t *setting, const char *value)
		require
			setting_attached: attached setting
			value_attached: attached value
		external
			"C inline use %"libconfig.h%""
		alias
			"return config_setting_set_string($setting, $value)"
		end

	c_config_setting_lookup_int (setting, name, value: POINTER): INTEGER
			-- int config_setting_lookup_int(const config_setting_t *setting, const char *name, int *value)
		require
			setting_attached: attached setting
			name_attached: attached name
			value_attached: attached value
		external
			"C inline use %"libconfig.h%""
		alias
			"return config_setting_lookup_int($setting, $name, $value)"
		end

	c_config_setting_lookup_int64 (setting, name, value: POINTER): INTEGER
			-- int config_setting_lookup_int64(const config_setting_t *setting, const char *name, long long *value)
		require
			setting_attached: attached setting
			name_attached: attached name
			value_attached: attached value
		external
			"C inline use %"libconfig.h%""
		alias
			"return config_setting_lookup_int64($setting, $name, $value)"
		end

	c_config_setting_lookup_float (setting, name, value: POINTER): INTEGER
			-- int config_setting_lookup_float(const config_setting_t *setting, const char *name, double *value)
		require
			setting_attached: attached setting
			name_attached: attached name
			value_attached: attached value
		external
			"C inline use %"libconfig.h%""
		alias
			"return config_setting_lookup_float($setting, $name, $value)"
		end

	c_config_setting_lookup_bool (setting, name, value: POINTER): INTEGER
			-- int config_setting_lookup_bool(const config_setting_t *setting, const char *name, int *value)
		require
			setting_attached: attached setting
			name_attached: attached name
			value_attached: attached value
		external
			"C inline use %"libconfig.h%""
		alias
			"return config_setting_lookup_bool($setting, $name, $value)"
		end

	c_config_setting_lookup_string (setting, name, value: POINTER): INTEGER
			-- int config_setting_lookup_string(const config_setting_t *setting, const char *name, const char **value)
		require
			setting_attached: attached setting
			name_attached: attached name
			value_attached: attached value
		external
			"C inline use %"libconfig.h%""
		alias
			"return config_setting_lookup_string($setting, $name, $value)"
		end

feature -- Callbacks

	c_config_set_destructor (handle, destructor: POINTER)
			-- void config_set_destructor(config_t *config, void (*destructor)(void *)
		require
			handle_attached: attached handle
			dtor_attached: attached destructor
		external
			"C inline use %"libconfig.h%""
		alias
			"config_set_destructor($handle, $destructor)"
		end


end
