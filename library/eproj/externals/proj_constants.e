note
	description: "Summary description for {PROJ_CONSTANTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROJ_CONSTANTS

feature -- Access

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature -- Constants

	pj_version: INTEGER
			--
		external
			"C inline use %"proj_api.h%""
		alias
			"return PJ_VERSION"
		end

	pj_locale_safe: INTEGER
			--
		external
			"C inline use %"proj_api.h%""
		alias
			"return PJ_LOCALE_SAFE"
		end

	pj_rad_to_deg: DOUBLE
			--
		external
			"C inline use %"proj_api.h%""
		alias
			"return RAD_TO_DEG"
		end

	pj_deg_to_rad: DOUBLE
			--
		external
			"C inline use %"proj_api.h%""
		alias
			"return DEG_TO_RAD"
		end

	pj_release_internal: POINTER
			--
		external
			"C inline use %"proj_api.h%""
		alias
			"return (char*)pj_release"
		end

	pj_release: STRING
			--
		do
			create Result.make_from_c (pj_release_internal)
		end

	pj_errno: INTEGER
			--
		external
			"C inline use %"proj_api.h%""
		alias
			"return pj_errno"
		end

	pj_log_none: INTEGER
			-- #define PJ_LOG_NONE 0
		external
			"C inline use %"proj_api.h%""
		alias
			"return PJ_LOG_NONE"
		end

	pj_log_error: INTEGER
			-- #define PJ_LOG_ERROR 1
		external
			"C inline use %"proj_api.h%""
		alias
			"return PJ_LOG_ERROR"
		end

	pj_log_debug_major: INTEGER
			-- #define PJ_LOG_DEBUG_MAJOR 2
		external
			"C inline use %"proj_api.h%""
		alias
			"return PJ_LOG_DEBUG_MAJOR"
		end

	pj_log_debug_minor: INTEGER
			-- #define PJ_LOG_DEBUG_MINOR 3
		external
			"C inline use %"proj_api.h%""
		alias
			"return PJ_LOG_DEBUG_MINOR"
		end


feature {NONE} -- Implementation


invariant
	invariant_clause: True -- Your invariant here

end
