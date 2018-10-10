note
	description: "[
			Summary description for {GEOS_EXTERNALS_R}.
			
			Please refer to geos_c.h for details.
			
			These class defines the whole 'r' interface plus the 'non r' one for
			libgeos_c v. 3.5.1, unfortunately nont the latest, but the one I have
			on my debian box at the time of writing.
			If, by chance, you define GEOS_USE_ONLY_R_API macro you should exclude
			{GEOS_EXTERNALS_NON_R} class from system.
			
			TODO: probably to be splitted in two or more classes
		]"
	author: "Luca Paganotti - luca <dot> paganotti <at> gmail <dot> com"
	date: "$Date$"
	revision: "$Revision$"

class
	GEOS_EXTERNALS_R

inherit
	GEOS_GEOM_TYPES_CONSTANTS
	GEOS_BYTE_ORDERS_CONSTANTS
	GEOS_BUFFER_CAP_STYLES_CONSTANTS
	GEOS_BUFFER_JOIN_STYLES_CONSTANTS
	GEOS_BINARY_PREDICATES_RESULTS_CONSTANTS
	GEOS_RELATE_BOUNDARY_NODE_RULES_CONSTANTS
	GEOS_VALID_FLAGS_CONSTANTS
	GEOS_EXTERNALS_DEFINES

feature -- Callbacks management

	c_geos_interrupt_register_callback (cb: POINTER): POINTER
			-- GEOSInterruptCallback GEOS_DLL *GEOS_interruptRegisterCallback(GEOSInterruptCallback* cb)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOS_interruptRegisterCallback($cb)"
		end

	c_geos_interrupt_request
			-- void GEOS_DLL GEOS_interruptRequest()
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOS_interruptRequest()"
		end

	c_geos_interrupt_cancel
			-- void GEOS_DLL GEOS_interruptCancel()
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOS_interruptCancel()"
		end

feature -- Setup and closing

	c_geos_init_r: POINTER
			-- GEOSContextHandle_t GEOS_DLL GEOS_init_r()
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOS_init_r()"
		end

	c_geos_finish_r (handle: POINTER)
			-- void GEOS_DLL GEOS_finish_r(GEOSContextHandle_t handle)
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOS_finish_r($handle)"
		end

feature -- Message handlers

	c_geos_default_message_handler (message, userdata: POINTER)
			-- void (*GEOSMessageHandler_r)(const char *message, void *userdata)
		local
			m: STRING
		do
			create m.make_from_c (message)
			io.put_string (m)
		end

	c_geos_context_set_notice_handler (handle, handler: POINTER): POINTER
			-- GEOSMessageHandler GEOS_DLL GEOSContext_setNoticeHandler_r(GEOSContextHandle_t extHandle, GEOSMessageHandler nf)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSContext_setNoticeHandler_r($handle, $handler)"
		end

	c_geos_context_set_error_handler (handle, handler: POINTER): POINTER
			-- GEOSMessageHandler GEOS_DLL GEOSContext_setErrorHandler_r(GEOSContextHandle_t extHandle, GEOSMessageHandler ef)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSContext_setErrorHandler_r($handle, $handler)"
		end

