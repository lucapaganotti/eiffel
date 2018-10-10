note
	description: "Summary description for {GEOS_EXTERNALS_DEFINES}."
	author: "Luca Paganotti - luca <dot> paganotti <at> gmail <dot> com"
	date: "$Date$"
	revision: "$Revision$"

class
	GEOS_EXTERNALS_DEFINES

feature -- geos define defines

	c_geos_version_major: INTEGER
			-- #define GEOS_VERSION_MAJOR 3
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOS_VERSION_MAJOR"
		end

	c_geos_version_minor: INTEGER
			-- #define GEOS_VERSION_MINOR 5
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOS_VERSION_MINOR"
		end

	c_geos_version_patch: INTEGER
			-- #define GEOS_VERSION_PATCH 1
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOS_VERSION_PATCH"
		end

	c_geos_version: POINTER
			-- #define GEOS_VERSION "3.5.1"
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOS_VERSION"
		end

	c_geos_version_function: POINTER
			--  const char GEOS_DLL *GEOSversion()
		external
			"C inline use %"geos_c.h%""
		alias
			"return (char*)GEOSversion()"
		end

	c_geos_capi_version_major: INTEGER
			-- #define GEOS_CAPI_VERSION_MAJOR 1
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOS_CAPI_VERSION_MAJOR"
		end

	c_geos_capi_version_minor: INTEGER
			-- #define GEOS_CAPI_VERSION_MINOR 9
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOS_CAPI_VERSION_MINOR"
		end

	c_geos_capi_version_patch: INTEGER
			-- #define GEOS_CAPI_VERSION_PATCH 1
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOS_CAPI_VERSION_PATCH"
		end

	c_geos_capi_version: POINTER
			-- #define GEOS_CAPI_VERSION "3.5.1-CAPI-1.9.1"
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOS_CAPI_VERSION"
		end

end
