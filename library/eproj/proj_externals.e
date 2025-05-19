note
	description: "Summary description for {PROJ_EXTERNALS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROJ_EXTERNALS

inherit
	PROJ_CONSTANTS

feature -- Main externals

	c_pj_init (argc: INTEGER; args: POINTER): POINTER
			-- projPJ pj_init(int, char **)
		external
			"C inline use %"proj_api.h%""
		alias
			"pj_init($argc, $args)"
		end

	c_pj_init_plus (pj_desc: POINTER): POINTER
			-- projPJ pj_init_plus(const char *)
		external
			"C inline use %"proj_api.h%""
		alias
			"pj_init_plus($pj_desc)"
		end

	c_pj_free (pj: POINTER)
			-- void pj_free(projPJ)
		external
			"C inline use %"proj_api.h%""
		alias
			"pj_free($pj)"
		end

	c_pj_transform (src, dst: POINTER; cnt: INTEGER; offset: INTEGER; x, y, z: POINTER): INTEGER
			-- int pj_transform( projPJ src, projPJ dst, long point_count, int point_offset, double *x, double *y, double *z )
		external
			"C inline use %"proj_api.h%""
		alias
			"return pj_transform($src, $dst, $cnt, $offset, $x, $y, $z)"
		end

	c_pj_datum_transform (src, dst: POINTER; cnt: INTEGER; offset: INTEGER; x, y, z: POINTER): INTEGER
			-- int pj_datum_transform( projPJ src, projPJ dst, long point_count, int point_offset, double *x, double *y, double *z )
		external
			"C inline use %"proj_api.h%""
		alias
			"return pj_datum_transform($src, $dst, $cnt, $offset, $x, $y, $z)"
		end

	c_pj_geocentric_to_geodetic (a, es: DOUBLE; cnt: INTEGER; offset: INTEGER; x, y, z: POINTER): INTEGER
			-- int pj_geocentric_to_geodetic( double a, double es, long point_count, int point_offset, double *x, double *y, double *z )
		external
			"C inline use %"proj_api.h%""
		alias
			"return pj_geocentric_to_geodetic($a, $es, $cnt, $offset, $x, $y, $z)"
		end

	c_pj_geodetic_to_geocentric (a, es: DOUBLE; cnt: INTEGER; offset: INTEGER; x, y, z: POINTER): INTEGER
			-- int pj_geodetic_to_geocentric( double a, double es, long point_count, int point_offset, double *x, double *y, double *z )
		external
			"C inline use %"proj_api.h%""
		alias
			"return pj_geodetic_to_geocentric($a, $es, $cnt, $offset, $x, $y, $z)"
		end

	c_pj_compare_datums (srcdefn, dstdefn: POINTER): INTEGER
			-- int pj_compare_datums(projPJ srcdefn, projPJ dstdefn)
		external
			"C inline use %"proj_api.h%""
		alias
			"return pj_compare_datums($srcdefn, $dstdefn)"
		end

feature -- Context externals

	c_pj_get_default_ctx: POINTER
			-- projCtx pj_get_default_ctx(void)
		external
			"C inline use %"proj_api.h%""
		alias
			"return pj_get_default_ctx()"
		end

	c_pj_get_ctx (pj: POINTER): POINTER
			-- projCtx pj_get_ctx(projPJ)
		external
			"C inline use %"proj_api.h%""
		alias
			"return pj_get_ctx($pj)"
		end

	c_pj_set_ctx (pj, ctx: POINTER)
			-- void pj_set_ctx(projPJ, projCtx)
		external
			"C inline use %"proj_api.h%""
		alias
			"pj_set_ctx($pj, $ctx)"
		end

	c_pj_ctx_alloc: POINTER
			-- projCtx pj_ctx_alloc(void)
		external
			"C inline use %"proj_api.h%""
		alias
			"return pj_ctx_alloc()"
		end

	c_pj_ctx_free (ctx: POINTER)
			-- void pj_ctx_free(projCtx)
		external
			"C inline use %"proj_api.h%""
		alias
			"pj_ctx_free($ctx)"
		end

	c_pj_ctx_get_errno (ctx: POINTER): INTEGER
			-- int pj_ctx_get_errno(projCtx)
		external
			"C inline use %"proj_api.h%""
		alias
			"return pj_ctx_get_errno($ctx)"
		end

	c_pj_ctx_set_errno (ctx: POINTER; errno: INTEGER)
			--void pj_ctx_set_errno(projCtx, int)
		external
			"C inline use %"proj_api.h%""
		alias
			"pj_ctx_set_errno($ctx, $errno)"
		end

	c_pj_ctx_set_debug (ctx: POINTER; level: INTEGER)
			-- void pj_ctx_set_debug(projCtx, int)
		external
			"C inline use %"proj_api.h%""
		alias
			"pj_ctx_set_debug($ctx, $level)"
		end

	c_pj_ctx_set_app_data (ctx, data: POINTER)
			-- void pj_ctx_set_app_data(projCtx, void *)
		external
			"C inline use %"proj_api.h%""
		alias
			"pj_ctx_set_app_data($ctx, $data)"
		end

	c_pj_ctx_get_app_data (ctx: POINTER): POINTER
			-- void *pj_ctx_get_app_data(projCtx)
		external
			"C inline use %"proj_api.h%""
		alias
			"return pj_ctx_get_app_data($ctx)"
		end

	c_pj_ctx_get_fileapi (ctx: POINTER): POINTER
			-- projFileAPI *pj_ctx_get_fileapi(projCtx)
		external
			"C inline use %"proj_api.h%""
		alias
			"return pj_ctx_get_fileapi($ctx)"
		end

	c_pj_ctx_set_fileapi (ctx, fileapi: POINTER)
			-- void pj_ctx_set_fileapi(projCtx, projFileAPI*)
		external
			"C inline use %"proj_api.h%""
		alias
			"pj_ctx_set_fileapi($ctx, $fileapi)"
		end
end