feature -- IO

	c_geos_get_wkb_output_dims_r (handle: POINTER): INTEGER
			-- int GEOS_DLL GEOS_getWKBOutputDims_r(GEOSContextHandle_t handle)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOS_getWKBOutputDims_r($handle)"
		end

	c_geos_set_wkb_output_dims_r (handle: POINTER; new_dims: INTEGER): INTEGER
			-- int GEOS_DLL GEOS_setWKBOutputDims_r(GEOSContextHandle_t handle, int newDims)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOS_setWKBOutputDims_r($handle, $new_dims)"
		end

	c_geos_get_wkb_byte_order (handle: POINTER): INTEGER
			-- int GEOS_DLL GEOS_getWKBByteOrder_r(GEOSContextHandle_t handle)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOS_getWKBByteOrder_r($handle)"
		end

	c_geos_set_wkb_byte_order (handle: POINTER; byte_order: INTEGER): INTEGER
			-- int GEOS_DLL GEOS_setWKBByteOrder_r(GEOSContextHandle_t handle, int byteOrder)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOS_setWKBByteOrder_r($handle, $byte_order)"
		end

	c_geos_geom_from_wkb_buf_r (handle, wkb: POINTER; size: INTEGER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSGeomFromWKB_buf_r(GEOSContextHandle_t handle, const unsigned char *wkb, size_t size)
		obsolete
			"These functions are DEPRECATED.  Please use the new Reader and writer APIS!"
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeomFromWKB_buf_r($handle, $wkb, $size)"
		end

	c_geos_geom_to_wkb_buf_r (handle, g, size: POINTER): POINTER
			-- unsigned char GEOS_DLL *GEOSGeomToWKB_buf_r(GEOSContextHandle_t handle, const GEOSGeometry* g, size_t *size)
		obsolete
			"These functions are DEPRECATED.  Please use the new Reader and writer APIS!"
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeomToWKB_buf_r($handle, $g, $size)"
		end

	c_geos_geom_from_hex_buf_r (handle, hex: POINTER; size: INTEGER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSGeomFromHEX_buf_r(GEOSContextHandle_t handle, const unsigned char *hex, size_t size)
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSGeomFromHEX_buf_r($handle, $hex, $size)"
		end

	c_geos_geom_to_hex_buf_r (handle, g, size: POINTER): POINTER
			--unsigned char GEOS_DLL *GEOSGeomToHEX_buf_r(GEOSContextHandle_t handle, const GEOSGeometry* g, size_t *size)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeomToHEX_buf_r($handle, $g, $size)"
		end

feature -- Coordinate sequences

	c_geos_coord_seq_create_r(handle: POINTER; size, dims: NATURAL): POINTER
			-- GEOSCoordSequence GEOS_DLL *GEOSCoordSeq_create_r(GEOSContextHandle_t handle, unsigned int size, unsigned int dims)
			-- Create a Coordinate sequence with ``size'' coordinates of `dims' dimensions. Return NULL on exception.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSCoordSeq_create_r($handle, $size, $dims)"
		end

	c_geos_coord_seq_clone_r (handle, s: POINTER): POINTER
			-- GEOSCoordSequence GEOS_DLL *GEOSCoordSeq_clone_r(GEOSContextHandle_t handle, const GEOSCoordSequence* s)
			-- Clone a Coordinate Sequence. Return NULL on exception.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSCoordSeq_clone_r($handle, $s)"
		end

	c_geos_coord_seq_destroy_r (handle, s: POINTER)
			-- void GEOS_DLL GEOSCoordSeq_destroy_r(GEOSContextHandle_t handle, GEOSCoordSequence* s)
			-- Destroy a Coordinate Sequence.
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSCoordSeq_destroy_r($handle, $s)"
		end

	c_geos_coord_seq_set_x_r (handle, s: POINTER; idx: NATURAL; val: DOUBLE): INTEGER
			-- int GEOS_DLL GEOSCoordSeq_setX_r(GEOSContextHandle_t handle, GEOSCoordSequence* s, unsigned int idx, double val)
			-- Set ordinate values in a Coordinate Sequence. Return 0 on exception.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSCoordSeq_setX_r($handle, $s, $idx, $val)"
		end

	c_geos_coord_seq_set_y_r (handle, s: POINTER; idx: NATURAL; val: DOUBLE): INTEGER
			-- int GEOS_DLL GEOSCoordSeq_setY_r(GEOSContextHandle_t handle, GEOSCoordSequence* s, unsigned int idx, double val)
			-- Set ordinate values in a Coordinate Sequence. Return 0 on exception.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSCoordSeq_setY_r($handle, $s, $idx, $val)"
		end

	c_geos_coord_seq_set_z_r (handle, s: POINTER; idx: NATURAL; val: DOUBLE): INTEGER
			-- int GEOS_DLL GEOSCoordSeq_setZ_r(GEOSContextHandle_t handle, GEOSCoordSequence* s, unsigned int idx, double val)
			-- Set ordinate values in a Coordinate Sequence. Return 0 on exception.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSCoordSeq_setZ_r($handle, $s, $idx, $val)"
		end

	c_geos_coord_seq_set_ordinate_r (handle, s: POINTER; idx, dim: NATURAL; val: DOUBLE): INTEGER
			-- int GEOS_DLL GEOSCoordSeq_setOrdinate_r(GEOSContextHandle_t handle, GEOSCoordSequence* s, unsigned int idx, unsigned int dim, double val)
			-- Set ordinate values in a Coordinate Sequence. Return 0 on exception.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSCoordSeq_setOrdinate_r($handle, $s, $idx, $dim, $val)"
		end

	c_geos_coord_seq_get_x_r (handle, s: POINTER; idx: NATURAL; val: POINTER): INTEGER
			-- int GEOS_DLL GEOSCoordSeq_getX_r(GEOSContextHandle_t handle, const GEOSCoordSequence* s, unsigned int idx, double *val)
			-- Get ordinate values from a Coordinate Sequence. Return 0 on exception.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSCoordSeq_getX_r($handle, $s, $idx, $val)"
		end

	c_geos_coord_seq_get_y_r (handle, s: POINTER; idx: NATURAL; val: POINTER): INTEGER
			-- int GEOS_DLL GEOSCoordSeq_getY_r(GEOSContextHandle_t handle, const GEOSCoordSequence* s, unsigned int idx, double *val)
			-- Get ordinate values from a Coordinate Sequence. Return 0 on exception.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSCoordSeq_getY_r($handle, $s, $idx, $val)"
		end

	c_geos_coord_seq_get_z_r (handle, s: POINTER; idx: NATURAL; val: POINTER): INTEGER
			-- int GEOS_DLL GEOSCoordSeq_getZ_r(GEOSContextHandle_t handle, const GEOSCoordSequence* s, unsigned int idx, double *val)
			-- Get ordinate values from a Coordinate Sequence. Return 0 on exception.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSCoordSeq_getZ_r($handle, $s, $idx, $val)"
		end

	c_geos_coord_seq_get_ordinate_r (handle, s: POINTER; idx, dim: NATURAL; val: POINTER): INTEGER
			-- int GEOS_DLL GEOSCoordSeq_getOrdinate_r(GEOSContextHandle_t handle, const GEOSCoordSequence* s, unsigned int idx, unsigned int dim, double *val)
			-- Get ordinate values from a Coordinate Sequence. Return 0 on exception.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSCoordSeq_getOrdinate_r($handle, $s, $idx, $dim, $val)"
		end

feature -- Linear referencing functions

	c_geos_project_r (handle, g, p: POINTER): DOUBLE
			-- double GEOS_DLL GEOSProject_r(GEOSContextHandle_t handle, const GEOSGeometry *g, const GEOSGeometry *p)
			-- Return distance of point 'p' projected on 'g' from origin of 'g'. Geometry 'g' must be a lineal geometry
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSProject_r($handle, $g, $p)"
		end

	c_geos_interpolate_r (handle, g: POINTER; d: DOUBLE): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSInterpolate_r(GEOSContextHandle_t handle, const GEOSGeometry *g, double d)
			-- Return closest point to given distance within geometry. Geometry must be a LineString.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSInterpolate_r($handle, $g, $d)"
		end

	c_geos_project_normalized_r (handle, g, p: POINTER): DOUBLE
			-- double GEOS_DLL GEOSProjectNormalized_r(GEOSContextHandle_t handle, const GEOSGeometry *g, const GEOSGeometry *p)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSProjectNormalized_r($handle, $g, $p)"
		end

	c_geos_interpolate_normalized_r (handle, g: POINTER; d: DOUBLE): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSInterpolateNormalized_r(GEOSContextHandle_t handle, const GEOSGeometry *g, double d)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSInterpolateNormalized_r($handle, $g, $d)"
		end

feature -- Buffer related functions

	c_geos_buffer_r (handle, g: POINTER; width: DOUBLE; quadsegs: INTEGER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSBuffer_r(GEOSContextHandle_t handle, const GEOSGeometry* g, double width, int quadsegs)
			-- Return NULL on exception
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSBuffer_r($handle, $g, $width, $quadsegs)"
		end

	c_geos_buffer_params_create_r (handle: POINTER): POINTER
			-- GEOSBufferParams GEOS_DLL *GEOSBufferParams_create_r(GEOSContextHandle_t handle)
			-- return 0 on exception
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSBufferParams_create_r($handle)"
		end

	c_geos_buffer_params_destroy_r (handle, parms: POINTER)
			-- void GEOS_DLL GEOSBufferParams_destroy_r(GEOSContextHandle_t handle, GEOSBufferParams* parms)
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSBufferParams_destroy_r($handle, $parms)"
		end

	c_geos_buffer_params_set_end_cap_style_r (handle, p: POINTER; style: INTEGER): INTEGER
			-- int GEOS_DLL GEOSBufferParams_setEndCapStyle_r(GEOSContextHandle_t handle, GEOSBufferParams* p, int style)
			-- return 0 on exception
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSBufferParams_setEndCapStyle_r($handle, $p, $style)"
		end

	c_geos_buffer_params_set_join_style_r (handle, p: POINTER; join_style: INTEGER): INTEGER
			-- int GEOS_DLL GEOSBufferParams_setJoinStyle_r(GEOSContextHandle_t handle, GEOSBufferParams* p, int joinStyle)
			-- return 0 on exception
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSBufferParams_setJoinStyle_r($handle, $p, $join_style)"
		end

	c_geos_buffer_params_set_mitre_limit_r (handle, p: POINTER; mitre_limit: DOUBLE): INTEGER
			-- int GEOS_DLL GEOSBufferParams_setMitreLimit_r(GEOSContextHandle_t handle, GEOSBufferParams* p, double mitreLimit)
			-- return 0 on exception
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSBufferParams_setMitreLimit_r($handle, $p, $mitre_limit)"
		end

	c_geos_buffer_params_set_quadrant_segments_r (handle, p: POINTER; quad_segs: INTEGER): INTEGER
			-- int GEOS_DLL GEOSBufferParams_setQuadrantSegments_r(GEOSContextHandle_t handle, GEOSBufferParams* p, int quadSegs)
			-- return 0 on exception
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSBufferParams_setQuadrantSegments_r($handle, $p, $quad_segs)"
		end

	c_geos_buffer_with_params_r (handle, g, p: POINTER; width: DOUBLE): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSBufferWithParams_r(GEOSContextHandle_t handle, const GEOSGeometry* g, const GEOSBufferParams* p, double width)
			-- return NULL on exception
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSBufferWithParams_r($handle, $g, $p, $width)"
		end

	c_geos_buffer_with_style_r (handle, g: POINTER; width: DOUBLE; quad_segs, end_cap_style, join_style: INTEGER; mitre_limit: DOUBLE): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSBufferWithStyle_r(GEOSContextHandle_t handle, const GEOSGeometry* g, double width, int quadsegs, int endCapStyle, int joinStyle, double mitreLimit)
			-- return NULL on exception
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSBufferWithStyle_r($handle, $g, $width, $quad_segs, $end_cap_style, $join_style, $mitre_limit)"
		end

	c_geos_single_sided_buffer_r (handle, g: POINTER; width:DOUBLE; quad_segs, join_style: INTEGER; mitre_limit: DOUBLE; left_side: INTEGER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSSingleSidedBuffer_r(GEOSContextHandle_t handle, const GEOSGeometry* g, double width, int quadsegs, int joinStyle, double mitreLimit, int leftSide)
			-- return NULL on exception. Only LINESTRINGs are accepted.
		obsolete
			"deprecated in 3.3.0: use GEOSOffsetCurve instead"
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSSingleSidedBuffer_r($handle, $g, $width, $quad_segs, $join_style, $mitre_limit, $left_side)"
		end

	c_geos_offset_curve_r (handle, g: POINTER; width: DOUBLE; quad_segs, join_style: INTEGER; mitre_limit: DOUBLE): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSOffsetCurve_r(GEOSContextHandle_t handle, const GEOSGeometry* g, double width, int quadsegs, int joinStyle, double mitreLimit)
			-- Only LINESTRINGs are accepted.
			-- `width' : offset distance.
			--           negative for right side offset.
			--           positive for left side offset.
			-- return NULL on exception.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSOffsetCurve_r($handle, $g, $width, $quad_segs, $join_style, $mitre_limit)"
		end

feature -- Geometry constructors

	-- GEOSCoordSequence* arguments will become ownership of the returned object.
	-- All functions return NULL on exception.

	c_geos_geom_create_point (handle, s: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSGeom_createPoint_r(GEOSContextHandle_t handle, GEOSCoordSequence* s)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeom_createPoint_r($handle, $s)"
		end

	c_geos_geom_create_point_r (handle: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSGeom_createEmptyPoint_r(GEOSContextHandle_t handle)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeom_createEmptyPoint_r($handle)"
		end

	c_geos_geom_create_linear_ring_r (handle, s: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSGeom_createLinearRing_r(GEOSContextHandle_t handle, GEOSCoordSequence* s)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeom_createLinearRing_r($handle, $s)"
		end

	c_geos_geom_create_line_string_r (handle, s: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSGeom_createLineString_r(GEOSContextHandle_t handle, GEOSCoordSequence* s)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeom_createLineString_r($handle, $s)"
		end

	c_geos_geom_create_empty_line_string (handle: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSGeom_createEmptyLineString_r(GEOSContextHandle_t handle)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeom_createEmptyLineString_r($handle)"
		end

	-- Second argument is an array of GEOSGeometry* objects.
	-- The caller remains owner of the array, but pointed-to
	-- objects become ownership of the returned GEOSGeometry.

	c_geos_geom_create_empty_polygon_r (handle: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSGeom_createEmptyPolygon_r(GEOSContextHandle_t handle)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeom_createEmptyPolygon_r($handle)"
		end

	c_geos_geom_create_polygon_r (handle, shell, holes: POINTER; n_holes: NATURAL): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSGeom_createPolygon_r(GEOSContextHandle_t handle, GEOSGeometry* shell, GEOSGeometry** holes, unsigned int nholes)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeom_createPolygon_r($handle, $shell, $holes, $n_holes)"
		end

	c_geos_geom_create_collection_r (handle: POINTER; type: INTEGER; geoms: POINTER; n_geoms: NATURAL): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSGeom_createCollection_r(GEOSContextHandle_t handle, int type, GEOSGeometry* *geoms, unsigned int ngeoms)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeom_createCollection_r($handle, $type, $geoms, $n_geoms)"
		end

	c_geos_geom_create_empty_collection_r (handle: POINTER; type: INTEGER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSGeom_createEmptyCollection_r(GEOSContextHandle_t handle, int type)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeom_createEmptyCollection_r($handle, $type)"
		end

	c_geos_geom_clone_r (handle, g: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSGeom_clone_r(GEOSContextHandle_t handle, const GEOSGeometry* g)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeom_clone_r($handle, $g)"
		end

feature -- Memory management

	c_geos_geom_destroy_r (handle, g: POINTER)
			-- void GEOS_DLL GEOSGeom_destroy_r(GEOSContextHandle_t handle, GEOSGeometry* g)
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSGeom_destroy_r($handle, $g)"
		end

feature -- Topology operations

	-- All these functions returning NULL on exception.

	c_geos_envelope_r (handle, g: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSEnvelope_r(GEOSContextHandle_t handle, const GEOSGeometry* g)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSEnvelope_r($handle, $g)"
		end

	c_geos_intersection_r (handle, g1, g2: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSIntersection_r(GEOSContextHandle_t handle, const GEOSGeometry* g1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSIntersection_r($handle, $g1, $g2)"
		end

	c_geos_convex_hull_r (handle, g: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSConvexHull_r(GEOSContextHandle_t handle, const GEOSGeometry* g)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSConvexHull_r($handle, $g)"
		end

	c_geos_difference_r (handle, g1, g2: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSDifference_r(GEOSContextHandle_t handle, const GEOSGeometry* g1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSDifference_r($handle, $g1, $g2)"
		end

	c_geos_symmetric_difference_r (handle, g1, g2: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSSymDifference_r(GEOSContextHandle_t handle, const GEOSGeometry* g1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSSymDifference_r($handle, $g1, $g2)"
		end

	c_geos_boundary_r (handle, g: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSBoundary_r(GEOSContextHandle_t handle, const GEOSGeometry* g)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSBoundary_r($handle, $g)"
		end

	c_geos_union_r (handle, g1, g2: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSUnion_r(GEOSContextHandle_t handle, const GEOSGeometry* g1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSUnion_r($handle, $g1, $g2)"
		end

	c_geos_unary_union_r (handle, g: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSUnaryUnion_r(GEOSContextHandle_t handle, const GEOSGeometry* g)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSUnaryUnion_r($handle, $g)"
		end

	c_geos_union_cascaded_r (handle, g: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSUnionCascaded_r(GEOSContextHandle_t handle, const GEOSGeometry* g)
		obsolete
			"deprecated in 3.3.0: use GEOSUnaryUnion_r instead"
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSUnionCascaded_r($handle, $g)"
		end

	c_geos_point_on_surface_r (handle, g: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSPointOnSurface_r(GEOSContextHandle_t handle, const GEOSGeometry* g)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSPointOnSurface_r($handle, $g)"
		end

	c_geos_get_centroid_r (handle, g: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSGetCentroid_r(GEOSContextHandle_t handle, const GEOSGeometry* g)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGetCentroid_r($handle, $g)"
		end

	c_geos_node_r (handle, g: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSNode_r(GEOSContextHandle_t handle, const GEOSGeometry* g)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSNode_r($handle, $g)"
		end

	c_geos_clip_by_rect_r (handle, g: POINTER; xmin, ymin, xmax, ymax: DOUBLE): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSClipByRect_r(GEOSContextHandle_t handle, const GEOSGeometry* g, double xmin, double ymin, double xmax, double ymax)
			-- Fast, non-robust intersection between an arbitrary geometry and a rectangle. The returned geometry may be invalid.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSClipByRect_r($handle, $g, $xmin, $ymin, $xmax, $ymax)"
		end

	-- All arguments remain ownership of the caller (both Geometries and pointers)
	-- Polygonizes a set of Geometries which contain linework that represents the edges of a planar graph.
	-- Any dimension of Geometry is handled - the constituent linework is extracted to form the edges.
	-- The edges must be correctly noded; that is, they must only meet at their endpoints.
	-- The Polygonizer will still run on incorrectly noded input but will not form polygons from incorrectly noded edges.
	-- The Polygonizer reports the follow kinds of errors:
	--   - Dangles - edges which have one or both ends which are not incident on another edge endpoint
	--   - Cut Edges - edges which are connected at both ends but which do not form part of polygon
	--   - Invalid Ring Lines - edges which form rings which are invalid (e.g. the component lines contain a self-intersection)
	-- Errors are reported to output parameters "cuts", "dangles" and "invalid" (if not-null). Formed polygons are returned as a
	-- collection. NULL is returned on exception. All returned geometries must be destroyed by caller.

	c_geos_polygonize_r (handle, geoms: POINTER; n_geoms: NATURAL): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSPolygonize_r(GEOSContextHandle_t handle, const GEOSGeometry *const geoms[], unsigned int ngeoms)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSPolygonize_r($handle, $geoms, $n_geoms)"
		end

	c_geos_polygonizer_get_cut_edges_r (handle, geoms: POINTER; n_geoms: NATURAL): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSPolygonizer_getCutEdges_r(GEOSContextHandle_t handle, const GEOSGeometry * const geoms[], unsigned int ngeoms)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSPolygonizer_getCutEdges_r($handle, $geoms, $n_geoms)"
		end

	c_geos_polygonize_full_r (handle, input, cuts, dangles, invalid_rings: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSPolygonize_full_r(GEOSContextHandle_t handle, const GEOSGeometry* input, GEOSGeometry** cuts, GEOSGeometry** dangles, GEOSGeometry** invalidRings)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSPolygonize_full_r($handle, $input, $cuts, $dangles, $invalid_rings)"
		end

	c_geos_line_merge_r (handle, g: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSLineMerge_r(GEOSContextHandle_t handle, const GEOSGeometry* g)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSLineMerge_r($handle, $g)"
		end

	c_geos_simplify_r (handle, g: POINTER; tolerance: DOUBLE): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSSimplify_r(GEOSContextHandle_t handle, const GEOSGeometry* g, double tolerance)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSSimplify_r($handle, $g, $tolerance)"
		end

	c_geos_topology_preserve_simplify_r (handle, g: POINTER; tolerance: DOUBLE): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSTopologyPreserveSimplify_r(GEOSContextHandle_t handle, const GEOSGeometry* g, double tolerance)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSTopologyPreserveSimplify_r($handle, $g, $tolerance)"
		end

	c_geos_geom_extract_unique_points_r (handle, g: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSGeom_extractUniquePoints_r(GEOSContextHandle_t handle, const GEOSGeometry* g)
			-- Return all distinct vertices of input geometry as a MULTIPOINT.
			-- Note that only 2 dimensions of the vertices are considered when testing for equality.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeom_extractUniquePoints_r($handle, $g)"
		end

	c_geos_shared_paths_r (handle, g1, g2: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSSharedPaths_r(GEOSContextHandle_t handle, const GEOSGeometry* g1, const GEOSGeometry* g2)
			-- Find paths shared between the two given lineal geometries.
			-- Returns a GEOMETRYCOLLECTION having two elements:
			--   - first element is a MULTILINESTRING containing shared paths having the _same_ direction on both inputs
			--   - second element is a MULTILINESTRING containing shared paths having the _opposite_ direction on the two inputs
			-- Returns NULL on exception

		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSSharedPaths_r($handle, $g1, $g2)"
		end

	c_geos_snap_r (handle, g1, g2: POINTER; tolerance: DOUBLE): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSSnap_r(GEOSContextHandle_t handle, const GEOSGeometry* g1, const GEOSGeometry* g2, double tolerance)
			-- Snap first geometry on to second with given tolerance. Returns a newly allocated geometry, or NULL on exception.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSSnap_r($handle, $g1, $g2, $tolerance)"
		end

	c_geos_delauney_triangulation_r (handle, g: POINTER; tolerance: DOUBLE; only_edges: INTEGER): POINTER
			-- GEOSGeometry GEOS_DLL * GEOSDelaunayTriangulation_r(GEOSContextHandle_t handle, const GEOSGeometry *g, double tolerance, int onlyEdges)
			-- Return a Delaunay triangulation of the vertex of the given geometry
			-- param `g'           the input geometry whose vertex will be used as "sites"
			-- param `tolerance'   optional snapping tolerance to use for improved robustness
			-- param `only_edges'  if non-zero will return a MULTILINESTRING, otherwise it will return a GEOMETRYCOLLECTION containing triangular POLYGONs.
			-- return              a newly allocated geometry, or NULL on exception
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSDelaunayTriangulation_r($handle, $g, $tolerance, $only_edges)"
		end

	c_geos_voronoi_diagram_r (handle, g, env: POINTER; tolerance: DOUBLE; only_edges: INTEGER): POINTER
			-- GEOSGeometry GEOS_DLL * GEOSVoronoiDiagram_r(GEOSContextHandle_t extHandle, const GEOSGeometry *g, const GEOSGeometry *env, double tolerance, int onlyEdges)
			-- Returns the Voronoi polygons of a set of Vertices given as input
			-- param `g'           the input geometry whose vertex will be used as sites.
			-- param `tolerance'   snapping tolerance to use for improved robustness
			-- param `only_edges'  whether to return only edges of the voronoi cells
			-- param `env'         clipping envelope for the returned diagram, automatically determined if NULL.
			--                     The diagram will be clipped to the larger of this envelope or an envelope surrounding the sites.
			-- return              a newly allocated geometry, or NULL on exception.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSVoronoiDiagram_r($handle, $g, $env, $tolerance, $only_edges)"
		end

feature -- Binary predicates

	-- Return 2 on exception, 1 on true, 0 on false

	c_geos_disjoint_r (handle, g1, g2: POINTER): NATURAL
			-- char GEOS_DLL GEOSDisjoint_r(GEOSContextHandle_t handle, const GEOSGeometry* g1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSDisjoint_r($handle, $g1, $g2)"
		end

	c_geos_touches_r (handle, g1, g2: POINTER): NATURAL
			-- char GEOS_DLL GEOSTouches_r(GEOSContextHandle_t handle, const GEOSGeometry* g1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSTouches_r($handle, $g1, $g2)"
		end

	c_geos_intersects_r (handle, g1, g2: POINTER): NATURAL
			-- char GEOS_DLL GEOSIntersects_r(GEOSContextHandle_t handle, const GEOSGeometry* g1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSIntersects_r($handle, $g1, $g2)"
		end

	c_geos_crosses_r (handle, g1, g2: POINTER): NATURAL
			-- char GEOS_DLL GEOSCrosses_r(GEOSContextHandle_t handle, const GEOSGeometry* g1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSCrosses_r($handle, $g1, $g2)"
		end

	c_geos_within_r (handle, g1, g2: POINTER): NATURAL
			-- char GEOS_DLL GEOSWithin_r(GEOSContextHandle_t handle, const GEOSGeometry* g1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSWithin_r($handle, $g1, $g2)"
		end

	c_geos_contains_r (handle, g1, g2: POINTER): NATURAL
			-- char GEOS_DLL GEOSContains_r(GEOSContextHandle_t handle, const GEOSGeometry* g1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSContains_r($handle, $g1, $g2)"
		end

	c_geos_overlaps_r (handle, g1, g2: POINTER): NATURAL
			-- char GEOS_DLL GEOSOverlaps_r(GEOSContextHandle_t handle, const GEOSGeometry* g1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
			alias
				"return (unsigned int)GEOSOverlaps_r($handle, $g1, $g2)"
		end

	c_geos_equals_r (handle, g1, g2: POINTER): NATURAL
			-- char GEOS_DLL GEOSEquals_r(GEOSContextHandle_t handle, const GEOSGeometry* g1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSEquals_r($handle, $g1, $g2)"
		end

	c_geos_equals_exact_r (handle, g1, g2: POINTER; tolerance: DOUBLE): NATURAL
			-- char GEOS_DLL GEOSEqualsExact_r(GEOSContextHandle_t handle, const GEOSGeometry* g1, const GEOSGeometry* g2, double tolerance)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSEqualsExact_r($handle, $g1, $g2, $tolerance)"
		end

	c_geos_covers_r (handle, g1, g2: POINTER): NATURAL
			-- char GEOS_DLL GEOSCovers_r(GEOSContextHandle_t handle, const GEOSGeometry* g1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSCovers_r($handle, $g1, $g2)"
		end

	c_geos_covered_by_r (handle, g1, g2: POINTER): NATURAL
			-- char GEOS_DLL GEOSCoveredBy_r(GEOSContextHandle_t handle, const GEOSGeometry* g1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSCoveredBy_r($handle, $g1, $g2)"
		end

feature -- Prepared geometry binary predicates

	-- return 2 on exception, 1 on true, 0 on false
	-- GEOSGeometry ownership is retained by caller

	geos_c_prepare_r (handle, g: POINTER): POINTER
			-- const GEOSPreparedGeometry GEOS_DLL *GEOSPrepare_r(GEOSContextHandle_t handle, const GEOSGeometry* g)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (GEOSPreparedGeometry*)GEOSPrepare_r($handle, $g)"
		end

	c_geos_cprepared_geometry_destroy_r (handle, g: POINTER)
			-- void GEOS_DLL GEOSPreparedGeom_destroy_r(GEOSContextHandle_t handle, const GEOSPreparedGeometry* g)
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSPreparedGeom_destroy_r($handle, $g)"
		end

	c_geos_prepared_contains_r (handle, pg1, g2: POINTER): NATURAL
			-- char GEOS_DLL GEOSPreparedContains_r(GEOSContextHandle_t handle, const GEOSPreparedGeometry* pg1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSPreparedContains_r($handle, $pg1, $g2)"
		end

	c_geos_prepared_contains_properly_r (handle, pg1, g2: POINTER): NATURAL
			-- char GEOS_DLL GEOSPreparedContainsProperly_r(GEOSContextHandle_t handle, const GEOSPreparedGeometry* pg1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSPreparedContainsProperly_r($handle, $pg1, $g2)"
		end

	c_geos_prepared_covered_by_r (handle, pg1, g2: POINTER): NATURAL
			-- char GEOS_DLL GEOSPreparedCoveredBy_r(GEOSContextHandle_t handle, const GEOSPreparedGeometry* pg1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSPreparedCoveredBy_r($handle, $pg1, $g2)"
		end

	c_geos_prepared_covers_r (handle, pg1, g2: POINTER): NATURAL
			-- char GEOS_DLL GEOSPreparedCovers_r(GEOSContextHandle_t handle, const GEOSPreparedGeometry* pg1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSPreparedCovers_r($handle, $pg1, $g2)"
		end

	c_geos_prepared_crosses_r (handle, pg1, g2: POINTER): NATURAL
			-- char GEOS_DLL GEOSPreparedCrosses_r(GEOSContextHandle_t handle, const GEOSPreparedGeometry* pg1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSPreparedCrosses_r($handle, $pg1, $g2)"
		end

	c_geos_prepared_disjoint_r (handle, pg1, g2: POINTER): NATURAL
			-- char GEOS_DLL GEOSPreparedDisjoint_r(GEOSContextHandle_t handle, const GEOSPreparedGeometry* pg1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSPreparedDisjoint_r($handle, $pg1, $g2)"
		end

	c_geos_prepared_intersects_r (handle, pg1, g2: POINTER): NATURAL
			-- char GEOS_DLL GEOSPreparedIntersects_r(GEOSContextHandle_t handle, const GEOSPreparedGeometry* pg1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSPreparedIntersects_r($handle, $pg1, $g2)"
		end

	c_geos_prepared_overlaps_r (handle, pg1, g2: POINTER): NATURAL
			-- char GEOS_DLL GEOSPreparedOverlaps_r(GEOSContextHandle_t handle, const GEOSPreparedGeometry* pg1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSPreparedOverlaps_r($handle, $pg1, $g2)"
		end

	c_geos_prepared_touches_r (handle, pg1, g2: POINTER): NATURAL
			-- char GEOS_DLL GEOSPreparedTouches_r(GEOSContextHandle_t handle, const GEOSPreparedGeometry* pg1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSPreparedTouches_r($handle, $pg1, $g2)"
		end

	c_geos_prepared_within_r (handle, pg1, g2: POINTER): NATURAL
			-- char GEOS_DLL GEOSPreparedWithin_r(GEOSContextHandle_t handle, const GEOSPreparedGeometry* pg1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSPreparedWithin_r($handle, $pg1, $g2)"
		end

feature -- STRTree functions

	-- GEOSGeometry ownership is retained by caller

	c_geos_str_tree_create_r (handle: POINTER; capacity: NATURAL): POINTER
			-- GEOSSTRtree GEOS_DLL *GEOSSTRtree_create_r(GEOSContextHandle_t handle, size_t nodeCapacity)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSSTRtree_create_r($handle, $capacity)"
		end

	c_geos_str_tree_insert_r (handle, tree, g, item: POINTER)
			-- void GEOS_DLL GEOSSTRtree_insert_r(GEOSContextHandle_t handle, GEOSSTRtree *tree, const GEOSGeometry *g, void *item)
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSSTRtree_insert_r($handle, $tree, $g, $item)"
		end

	c_geos_str_tree_query_r (handle, tree, g, callback, user_data: POINTER)
			-- void GEOS_DLL GEOSSTRtree_query_r(GEOSContextHandle_t handle, GEOSSTRtree *tree, const GEOSGeometry *g, GEOSQueryCallback callback, void *userdata)
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSSTRtree_query_r($handle, $tree, $g, $callback, $user_data)"
		end

	c_geos_str_tree_iterate_r (handle, tree, callback, user_data: POINTER)
			-- void GEOS_DLL GEOSSTRtree_iterate_r(GEOSContextHandle_t handle, GEOSSTRtree *tree, GEOSQueryCallback callback, void *userdata)
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSSTRtree_iterate_r($handle, $tree, $callback, $user_data)"
		end

	c_geos_str_tree_remove_r (handle, tree, g, item: POINTER): NATURAL
			-- char GEOS_DLL GEOSSTRtree_remove_r(GEOSContextHandle_t handle, GEOSSTRtree *tree, const GEOSGeometry *g, void *item)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSSTRtree_remove_r($handle, $tree, $g, $item)"
		end

	c_geos_str_tree_destroy_r (handle, tree: POINTER)
			-- void GEOS_DLL GEOSSTRtree_destroy_r(GEOSContextHandle_t handle, GEOSSTRtree *tree)
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSSTRtree_destroy_r($handle, $tree)"
		end

feature -- Unary predicates

	-- return 2 on exception, 1 on true, 0 on false

	c_geos_is_empty_r (handle, g: POINTER): NATURAL
			-- char GEOS_DLL GEOSisEmpty_r(GEOSContextHandle_t handle, const GEOSGeometry* g)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned char)GEOSisEmpty_r($handle, $g)"
		end

	c_geos_is_simple_r (handle, g: POINTER): NATURAL
			-- char GEOS_DLL GEOSisSimple_r(GEOSContextHandle_t handle, const GEOSGeometry* g)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSisSimple_r($handle, $g)"
		end

	c_geos_is_ring_r (handle, g: POINTER): NATURAL
			-- char GEOS_DLL GEOSisRing_r(GEOSContextHandle_t handle, const GEOSGeometry* g)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSisRing_r($handle, $g)"
		end

	c_geos_has_z_r (handle, g: POINTER): NATURAL
			-- char GEOS_DLL GEOSHasZ_r(GEOSContextHandle_t handle, const GEOSGeometry* g)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSHasZ_r($handle, $g)"
		end

	c_geos_is_closed_r (handle, g: POINTER): NATURAL
			-- char GEOS_DLL GEOSisClosed_r(GEOSContextHandle_t handle, const GEOSGeometry *g)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSisClosed_r($handle, $g)"
		end

feature -- Dimensionally Extended 9 Intersection Model related

	c_geos_relate_pattern_r (handle, g1, g2, pattern: POINTER): NATURAL
			-- char GEOS_DLL GEOSRelatePattern_r(GEOSContextHandle_t handle, const GEOSGeometry* g1, const GEOSGeometry* g2, const char *pat)
			-- return 2 on exception, 1 on true, 0 on false
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSRelatePattern_r($handle, $g1, $g2, $pattern)"
		end

	c_geos_relate_r (handle, g1, g2: POINTER): POINTER
			-- char GEOS_DLL *GEOSRelate_r(GEOSContextHandle_t handle, const GEOSGeometry* g1, const GEOSGeometry* g2)
			-- return NULL on exception, a string to GEOSFree otherwise
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSRelate_r($handle, $g1, $g2)"
		end

	c_geos_relate_pattern_match_r (handle, mat, pattern: POINTER): NATURAL
			-- char GEOS_DLL GEOSRelatePatternMatch_r(GEOSContextHandle_t handle, const char *mat, const char *pat)
			-- return 2 on exception, 1 on true, 0 on false
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSRelatePatternMatch_r($handle, $mat, $pattern)"
		end

	c_geos_relate_boundary_node_rule_r (handle, g1, g2: POINTER; bnr: NATURAL): POINTER
			-- char GEOS_DLL *GEOSRelateBoundaryNodeRule_r(GEOSContextHandle_t handle, const GEOSGeometry* g1, const GEOSGeometry* g2, int bnr)
			-- return NULL on exception, a string to GEOSFree otherwise
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSRelateBoundaryNodeRule_r($handle, $g1, $g2, $bnr)"
		end

feature -- Validity checking

	c_geos_is_valid_r (handle, g: POINTER): NATURAL
			-- char GEOS_DLL GEOSisValid_r(GEOSContextHandle_t handle, const GEOSGeometry* g)
			-- return 2 on exception, 1 on true, 0 on false
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSisValid_r($handle, $g)"
		end

	c_geos_is_valid_reason_r (handle, g: POINTER): POINTER
			-- char GEOS_DLL *GEOSisValidReason_r(GEOSContextHandle_t handle, const GEOSGeometry* g)
			-- return NULL on exception, a string to GEOSFree otherwise
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSisValidReason_r($handle, $g)"
		end

	c_geos_is_valid_detail_r (handle, g: POINTER; flags: INTEGER; reason, location: POINTER): NATURAL
			-- char GEOS_DLL GEOSisValidDetail_r(GEOSContextHandle_t handle, const GEOSGeometry* g, int flags, char** reason, GEOSGeometry** location)
			-- Caller has the responsibility to destroy 'reason' (GEOSFree) and 'location' (GEOSGeom_destroy) params
			-- return 2 on exception, 1 when valid, 0 when invalid
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSisValidDetail_r($handle, $g, $flags, $reason, $location)"
		end

feature -- Geometry info

	c_geos_type_r (handle, g: POINTER): POINTER
			-- char GEOS_DLL *GEOSGeomType_r(GEOSContextHandle_t handle, const GEOSGeometry* g)
			-- Return NULL on exception, result must be freed by caller.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeomType_r($handle, $g)"
		end

	c_geos_geom_type_id_r (handle, g: POINTER): INTEGER
			-- int GEOS_DLL GEOSGeomTypeId_r(GEOSContextHandle_t handle, const GEOSGeometry* g)
			-- Return -1 on exception
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeomTypeId_r($handle, $g)"
		end

	c_geos_get_srid_r (handle, g: POINTER): INTEGER
			-- int GEOS_DLL GEOSGetSRID_r(GEOSContextHan dle_t handle, const GEOSGeometry* g)
			-- Return 0 on exception
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGetSRID_r($handle, $g)"
		end

	c_geos_set_srid_r (handle, g: POINTER; srid: INTEGER)
			-- void GEOS_DLL GEOSSetSRID_r(GEOSContextHandle_t handle, GEOSGeometry* g, int SRID)
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSSetSRID_r($handle, $g, $srid)"
		end

	c_geos_get_num_geometries_r (handle, g: POINTER): INTEGER
			-- int GEOS_DLL GEOSGetNumGeometries_r(GEOSContextHandle_t handle, const GEOSGeometry* g)
			-- May be called on all geometries in GEOS 3.x, returns -1 on error and 1
			-- for non-multi geometries. Older GEOS versions only accept GeometryCollections or Multi* geometries here, and are likely to crash
			-- when fed simple geometries, so beware if you need compatibility with old GEOS versions.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGetNumGeometries_r($handle, $g)"
		end

	c_geos_get_geometry_n_r (handle, g: POINTER; n: INTEGER): POINTER
			-- const GEOSGeometry GEOS_DLL *GEOSGetGeometryN_r(GEOSContextHandle_t handle, const GEOSGeometry* g, int n)
			-- Return NULL on exception.
			-- Returned object is a pointer to internal storage: it must NOT be destroyed directly.
			-- Up to GEOS 3.2.0 the input geometry must be a Collection, in later version it doesn't matter (getGeometryN(0) for a single will
			-- return the input).
		external
			"C inline use %"geos_c.h%""
		alias
			"return (GEOSGeometry*)GEOSGetGeometryN_r($handle, $g, $n)"
		end

	c_geos_normalize_r (handle, g: POINTER): INTEGER
			-- int GEOS_DLL GEOSNormalize_r(GEOSContextHandle_t handle, GEOSGeometry* g)
			-- Return -1 on exception
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSNormalize_r($handle, $g)"
		end

	c_geos_get_num_interior_rings_r (handle, g: POINTER): INTEGER
			-- int GEOS_DLL GEOSGetNumInteriorRings_r(GEOSContextHandle_t handle, const GEOSGeometry* g)
			-- Return -1 on exception
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGetNumInteriorRings_r($handle, $g)"
		end

	c_geos_geom_get_num_points_r (handle, g: POINTER): INTEGER
			-- int GEOS_DLL GEOSGeomGetNumPoints_r(GEOSContextHandle_t handle, const GEOSGeometry* g)
			-- Return -1 on exception, Geometry must be a LineString.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeomGetNumPoints_r($handle, $g)"
		end

	c_geos_geom_get_x_r (handle, g, x: POINTER): INTEGER
			-- int GEOS_DLL GEOSGeomGetX_r(GEOSContextHandle_t handle, const GEOSGeometry *g, double *x)
			-- Return -1 on exception, Geometry must be a Point.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeomGetX_r($handle, $g, $x)"
		end

	c_geos_geom_get_y_r (handle, g, y: POINTER): INTEGER
			-- int GEOS_DLL GEOSGeomGetY_r(GEOSContextHandle_t handle, const GEOSGeometry *g, double *y)
			-- Return -1 on exception, Geometry must be a Point.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeomGetX_r($handle, $g, $y)"
		end

	c_geos_get_interior_ring_n_r (handle, g: POINTER; n: INTEGER): POINTER
			-- const GEOSGeometry GEOS_DLL *GEOSGetInteriorRingN_r(GEOSContextHandle_t handle, const GEOSGeometry* g, int n)
			-- Return NULL on exception, Geometry must be a Polygon.
			-- Returned object is a pointer to internal storage: it must NOT be destroyed directly.
		external
			"C inline use %"geos_c.h%""
		alias
			"return (GEOSGeometry*)GEOSGetInteriorRingN_r($handle, $g, $n)"
		end

	c_geos_get_exterior_ring_r(handle, g: POINTER): POINTER
			-- const GEOSGeometry GEOS_DLL *GEOSGetExteriorRing_r(GEOSContextHandle_t handle, const GEOSGeometry* g)
			-- Return NULL on exception, Geometry must be a Polygon.
			-- Returned object is a pointer to internal storage: it must NOT be destroyed directly.
		external
			"C inline use %"geos_c.h%""
		alias
			"return (GEOSGeometry*)GEOSGetExteriorRing_r($handle, $g)"
		end

	c_geos_get_num_coordinates_r (handle, g: POINTER): INTEGER
			-- int GEOS_DLL GEOSGetNumCoordinates_r(GEOSContextHandle_t handle, const GEOSGeometry* g)
			-- Return -1 on exception.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGetNumCoordinates_r($handle, $g)"
		end

	c_geos_geom_get_coord_seq_r (handle, g: POINTER): POINTER
			-- const GEOSCoordSequence GEOS_DLL *GEOSGeom_getCoordSeq_r(GEOSContextHandle_t handle, const GEOSGeometry* g)
			-- Return NULL on exception.
			-- Geometry must be a LineString, LinearRing or Point.
		external
			"C inline use %"geos_c.h%""
		alias
			"return (GEOSCoordSequence*)GEOSGeom_getCoordSeq_r($handle, $g)"
		end

	c_geos_geom_get_dimensions_r (handle, g: POINTER): INTEGER
			-- int GEOS_DLL GEOSGeom_getDimensions_r(GEOSContextHandle_t handle, const GEOSGeometry* g)
			-- Return 0 on exception (or empty geometry)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeom_getDimensions_r($handle, $g)"
		end

	c_geos_get_coordinate_dimension_r (handle, g: POINTER): INTEGER
			-- int GEOS_DLL GEOSGeom_getCoordinateDimension_r(GEOSContextHandle_t handle, const GEOSGeometry* g)
			-- Return 2 or 3.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeom_getCoordinateDimension_r($handle, $g)"
		end

	c_geos_geom_get_point_n_r (handle, g: POINTER; n: INTEGER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSGeomGetPointN_r(GEOSContextHandle_t handle, const GEOSGeometry *g, int n)
			-- Return NULL on exception.
			-- Must be LineString and must be freed by called.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeomGetPointN_r($handle, $g, $n)"
		end

	c_geos_geom_get_start_point_r (handle, g: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSGeomGetStartPoint_r(GEOSContextHandle_t handle, const GEOSGeometry *g)
			-- Return NULL on exception.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeomGetStartPoint_r($handle, $g)"
		end

	c_geos_geom_get_end_point_r (handle, g: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSGeomGetEndPoint_r(GEOSContextHandle_t handle, const GEOSGeometry *g)
			-- Return NULL on exception.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeomGetEndPoint_r($handle, $g)"
		end

feature -- Misc functions

	c_geos_area_r (handle, g, area: POINTER): INTEGER
			-- int GEOS_DLL GEOSArea_r(GEOSContextHandle_t handle, const GEOSGeometry* g, double *area)
			-- Return 0 on exception, 1 otherwise
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSArea_r($handle, $g, $area)"
		end

	c_geos_length_r (handle, g, length: POINTER): INTEGER
			-- int GEOS_DLL GEOSLength_r(GEOSContextHandle_t handle, const GEOSGeometry* g, double *length)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSLength_r($handle, $g, $length)"
		end

	c_geos_distance_r (handle, g1, g2, distance: POINTER): INTEGER
			-- int GEOS_DLL GEOSDistance_r(GEOSContextHandle_t handle, const GEOSGeometry* g1, const GEOSGeometry* g2, double *dist)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSDistance_r($handle, $g1, $g2, $distance)"
		end

	c_geos_hausorff_distance_r (handle, g1, g2, distance: POINTER): INTEGER
			-- int GEOS_DLL GEOSHausdorffDistance_r(GEOSContextHandle_t handle, const GEOSGeometry *g1, const GEOSGeometry *g2, double *dist)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSHausdorffDistance_r($handle, $g1, $g2, $distance)"
		end

	c_geos_hausdorff_distance_densify_r (handle, g1, g2: POINTER; densify_fraction: DOUBLE; distance: POINTER): INTEGER
			-- int GEOS_DLL GEOSHausdorffDistanceDensify_r(GEOSContextHandle_t handle, const GEOSGeometry *g1, const GEOSGeometry *g2, double densifyFrac, double *dist)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSHausdorffDistanceDensify_r($handle, $g1, $g2, $densify_fraction, $distance)"
		end

	c_geos_geom_get_length_r (handle, g, length: POINTER): INTEGER
			-- int GEOS_DLL GEOSGeomGetLength_r(GEOSContextHandle_t handle, const GEOSGeometry *g, double *length)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeomGetLength_r($handle, $g, $length)"
		end

	c_geos_nearest_points_r (handle, g1, g2: POINTER): POINTER
			-- GEOSCoordSequence GEOS_DLL *GEOSNearestPoints_r(GEOSContextHandle_t handle, const GEOSGeometry* g1, const GEOSGeometry* g2)
			-- Return 0 on exception, the closest points of the two geometries otherwise.
			-- The first point comes from g1 geometry and the second point comes from g2.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSNearestPoints_r($handle, $g1, $g2)"
		end

feature -- Algorithms

	c_geos_orientation_index_r (handle: POINTER; ax, ay, bx, by, px, py: DOUBLE): INTEGER
			-- int GEOS_DLL GEOSOrientationIndex_r(GEOSContextHandle_t handle, double Ax, double Ay, double Bx, double By, double Px, double Py)
			-- Walking from A to B:
			--   return -1 if reaching P takes a counter-clockwise (left) turn
			--   return  1 if reaching P takes a clockwise (right) turn
			--   return  0 if P is collinear with A-B
			-- On exceptions, return 2.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSOrientationIndex_r($handle, $ax, $ay, $bx, $by, $px, $py)"
		end

-- Reader and writer API

feature -- WKT Reader

	c_geos_wkt_reader_create_r (handle: POINTER): POINTER
			-- GEOSWKTReader GEOS_DLL *GEOSWKTReader_create_r(GEOSContextHandle_t handle)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSWKTReader_create_r($handle)"
		end

	c_geos_wkt_reader_destroy_r (handle, reader: POINTER)
			-- void GEOS_DLL GEOSWKTReader_destroy_r(GEOSContextHandle_t handle, GEOSWKTReader* reader)
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSWKTReader_destroy_r($handle, $reader)"
		end

	c_geos_wkt_reader_read_r (handle, reader, wkt: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSWKTReader_read_r(GEOSContextHandle_t handle, GEOSWKTReader* reader, const char *wkt)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSWKTReader_read_r($handle, $reader, $wkt)"
		end

feature -- WKT writer

	c_geos_wkt_writer_create_r (handle: POINTER): POINTER
			-- GEOSWKTWriter GEOS_DLL *GEOSWKTWriter_create_r(GEOSContextHandle_t handle)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSWKTWriter_create_r($handle)"
		end

	c_geos_wkt_destroy_r (handle, writer: POINTER)
			-- void GEOS_DLL GEOSWKTWriter_destroy_r(GEOSContextHandle_t handle, GEOSWKTWriter* writer)
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSWKTWriter_destroy_r($handle, $writer)"
		end

	c_geos_wkt_writer_write_r (handle, writer, g: POINTER): POINTER
			-- char GEOS_DLL *GEOSWKTWriter_write_r(GEOSContextHandle_t handle, GEOSWKTWriter* writer, const GEOSGeometry* g)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSWKTWriter_write_r($handle, $writer, $g)"
		end

	c_geos_wkt_writer_set_trim_r (handle, writer: POINTER; trim: CHARACTER)
			-- void GEOS_DLL GEOSWKTWriter_setTrim_r(GEOSContextHandle_t handle, GEOSWKTWriter *writer, char trim)
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSWKTWriter_setTrim_r($handle, $writer, $trim)"
		end

	c_geos_wkt_writer_set_rounding_precision_r (handle, writer: POINTER; precision: INTEGER)
			-- void GEOS_DLL GEOSWKTWriter_setRoundingPrecision_r(GEOSContextHandle_t handle, GEOSWKTWriter *writer, int precision)
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSWKTWriter_setRoundingPrecision_r($handle, $writer, $precision)"
		end

	c_geos_wkt_writer_set_output_dimension_r (handle, writer: POINTER; dim: INTEGER)
			-- void GEOS_DLL GEOSWKTWriter_setOutputDimension_r(GEOSContextHandle_t handle, GEOSWKTWriter *writer, int dim)
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSWKTWriter_setOutputDimension_r($handle, $writer, $dim)"
		end

	c_geos_wkt_writer_get_output_dimension_r (handle, writer: POINTER): INTEGER
			-- int GEOS_DLL GEOSWKTWriter_getOutputDimension_r(GEOSContextHandle_t handle, GEOSWKTWriter *writer)
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSWKTWriter_getOutputDimension_r($handle, $writer)"
		end

	c_geos_wkt_writer_set_old_3d_r (handle, writer: POINTER; use_old_3d: INTEGER)
			-- void GEOS_DLL GEOSWKTWriter_setOld3D_r(GEOSContextHandle_t handle, GEOSWKTWriter *writer, int useOld3D)
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSWKTWriter_setOld3D_r($handle, $writer, $use_old_3d)"
		end

feature -- WKB Reader

	c_geos_wkb_reader_create_r (handle: POINTER): POINTER
			-- GEOSWKBReader GEOS_DLL *GEOSWKBReader_create_r(GEOSContextHandle_t handle)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSWKBReader_create_r($handle)"
		end

	c_geos_wkb_reader_destroy_r (handle, reader: POINTER)
			-- void GEOS_DLL GEOSWKBReader_destroy_r(GEOSContextHandle_t handle, GEOSWKBReader* reader)
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSWKBReader_destroy_r($handle, $reader)"
		end

	c_geos_wkb_reader_read_r (handle, reader, wkb: POINTER; size: NATURAL): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSWKBReader_read_r(GEOSContextHandle_t handle, GEOSWKBReader* reader, const unsigned char *wkb, size_t size)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSWKBReader_read_r($handle, $reader, $wkb, $size)"
		end

	c_geos_wkb_reader_read_hex_r (handle, reader, hex: POINTER; size: NATURAL): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSWKBReader_readHEX_r(GEOSContextHandle_t handle, GEOSWKBReader* reader, const unsigned char *hex, size_t size)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSWKBReader_readHEX_r($handle, $reader, $hex, $size)"
		end

feature -- WKB Writer

	c_geos_wkb_writer_create_r (handle: POINTER): POINTER
			-- GEOSWKBWriter GEOS_DLL *GEOSWKBWriter_create_r(GEOSContextHandle_t handle)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSWKBWriter_create_r($handle)"
		end

	c_geos_wkb_writer_destroy (handle, writer: POINTER)
			-- void GEOS_DLL GEOSWKBWriter_destroy_r(GEOSContextHandle_t handle, GEOSWKBWriter* writer)
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSWKBWriter_destroy_r($handle, $writer)"
		end

	c_geos_wkb_writer_write_r (handle, writer, g, size: POINTER): POINTER
			-- unsigned char GEOS_DLL *GEOSWKBWriter_write_r(GEOSContextHandle_t handle, GEOSWKBWriter* writer, const GEOSGeometry* g, size_t *size)
			-- The caller owns the results for this method
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSWKBWriter_write_r($handle, $writer, $g, $size)"
		end

	c_geos_wkb_writer_write_hex_r (handle, writer, g, size: POINTER): POINTER
			-- unsigned char GEOS_DLL *GEOSWKBWriter_writeHEX_r(GEOSContextHandle_t handle, GEOSWKBWriter* writer, const GEOSGeometry* g, size_t *size)
			-- The caller owns the results for this method
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSWKBWriter_writeHEX_r($handle, $writer, $g, $size)"
		end

	c_geos_wkb_writer_get_output_dimension_r (handle, writer: POINTER): INTEGER
			-- int GEOS_DLL GEOSWKBWriter_getOutputDimension_r(GEOSContextHandle_t handle, const GEOSWKBWriter* writer)
			-- Specify whether output WKB should be 2d or 3d. Return previously set number of dimensions.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSWKBWriter_getOutputDimension_r($handle, $writer)"
		end

	c_geos_wkb_writer_set_output_dimension_r (handle, writer: POINTER; new_dimension: INTEGER)
			-- void GEOS_DLL GEOSWKBWriter_setOutputDimension_r(GEOSContextHandle_t handle, GEOSWKBWriter* writer, int newDimension)
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSWKBWriter_setOutputDimension_r($handle, $writer, $new_dimension)"
		end

	c_geos_wkb_writer_get_byte_order_r (handle, writer: POINTER): INTEGER
			-- int GEOS_DLL GEOSWKBWriter_getByteOrder_r(GEOSContextHandle_t handle, const GEOSWKBWriter* writer)
			-- Specify whether the WKB byte order is big or little endian. The return value is the previous byte order.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSWKBWriter_getByteOrder_r($handle, $writer)"
		end

	c_geos_wkb_writer_set_byte_order_r (handle, writer: POINTER; byte_order: INTEGER)
			-- void GEOS_DLL GEOSWKBWriter_setByteOrder_r(GEOSContextHandle_t handle, GEOSWKBWriter* writer, int byteOrder)
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSWKBWriter_setByteOrder_r($handle, $writer, $byte_order)"
		end

	c_geos_wkb_writer_get_include_srid_r (handle, writer: POINTER): CHARACTER
			-- char GEOS_DLL GEOSWKBWriter_getIncludeSRID_r(GEOSContextHandle_t handle, const GEOSWKBWriter* writer)
			-- Specify whether SRID values should be output.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSWKBWriter_getIncludeSRID_r($handle, $writer)"
		end

	c_geos_wkb_writer_set_include_srid_r (handle, writer: POINTER; write_srid: CHARACTER)
			-- void GEOS_DLL GEOSWKBWriter_setIncludeSRID_r(GEOSContextHandle_t handle, GEOSWKBWriter* writer, const char writeSRID)
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSWKBWriter_setIncludeSRID_r($handle, $writer, $write_srid)"
		end

	c_geos_free_r (handle, buffer: POINTER)
			-- void GEOS_DLL GEOSFree_r(GEOSContextHandle_t handle, void *buffer)
			-- Free buffers returned by stuff like GEOSWKBWriter_write(),
			-- GEOSWKBWriter_writeHEX() and GEOSWKTWriter_write().
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSFree_r($handle, $buffer)"
		end

end
