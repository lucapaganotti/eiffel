note
	description: "[
			Summary description for {GEOS_EXTERNALS_NON_R}.
			
			Really a sort of functional cloning of the 'non r' library interface.
		]"
	author: "Luca Paganotti - luca <dot> paganotti <at> gmail <dot> com"
	date: "$Date$"
	revision: "$Revision$"

class
	GEOS_EXTERNALS_NON_R

inherit
	GEOS_EXTERNALS_DEFINES

feature -- Initialization, cleanup, version

	c_init_geos (notice_function, error_function: POINTER)
			-- void GEOS_DLL initGEOS(GEOSMessageHandler notice_function, GEOSMessageHandler error_function)
		external
			"C inline use %"geos_c.h%""
		alias
			"initGEOS($notice_function, $error_function)"
		end

	c_finish_geos
			-- void GEOS_DLL finishGEOS(void)
		external
			"C inline use %"geos_c.h%""
		alias
			"finishGEOS()"
		end

	c_geom_from_wkt(wkt: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSGeomFromWKT(const char *wkt)
		obsolete
			"These functions are DEPRECATED.  Please use the new Reader and writer APIS."
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeomFromWKT($wkt)"
		end

	c_geom_to_wkt (g: POINTER): POINTER
			-- char GEOS_DLL *GEOSGeomToWKT(const GEOSGeometry* g)
		obsolete
			"These functions are DEPRECATED.  Please use the new Reader and writer APIS."
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeomToWKT($g)"
		end

	c_get_wkb_output_dimensions: INTEGER
			-- int GEOS_DLL GEOS_getWKBOutputDims()
			-- Specify whether output WKB should be 2d or 3d. Return previously set number of dimensions.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOS_getWKBOutputDims()"
		end

	c_set_wkb_output_dimensions(new_dims: INTEGER): INTEGER
			-- int GEOS_DLL GEOS_setWKBOutputDims(int newDims)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOS_setWKBOutputDims($new_dims)"
		end

	c_get_wkb_byte_order: INTEGER
			-- int GEOS_DLL GEOS_getWKBByteOrder()
			-- Specify whether the WKB byte order is big or little endian. The return value is the previous byte order.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOS_getWKBByteOrder()"
		end

	c_set_wkb_byte_order (byte_order: INTEGER): INTEGER
			--int GEOS_DLL GEOS_setWKBByteOrder(int byteOrder)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOS_setWKBByteOrder($byte_order)"
		end

	c_geom_from_wkb_buffer (wkb: POINTER; size: NATURAL): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSGeomFromWKB_buf(const unsigned char *wkb, size_t size)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeomFromWKB_buf($wkb, $size)"
		end

	c_geom_to_wkb_buffer (g, size: POINTER): POINTER
			-- unsigned char GEOS_DLL *GEOSGeomToWKB_buf(const GEOSGeometry* g, size_t *size)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeomToWKB_buf($g, $size)"
		end

	c_geom_from_hex_buffer (hex: POINTER; size: NATURAL): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSGeomFromHEX_buf(const unsigned char *hex, size_t size)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeomFromHEX_buf($hex, $size)"
		end

	c_geom_to_hex_buffer (g, size: POINTER): POINTER
			-- unsigned char GEOS_DLL *GEOSGeomToHEX_buf(const GEOSGeometry* g, size_t *size)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeomToHEX_buf($g, $size)"
		end

feature -- Coordinate Sequence functions

	c_coord_seq_create (size, dims: NATURAL): POINTER
			-- GEOSCoordSequence GEOS_DLL *GEOSCoordSeq_create(unsigned int size, unsigned int dims)
			-- Create a Coordinate sequence with ``size'' coordinates of `dims' dimensions.
			-- Return NULL on exception.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSCoordSeq_create($size, $dims)"
		end

	c_coord_seq_clone (s: POINTER): POINTER
			-- GEOSCoordSequence GEOS_DLL *GEOSCoordSeq_clone(const GEOSCoordSequence* s)
			-- Clone a Coordinate Sequence. Return NULL on exception.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSCoordSeq_clone($s)"
		end

	c_coord_seq_destroy (s: POINTER)
			-- void GEOS_DLL GEOSCoordSeq_destroy(GEOSCoordSequence* s)
			-- Destroy a Coordinate Sequence.
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSCoordSeq_destroy($s)"
		end

	-- Set ordinate values in a Coordinate Sequence. Return 0 on exception.

	c_coord_seq_set_x (s: POINTER; idx: NATURAL; value: DOUBLE): INTEGER
			-- int GEOS_DLL GEOSCoordSeq_setX(GEOSCoordSequence* s, unsigned int idx, double val)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSCoordSeq_setX($s, $idx, $value)"
		end

	c_coord_seq_set_y (s: POINTER; idx: NATURAL; value: DOUBLE): INTEGER
			-- int GEOS_DLL GEOSCoordSeq_setY(GEOSCoordSequence* s, unsigned int idx, double val)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSCoordSeq_setY($s, $idx, $value)"
		end

	c_coord_seq_set_z (s: POINTER; idx: NATURAL; value: DOUBLE): INTEGER
			-- int GEOS_DLL GEOSCoordSeq_setZ(GEOSCoordSequence* s, unsigned int idx, double val)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSCoordSeq_setZ($s, $idx, $value)"
		end

	c_coord_seq_set_ordinate (s: POINTER; idx, dim: NATURAL; value: DOUBLE): INTEGER
			-- int GEOS_DLL GEOSCoordSeq_setOrdinate(GEOSCoordSequence* s, unsigned int idx, unsigned int dim, double val)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSCoordSeq_setOrdinate($s, $idx, $dim, $value)"
		end

	-- Get ordinate values from a Coordinate Sequence. Return 0 on exception.

	c_coord_seq_get_x(s: POINTER; idx: NATURAL; value: POINTER): INTEGER
			-- int GEOS_DLL GEOSCoordSeq_getX(const GEOSCoordSequence* s, unsigned int idx, double *val)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSCoordSeq_getX($s, $idx, $value)"
		end

	c_coord_seq_get_y(s: POINTER; idx: NATURAL; value: POINTER): INTEGER
			-- int GEOS_DLL GEOSCoordSeq_getY(const GEOSCoordSequence* s, unsigned int idx, double *val)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSCoordSeq_getY($s, $idx, $value)"
		end

	c_coord_seq_get_z(s: POINTER; idx: NATURAL; value: POINTER): INTEGER
			-- int GEOS_DLL GEOSCoordSeq_getz(const GEOSCoordSequence* s, unsigned int idx, double *val)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSCoordSeq_getZ($s, $idx, $value)"
		end

	c_coord_seq_get_ordinate (s: POINTER; idx, dim: NATURAL; value: POINTER): INTEGER
			-- int GEOS_DLL GEOSCoordSeq_getOrdinate(const GEOSCoordSequence* s, unsigned int idx, unsigned int dim, double *val)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSCoordSeq_getOrdinate($s, $idx, $dim, $value)"
		end

	c_coord_seq_get_size (s, size: POINTER): INTEGER
			-- int GEOS_DLL GEOSCoordSeq_getSize(const GEOSCoordSequence* s, unsigned int *size)
			-- Get size and dimensions info from a Coordinate Sequence.
			-- Return 0 on exception.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSCoordSeq_getSize($s, $size)"
		end

	c_coord_seq_get_dimensions (s, dims: POINTER): INTEGER
			-- int GEOS_DLL GEOSCoordSeq_getDimensions(const GEOSCoordSequence* s, unsigned int *dims)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSCoordSeq_getDimensions($s, $dims)"
		end

feature -- Linear referencing functions

	-- GEOSGeometry ownership is retained by caller

	c_project(g, p: POINTER): DOUBLE
			-- double GEOS_DLL GEOSProject(const GEOSGeometry *g, const GEOSGeometry* p)
			-- Return distance of point 'p' projected on 'g' from origin
			-- of 'g'. Geometry 'g' must be a lineal geometry
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSProject($g, $p)"
		end

	c_interpolate (g: POINTER; d: DOUBLE): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSInterpolate(const GEOSGeometry *g, double d)
			-- Return closest point to given distance within geometry
			-- Geometry must be a LineString
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSInterpolate($g, $d)"
		end

	c_project_normalized (g, p: POINTER): DOUBLE
			-- double GEOS_DLL GEOSProjectNormalized(const GEOSGeometry *g, const GEOSGeometry* p)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSProjectNormalized($g, $p)"
		end

	c_interpolate_normalized (g: POINTER; d: DOUBLE): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSInterpolateNormalized(const GEOSGeometry *g, double d)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSInterpolateNormalized($g, $d)"
		end

feature -- Buffer related functions

	c_buffer (g: POINTER; width: DOUBLE; quad_segs: INTEGER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSBuffer(const GEOSGeometry* g, double width, int quadsegs)
			-- return NULL on exception
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSBuffer($g, $width, $quad_segs)"
		end

	c_buffer_params_create: POINTER
			-- GEOSBufferParams GEOS_DLL *GEOSBufferParams_create()
			-- return 0 on exception
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSBufferParams_create()"
		end

	c_buffer_params_destroy (parms: POINTER)
			-- void GEOS_DLL GEOSBufferParams_destroy(GEOSBufferParams* parms)
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSBufferParams_destroy($parms)"
		end

	c_buffer_params_set_end_cap_style (p: POINTER; style: INTEGER): INTEGER
			-- int GEOS_DLL GEOSBufferParams_setEndCapStyle(GEOSBufferParams* p, int style)
			-- return 0 on exception
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSBufferParams_setEndCapStyle($p, $style)"
		end

	c_buffer_params_set_join_style (p: POINTER; join_style: INTEGER): INTEGER
			-- int GEOS_DLL GEOSBufferParams_setJoinStyle(GEOSBufferParams* p, int joinStyle)
			-- return 0 on exception
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSBufferParams_setJoinStyle($p, $join_style)"
		end

	c_buffer_params_set_mitre_limit (p: POINTER; mitre_limit: DOUBLE): INTEGER
			-- int GEOS_DLL GEOSBufferParams_setMitreLimit(GEOSBufferParams* p, double mitreLimit)
			-- return 0 on exception
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSBufferParams_setMitreLimit($p, $mitre_limit)"
		end

	c_buffer_params_set_quadrant_segments (p: POINTER; quad_segs: INTEGER): INTEGER
			-- int GEOS_DLL GEOSBufferParams_setQuadrantSegments(GEOSBufferParams* p, int quadSegs)
			-- return 0 on exception
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSBufferParams_setQuadrantSegments($p, $quad_segs)"
		end

	c_buffer_params_set_single_sided (p: POINTER; single_sided: INTEGER): INTEGER
			-- int GEOS_DLL GEOSBufferParams_setSingleSided(GEOSBufferParams* p, int singleSided)
			-- `single_sided': 1 for single sided, 0 otherwise
			-- return 0 on exception
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSBufferParams_setSingleSided($p, $single_sided)"
		end

	c_buffer_with_parameters (g, p: POINTER; width: DOUBLE): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSBufferWithParams(const GEOSGeometry* g, const GEOSBufferParams* p, double width)
			-- return NULL on exception
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSBufferWithParams($g, $p, $width)"
		end

	-- These functions return NULL on exception.
	c_buffer_with_style (g: POINTER; width: DOUBLE; quad_segs, end_cap_style, join_style: INTEGER; mitre_limit: DOUBLE): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSBufferWithStyle(const GEOSGeometry* g, double width, int quadsegs, int endCapStyle, int joinStyle, double mitreLimit)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSBufferWithStyle($g, $width, $quad_segs, $end_cap_style, $join_style, $mitre_limit)"
		end

	-- These functions return NULL on exception. Only LINESTRINGs are accepted.
	c_single_sided_buffer (g: POINTER; width: DOUBLE; quad_segs, join_style: INTEGER; mitre_limit: DOUBLE; left_side: INTEGER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSSingleSidedBuffer(const GEOSGeometry* g, double width, int quadsegs, int joinStyle, double mitreLimit, int leftSide)
		obsolete
			"deprecated in 3.3.0: use GEOSOffsetCurve instead."
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSSingleSidedBuffer($g, $width, $quad_segs, $join_style, $mitre_limit, $left_side)"
		end

	c_offset_curve (g: POINTER; width: DOUBLE; quad_segs, join_style: INTEGER; mitre_limit: DOUBLE): POINTER
			--  GEOSGeometry GEOS_DLL *GEOSOffsetCurve(const GEOSGeometry* g, double width, int quadsegs, int joinStyle, double mitreLimit)
			-- Only LINESTRINGs are accepted.
			-- `width' : offset distance.
			--           negative for right side offset.
			--           positive for left side offset.
			-- return NULL on exception
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSOffsetCurve($g, $width, $quad_segs, $join_style, $mitre_limit)"
		end

feature -- Geometry Constructors.

	-- GEOSCoordSequence* arguments will become ownership of the returned object.
	-- All functions return NULL on exception.

	c_geom_create_point (s: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSGeom_createPoint(GEOSCoordSequence* s)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeom_createPoint($s)"
		end

	c_geom_create_empty_point: POINTER
			-- GEOSGeometry GEOS_DLL *GEOSGeom_createEmptyPoint();
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeom_createEmptyPoint()"
		end

	c_geom_create_linear_ring (s: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSGeom_createLinearRing(GEOSCoordSequence* s)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeom_createLinearRing($s)"
		end

	c_geom_create_line_string (s: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSGeom_createLineString(GEOSCoordSequence* s)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeom_createLineString($s)"
		end

	c_geom_create_empty_line_string: POINTER
			-- GEOSGeometry GEOS_DLL *GEOSGeom_createEmptyLineString()
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeom_createEmptyLineString()"
		end

	c_geom_create_empty_polygon: POINTER
			-- GEOSGeometry GEOS_DLL *GEOSGeom_createEmptyPolygon()
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeom_createEmptyPolygon()"
		end

	c_geom_create_polygon (shell, holes: POINTER; n_holes: NATURAL): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSGeom_createPolygon(GEOSGeometry* shell, GEOSGeometry** holes, unsigned int nholes)
			-- Second argument is an array of GEOSGeometry* objects.
			-- The caller remains owner of the array, but pointed-to objects become ownership of the returned GEOSGeometry.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeom_createPolygon($shell, $holes, $n_holes)"
		end

	c_geom_create_collection (t: INTEGER; geoms: POINTER; n_geoms: NATURAL): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSGeom_createCollection(int type, GEOSGeometry* *geoms, unsigned int ngeoms)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeom_createCollection($t, $geoms, $n_geoms)"
		end

	c_geom_create_empty_collection (t: INTEGER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSGeom_createEmptyCollection(int type)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeom_createEmptyCollection($t)"
		end

	c_geom_clone (g: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSGeom_clone(const GEOSGeometry* g)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeom_clone($g)"
		end

feature -- Memory management

	c_geom_destroy (g: POINTER)
			-- void GEOS_DLL GEOSGeom_destroy(GEOSGeometry* g)
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSGeom_destroy($g)"
		end

feature -- Topology operations

	-- All returning NULL on exception.
	c_envelope (g: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSEnvelope(const GEOSGeometry* g)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSEnvelope($g)"
		end

	c_intersection (g1, g2: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSIntersection(const GEOSGeometry* g1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSIntersection($g1, $g2)"
		end

	c_convex_hull (g: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSConvexHull(const GEOSGeometry* g)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSConvexHull($g)"
		end

	c_difference (g1, g2: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSDifference(const GEOSGeometry* g1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSDifference($g1, $g2)"
		end

	c_symmetric_difference (g1, g2: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSSymDifference(const GEOSGeometry* g1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSSymDifference($g1, $g2)"
		end

	c_boundary (g: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSBoundary(const GEOSGeometry* g)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSBoundary($g)"
		end

	c_union (g1, g2: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSUnion(const GEOSGeometry* g1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSUnion($g1, $g2)"
		end

	c_unary_union (g: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSUnaryUnion(const GEOSGeometry* g)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSUnaryUnion($g)"
		end

	c_union_cascaded (g: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSUnionCascaded(const GEOSGeometry* g)
		obsolete
			"deprecated in 3.3.0: use GEOSUnaryUnion instead."
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSUnionCascaded($g)"
		end

	c_point_on_surface (g: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSPointOnSurface(const GEOSGeometry* g)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSPointOnSurface($g)"
		end

	c_get_centroid (g: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSGetCentroid(const GEOSGeometry* g)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGetCentroid($g)"
		end

	c_node (g: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSNode(const GEOSGeometry* g)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSNode($g)"
		end

	c_clip_by_rect (g: POINTER; xmin, ymin, xmax, ymax: DOUBLE): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSClipByRect(const GEOSGeometry* g, double xmin, double ymin, double xmax, double ymax)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSClipByRect($g, $xmin, $ymin, $xmax, $ymax)"
		end

	-- all arguments remain ownership of the caller (both Geometries and pointers)
	c_polygonize (geoms: POINTER; n_geoms: NATURAL): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSPolygonize(const GEOSGeometry * const geoms[], unsigned int ngeoms)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSPolygonize($geoms, $n_geoms)"
		end

	c_polyonizer_get_cut_edges (geoms: POINTER; n_geoms: NATURAL): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSPolygonizer_getCutEdges(const GEOSGeometry * const geoms[], unsigned int ngeoms)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSPolygonizer_getCutEdges($geoms, $n_geoms)"
		end

	c_polygonize_full(input, cuts, dangles, invalid: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSPolygonize_full(const GEOSGeometry* input, GEOSGeometry** cuts, GEOSGeometry** dangles, GEOSGeometry** invalid)
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
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSPolygonize_full($input, $cuts, $dangles, $invalid)"
		end

	c_line_merge (g: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSLineMerge(const GEOSGeometry* g)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSLineMerge($g)"
		end

	c_simplify (g: POINTER; tolerance: DOUBLE): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSSimplify(const GEOSGeometry* g, double tolerance)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSSimplify($g, $tolerance)"
		end

	c_topology_preserve_simplify (g: POINTER; tolerance: DOUBLE): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSTopologyPreserveSimplify(const GEOSGeometry* g, double tolerance)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSTopologyPreserveSimplify($g, $tolerance)"
		end

	c_geom_extract_unique_points (g: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSGeom_extractUniquePoints(const GEOSGeometry* g)
			-- Return all distinct vertices of input geometry as a MULTIPOINT.
			-- Note that only 2 dimensions of the vertices are considered when testing for equality.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeom_extractUniquePoints($g)"
		end

	c_shared_paths (g1, g2: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSSharedPaths(const GEOSGeometry* g1, const GEOSGeometry* g2)
			-- Find paths shared between the two given lineal geometries.
			-- Returns a GEOMETRYCOLLECTION having two elements:
			--   - first element is a MULTILINESTRING containing shared paths
			--     having the _same_ direction on both inputs
			--   - second element is a MULTILINESTRING containing shared paths
			--     having the _opposite_ direction on the two inputs
			-- Returns NULL on exception.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSSharedPaths($g1, $g2)"
		end

	c_snap (g1, g2: POINTER; tolerance: DOUBLE): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSSnap(const GEOSGeometry* g1, const GEOSGeometry* g2, double tolerance)
			-- Snap first geometry on to second with given tolerance
			-- Returns a newly allocated geometry, or NULL on exception
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSSnap($g1, $g2, $tolerance)"
		end

	c_delauney_triangulation (g: POINTER; tolerance: DOUBLE; only_edges: INTEGER): POINTER
			-- GEOSGeometry GEOS_DLL * GEOSDelaunayTriangulation(const GEOSGeometry *g, double tolerance, int onlyEdges)
			-- Return a Delaunay triangulation of the vertex of the given geometry
			-- `g' the input geometry whose vertex will be used as "sites"
			-- `tolerance' optional snapping tolerance to use for improved robustness
			-- `only_edges' if non-zero will return a MULTILINESTRING, otherwise it will
			--     return a GEOMETRYCOLLECTION containing triangular POLYGONs.
			-- return  a newly allocated geometry, or NULL on exception
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSDelaunayTriangulation($g, $tolerance, $only_edges)"
		end

	c_voronoi_diagram (g, env: POINTER; tolerance: DOUBLE; only_edges: INTEGER): POINTER
			-- GEOSGeometry GEOS_DLL * GEOSVoronoiDiagram(const GEOSGeometry *g, const GEOSGeometry *env, double tolerance, int onlyEdges)
			-- Returns the Voronoi polygons of a set of Vertices given as input
			-- `g' the input geometry whose vertex will be used as sites.
			-- `tolerance' snapping tolerance to use for improved robustness
			-- `only_edges' whether to return only edges of the voronoi cells
			-- `env' clipping envelope for the returned diagram, automatically determined if NULL.
			-- The diagram will be clipped to the larger of this envelope or an envelope surrounding the sites.
			-- return a newly allocated geometry, or NULL on exception.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSVoronoiDiagram($g, $env, $tolerance, $only_edges)"
		end

feature -- Binary predicates

	-- All returning 2 on exception, 1 on true, 0 on false

	c_disjoint (g1, g2: POINTER): NATURAL
			-- char GEOS_DLL GEOSDisjoint(const GEOSGeometry* g1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSDisjoint($g1, $g2)"
		end

	c_touches (g1, g2: POINTER): NATURAL
			-- char GEOS_DLL GEOSTouches(const GEOSGeometry* g1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSTouches($g1, $g2)"
		end

	c_intersects (g1, g2: POINTER): NATURAL
			-- char GEOS_DLL GEOSIntersects(const GEOSGeometry* g1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSIntersects($g1, $g2)"
		end

	c_crosses (g1, g2: POINTER): NATURAL
			-- char GEOS_DLL GEOSCrosses(const GEOSGeometry* g1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSCrosses($g1, $g2)"
		end

	c_within (g1, g2: POINTER): NATURAL
			-- char GEOS_DLL GEOSWithin(const GEOSGeometry* g1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSContains($g1, $g2)"
		end

	c_contains (g1, g2: POINTER): NATURAL
			-- char GEOS_DLL GEOSContains(const GEOSGeometry* g1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSContains($g1, $g2)"
		end

	c_overlaps (g1, g2: POINTER): NATURAL
			-- char GEOS_DLL GEOSOverlaps(const GEOSGeometry* g1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSOverlaps($g1, $g2)"
		end

	c_equals (g1, g2: POINTER): NATURAL
			-- char GEOS_DLL GEOSEquals(const GEOSGeometry* g1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSEquals($g1, $g2)"
		end

	c_equals_exact (g1, g2: POINTER; tolerance: DOUBLE): NATURAL
			-- char GEOS_DLL GEOSEqualsExact(const GEOSGeometry* g1, const GEOSGeometry* g2, double tolerance)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSEqualsExact($g1, $g2, $tolerance)"
		end

	c_covers (g1, g2: POINTER): NATURAL
			-- char GEOS_DLL GEOSCovers(const GEOSGeometry* g1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSCovers($g1, $g2)"
		end

	c_covered_by (g1, g2: POINTER): NATURAL
			-- char GEOS_DLL GEOSCoveredBy(const GEOSGeometry* g1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSCoveredBy($g1, $g2)"
		end

feature -- Prepared Geometry Binary predicates

	-- All returning 2 on exception, 1 on true, 0 on false
	-- GEOSGeometry ownership is retained by caller

	c_prepare (g: POINTER): POINTER
			-- const GEOSPreparedGeometry GEOS_DLL *GEOSPrepare(const GEOSGeometry* g)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (GEOSPreparedGeometry*)GEOSPrepare($g)"
		end

	c_prepared_geometry_destroy (g: POINTER)
			-- void GEOS_DLL GEOSPreparedGeom_destroy(const GEOSPreparedGeometry* g)
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSPreparedGeom_destroy($g)"
		end

	c_prepared_contains (pg1, g2: POINTER): NATURAL
			-- char GEOS_DLL GEOSPreparedContains(const GEOSPreparedGeometry* pg1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSPreparedContains($pg1, $g2)"
		end

	c_prepared_contains_properly (pg1, g2: POINTER): NATURAL
			-- char GEOS_DLL GEOSPreparedContainsProperly(const GEOSPreparedGeometry* pg1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSPreparedContainsProperly($pg1, $g2)"
		end

	c_prepared_covered_by (pg1, g2: POINTER): NATURAL
			-- char GEOS_DLL GEOSPreparedCoveredBy(const GEOSPreparedGeometry* pg1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSPreparedCoveredBy($pg1, $g2)"
		end

	c_prepared_covers (pg1, g2: POINTER): NATURAL
			-- char GEOS_DLL GEOSPreparedCovers(const GEOSPreparedGeometry* pg1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSPreparedCovers($pg1, $g2)"
		end

	c_prepared_crosses (pg1, g2: POINTER): NATURAL
			-- char GEOS_DLL GEOSPreparedCrosses(const GEOSPreparedGeometry* pg1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSPreparedCrosses($pg1, $g2)"
		end

	c_prepared_disjoint (pg1, g2: POINTER): NATURAL
			-- char GEOS_DLL GEOSPreparedDisjoint(const GEOSPreparedGeometry* pg1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSPreparedDisjoint($pg1, $g2)"
		end

	c_prepared_intersects (pg1, g2: POINTER): NATURAL
			-- char GEOS_DLL GEOSPreparedIntersects(const GEOSPreparedGeometry* pg1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSPreparedIntersects($pg1, $g2)"
		end

	c_prepared_overlaps (pg1, g2: POINTER): NATURAL
			-- char GEOS_DLL GEOSPreparedOverlaps(const GEOSPreparedGeometry* pg1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSPreparedOverlaps($pg1, $g2)"
		end

	c_prepared_touches (pg1, g2: POINTER): NATURAL
			-- char GEOS_DLL GEOSPreparedTouches(const GEOSPreparedGeometry* pg1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSPreparedTouches($pg1, $g2)"
		end

	c_prepared_within (pg1, g2: POINTER): NATURAL
			-- char GEOS_DLL GEOSPreparedWithin(const GEOSPreparedGeometry* pg1, const GEOSGeometry* g2)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSPreparedWithin($pg1, $g2)"
		end

feature -- STRtree functions

	-- GEOSGeometry ownership is retained by caller

	c_str_tree_create (capacity: NATURAL): POINTER
			-- GEOSSTRtree GEOS_DLL *GEOSSTRtree_create(size_t nodeCapacity)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSSTRtree_create($capacity)"
		end

	c_str_tree_insert (tree, g, item: POINTER)
			-- void GEOS_DLL GEOSSTRtree_insert(GEOSSTRtree *tree, const GEOSGeometry *g, void *item)
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSSTRtree_insert($tree, $g, $item)"
		end

	c_str_tree_query (tree,g, callback, user_data: POINTER)
			-- void GEOS_DLL GEOSSTRtree_query(GEOSSTRtree *tree, const GEOSGeometry *g, GEOSQueryCallback callback, void *userdata)
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSSTRtree_query($tree, $g, $callback, $user_data)"
		end

	c_str_tree_iterate (tree, callback, user_data: POINTER)
			-- void GEOS_DLL GEOSSTRtree_iterate(GEOSSTRtree *tree, GEOSQueryCallback callback, void *userdata)
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSSTRtree_iterate($tree, $callback, $user_data)"
		end

	c_str_tree_remove (tree, g, item: POINTER): NATURAL
			-- char GEOS_DLL GEOSSTRtree_remove(GEOSSTRtree *tree, const GEOSGeometry *g, void *item)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSSTRtree_remove($tree, $g, $item)"
		end

	c_str_tree_destroy (tree: POINTER)
			-- void GEOS_DLL GEOSSTRtree_destroy(GEOSSTRtree *tree)
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSSTRtree_destroy($tree)"
		end

feature -- Unary predicates

	-- All returning 2 on exception, 1 on true, 0 on false

	c_is_empty (g: POINTER): NATURAL
			-- char GEOS_DLL GEOSisEmpty(const GEOSGeometry* g)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSisEmpty($g)"
		end

	c_is_simple (g: POINTER): NATURAL
			-- char GEOS_DLL GEOSisSimple(const GEOSGeometry* g)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSisSimple($g)"
		end

	c_is_ring (g: POINTER): NATURAL
			-- char GEOS_DLL GEOSisRing(const GEOSGeometry* g)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSisRing($g)"
		end

	c_has_z (g: POINTER): NATURAL
			-- char GEOS_DLL GEOSHasZ(const GEOSGeometry* g)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSHasZ($g)"
		end

	c_is_closed (g: POINTER): NATURAL
			-- char GEOS_DLL GEOSisClosed(const GEOSGeometry *g)
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSisClosed($g)"
		end

feature -- Validity checking

	c_is_valid (g: POINTER): NATURAL
			-- char GEOS_DLL GEOSisValid(const GEOSGeometry* g)
			-- return 2 on exception, 1 on true, 0 on false
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSisValid($g)"
		end

	c_is_valid_reason (g: POINTER): POINTER
			-- char GEOS_DLL *GEOSisValidReason(const GEOSGeometry *g)
			-- return NULL on exception, a string to GEOSFree otherwise
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSisValidReason($g)"
		end

	c_is_valid_detail (g: POINTER; flags: INTEGER; reason, location: POINTER): NATURAL
			-- char GEOS_DLL GEOSisValidDetail(const GEOSGeometry* g, int flags, char** reason, GEOSGeometry** location)
			-- Caller has the responsibility to destroy `reason' (GEOSFree)
			-- and `location' (GEOSGeom_destroy) params
			-- return 2 on exception, 1 when valid, 0 when invalid
			-- Use enum GEOSValidFlags values for the flags param. I.e {GEOS_VALID_FLAGS_CONSTANTS}
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSisValidDetail($g, $flags, $reason, $location)"
		end

feature -- Geometry info

	c_type (g: POINTER): POINTER
			-- char GEOS_DLL *GEOSGeomType(const GEOSGeometry* g)
			-- Return NULL on exception, result must be freed by caller.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeomType($g)"
		end

	c_type_id (g: POINTER): INTEGER
			-- int GEOS_DLL GEOSGeomTypeId(const GEOSGeometry* g)
			-- Return -1 on exception
			-- See {GEOS_GEOM_TYPES_CONSTANTS}
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeomTypeId($g)"
		end

	c_get_srid (g: POINTER): INTEGER
			-- int GEOS_DLL GEOSGetSRID(const GEOSGeometry* g)
			-- Return 0 on exception
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGetSRID($g)"
		end

	c_set_srid (g: POINTER; srid: INTEGER)
			-- void GEOS_DLL GEOSSetSRID(GEOSGeometry* g, int SRID)
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSSetSRID($g, $srid)"
		end

	c_get_num_geometries (g: POINTER): INTEGER
			-- int GEOS_DLL GEOSGetNumGeometries(const GEOSGeometry* g)
			-- May be called on all geometries in GEOS 3.x, returns -1 on error and 1
			-- for non-multi geometries. Older GEOS versions only accept
			-- GeometryCollections or Multi* geometries here, and are likely to crash
			-- when fed simple geometries, so beware if you need compatibility with
			-- old GEOS versions.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGetNumGeometries($g)"
		end

	c_get_geometry_n (g: POINTER; n: INTEGER): POINTER
			-- const GEOSGeometry GEOS_DLL *GEOSGetGeometryN(const GEOSGeometry* g, int n)
			-- Return NULL on exception.
			-- Returned object is a pointer to internal storage: it must NOT be destroyed directly.
			-- Up to GEOS 3.2.0 the input geometry must be a Collection, in
			-- later version it doesn't matter (getGeometryN(0) for a single will return the input).
		external
			"C inline use %"geos_c.h%""
		alias
			"return (GEOSGeometry*)GEOSGetGeometryN($g, $n)"
		end

	c_normalize (g: POINTER): INTEGER
			-- int GEOS_DLL GEOSNormalize(GEOSGeometry* g)
			-- Return -1 on exception
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSNormalize($g)"
		end

	c_get_interior_rings_number (g: POINTER): INTEGER
			-- int GEOS_DLL GEOSGetNumInteriorRings(const GEOSGeometry* g)
			-- Return -1 on exception
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGetNumInteriorRings($g)"
		end

	c_get_points_number (g: POINTER): INTEGER
			-- int GEOS_DLL GEOSGeomGetNumPoints(const GEOSGeometry* g)
			-- Return -1 on exception, Geometry must be a LineString.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeomGetNumPoints($g)"
		end

	c_get_x (g, x: POINTER): INTEGER
			-- int GEOS_DLL GEOSGeomGetX(const GEOSGeometry *g, double *x)
			-- Return -1 on exception, Geometry must be a Point.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeomGetX($g, $x)"
		end

	c_get_y (g, y: POINTER): INTEGER
			-- int GEOS_DLL GEOSGeomGetY(const GEOSGeometry *g, double *y)
			-- Return -1 on exception, Geometry must be a Point.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeomGetY($g, $y)"
		end

	c_get_interior_ring_n (g: POINTER; n: INTEGER): POINTER
			-- const GEOSGeometry GEOS_DLL *GEOSGetInteriorRingN(const GEOSGeometry* g, int n)
			-- Return NULL on exception, Geometry must be a Polygon.
			-- Returned object is a pointer to internal storage: it must NOT be destroyed directly.
		external
			"C inline use %"geos_c.h%""
		alias
			"return (GEOSGeometry*)GEOSGetInteriorRingN($g, $n)"
		end

	c_get_exterior_ring (g: POINTER): POINTER
			-- const GEOSGeometry GEOS_DLL *GEOSGetExteriorRing(const GEOSGeometry* g)
			-- Return NULL on exception, Geometry must be a Polygon.
			-- Returned object is a pointer to internal storage: it must NOT be destroyed directly.
		external
			"C inline use %"geos_c.h%""
		alias
			"return (GEOSGeometry*)GEOSGetExteriorRing($g)"
		end

	c_coordinate_number (g: POINTER): INTEGER
			-- int GEOS_DLL GEOSGetNumCoordinates(const GEOSGeometry* g)
			-- Return -1 on exception
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGetNumCoordinates($g)"
		end

	c_get_coordinate_sequence (g: POINTER): POINTER
			-- const GEOSCoordSequence GEOS_DLL *GEOSGeom_getCoordSeq(const GEOSGeometry* g)
			-- Return NULL on exception.
			-- Geometry must be a LineString, LinearRing or Point.
		external
			"C inline use %"geos_c.h%""
		alias
			"return (GEOSCoordSequence*)GEOSGeom_getCoordSeq($g)"
		end

	c_dimensions (g: POINTER): INTEGER
			-- int GEOS_DLL GEOSGeom_getDimensions(const GEOSGeometry* g)
			-- Return 0 on exception (or empty geometry)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeom_getDimensions($g)"
		end

	c_coordinate_dimension (g: POINTER): INTEGER
			-- int GEOS_DLL GEOSGeom_getCoordinateDimension(const GEOSGeometry* g)
			-- Return 2 or 3.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeom_getCoordinateDimension($g)"
		end

	c_point_n (g: POINTER; n: INTEGER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSGeomGetPointN(const GEOSGeometry *g, int n)
			-- Return NULL on exception.
			-- Must be LineString and must be freed by called.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeomGetPointN($g, $n)"
		end

	c_start_point (g: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSGeomGetStartPoint(const GEOSGeometry *g)
			-- Return NULL on exception.
			-- Must be LineString and must be freed by called.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeomGetStartPoint($g)"
		end

	c_end_point (g: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSGeomGetEndPoint(const GEOSGeometry *g)
			-- Return NULL on exception.
			-- Must be LineString and must be freed by called.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeomGetEndPoint($g)"
		end

feature -- Misc functions

	c_area (g, a: POINTER): INTEGER
			-- int GEOS_DLL GEOSArea(const GEOSGeometry* g, double *area)
			-- Return 0 on exception, 1 otherwise
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSArea($g, $a)"
		end

	c_length (g, l: POINTER): INTEGER
			-- int GEOS_DLL GEOSLength(const GEOSGeometry* g, double *length)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSLength($g, $l)"
		end

	c_distance (g1, g2, d: POINTER): INTEGER
			-- int GEOS_DLL GEOSDistance(const GEOSGeometry* g1, const GEOSGeometry* g2, double *dist)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSDistance($g1, $g2, $d)"
		end

	c_hausdorff_distance (g1, g2, d: POINTER): INTEGER
			-- int GEOS_DLL GEOSHausdorffDistance(const GEOSGeometry *g1, const GEOSGeometry *g2, double *dist)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSHausdorffDistance($g1, $g2, $d)"
		end

	c_hausdorff_distance_densify (g1, g2: POINTER; densify_fraction: DOUBLE; d: POINTER): INTEGER
			-- int GEOS_DLL GEOSHausdorffDistanceDensify(const GEOSGeometry *g1, const GEOSGeometry *g2, double densifyFrac, double *dist)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSHausdorffDistanceDensify($g1, $g2, $densify_fraction, $d)"
		end

	c_get_length (g, l: POINTER): INTEGER
			-- int GEOS_DLL GEOSGeomGetLength(const GEOSGeometry *g, double *length)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSGeomGetLength($g, $l)"
		end

	c_nearest_point (g1, g2: POINTER): POINTER
			-- GEOSCoordSequence GEOS_DLL *GEOSNearestPoints(const GEOSGeometry* g1, const GEOSGeometry* g2)
			-- Return 0 on exception, the closest points of the two geometries otherwise.
			-- The first point comes from g1 geometry and the second point comes from g2.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSNearestPoints($g1, $g2)"
		end

feature -- Algorithms

	-- Walking from A to B:
	--   return -1 if reaching P takes a counter-clockwise (left) turn
	--   return  1 if reaching P takes a clockwise (right) turn
	--   return  0 if P is collinear with A-B
	-- On exceptions, return 2.

	c_orientation_index (ax, ay, bx, by, px ,py: DOUBLE): INTEGER
			-- int GEOS_DLL GEOSOrientationIndex(double Ax, double Ay, double Bx, double By, double Px, double Py)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSOrientationIndex($ax, $ay, $bx, $by, $px, $py)"
		end

	-- Reader and Writer APIs

feature -- WKT Reader

	c_wkt_reader_create: POINTER
			-- GEOSWKTReader GEOS_DLL *GEOSWKTReader_create()
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSWKTReader_create()"
		end

	c_wkt_reader_destroy (reader: POINTER)
			-- void GEOS_DLL GEOSWKTReader_destroy(GEOSWKTReader* reader)
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSWKTReader_destroy($reader)"
		end

	c_wkt_reader_read (reader, wkt: POINTER): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSWKTReader_read(GEOSWKTReader* reader, const char *wkt)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSWKTReader_read($reader, $wkt)"
		end

feature -- WKT Writer

	c_wkt_writer_create: POINTER
			-- GEOSWKTWriter GEOS_DLL *GEOSWKTWriter_create()
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSWKTWriter_create()"
		end

	c_wkt_writer_destroy (writer: POINTER)
			-- void GEOS_DLL GEOSWKTWriter_destroy(GEOSWKTWriter* writer)
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSWKTWriter_destroy($writer)"
		end

	c_wkt_writer_write (writer, g: POINTER): POINTER
			-- char GEOS_DLL *GEOSWKTWriter_write(GEOSWKTWriter* writer, const GEOSGeometry* g)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSWKTWriter_write($writer, $g)"
		end

	c_wkt_writer_set_trim (writer: POINTER; trim: CHARACTER)
			-- void GEOS_DLL GEOSWKTWriter_setTrim(GEOSWKTWriter *writer, char trim)
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSWKTWriter_setTrim($writer, $trim)"
		end

	c_wkt_writer_set_rounding_precision (writer: POINTER; precision: INTEGER)
			-- void GEOS_DLL GEOSWKTWriter_setRoundingPrecision(GEOSWKTWriter *writer, int precision)
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSWKTWriter_setRoundingPrecision($writer, $precision)"
		end

	c_wkt_writer_set_output_dimension (writer: POINTER; dim: INTEGER)
			-- void GEOS_DLL GEOSWKTWriter_setOutputDimension(GEOSWKTWriter *writer, int dim)
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSWKTWriter_setOutputDimension($writer, $dim)"
		end

	c_wkt_writer_get_output_dimension (writer: POINTER): INTEGER
			-- int  GEOS_DLL GEOSWKTWriter_getOutputDimension(GEOSWKTWriter *writer)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSWKTWriter_getOutputDimension($writer)"
		end

	c_wkt_writer_set_old_3d (writer: POINTER; use_old_3d: INTEGER)
			-- void GEOS_DLL GEOSWKTWriter_setOld3D(GEOSWKTWriter *writer, int useOld3D)
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSWKTWriter_setOld3D($writer, $use_old_3d)"
		end

feature -- WKB Reader

	c_wkb_reader_create: POINTER
			-- GEOSWKBReader GEOS_DLL *GEOSWKBReader_create()
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSWKBReader_create()"
		end

	c_wkb_reader_destroy (reader: POINTER)
			-- void GEOS_DLL GEOSWKBReader_destroy(GEOSWKBReader* reader)
			external
				"C inline use %"geos_c.h%""
			alias
				"GEOSWKBReader_destroy($reader)"
			end

	c_wkb_reader_read (reader, wkb: POINTER; size: NATURAL): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSWKBReader_read(GEOSWKBReader* reader, const unsigned char *wkb, size_t size)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSWKBReader_read($reader, $wkb, $size)"
		end

	c_wkb_reader_read_hex (reader, hex: POINTER; size: NATURAL): POINTER
			-- GEOSGeometry GEOS_DLL *GEOSWKBReader_readHEX(GEOSWKBReader* reader, const unsigned char *hex, size_t size)
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSWKBReader_readHEX($reader, $hex, $size)"
		end

feature -- WKB Writer

	c_wkb_writer_create: POINTER
			-- GEOSWKBWriter GEOS_DLL *GEOSWKBWriter_create()
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSWKBWriter_create()"
		end

	c_wkb_writer_destroy (writer: POINTER)
			-- void GEOS_DLL GEOSWKBWriter_destroy(GEOSWKBWriter* writer)
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSWKBWriter_destroy($writer)"
		end

	-- The caller owns the results for these two methods

	c_wkb_writer_write (writer, g, size: POINTER): POINTER
			-- unsigned char GEOS_DLL *GEOSWKBWriter_write(GEOSWKBWriter* writer, const GEOSGeometry* g, size_t *size)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSWKBWriter_write($writer, $g, $size)"
		end

	c_wkb_writer_write_hex (writer, g, size: POINTER): POINTER
			-- unsigned char GEOS_DLL *GEOSWKBWriter_writeHEX(GEOSWKBWriter* writer, const GEOSGeometry* g, size_t *size)
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSWKBWriter_writeHEX($writer, $g, $size)"
		end

	c_wkb_writer_get_output_dimension (writer: POINTER): INTEGER
			-- int GEOS_DLL GEOSWKBWriter_getOutputDimension(const GEOSWKBWriter* writer)
			-- Specify whether output WKB should be 2d or 3d.
			-- Return previously set number of dimensions.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSWKBWriter_getOutputDimension($writer)"
		end

	c_wkb_writer_set_ouptut_dimension (writer: POINTER; new_dimension: INTEGER)
			-- void GEOS_DLL GEOSWKBWriter_setOutputDimension(GEOSWKBWriter* writer, int newDimension)
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSWKBWriter_setOutputDimension($writer, $new_dimension)"
		end

	c_wkb_writer_get_byte_order (writer: POINTER): INTEGER
			-- int GEOS_DLL GEOSWKBWriter_getByteOrder(const GEOSWKBWriter* writer)
			-- Specify whether the WKB byte order is big or little endian.
			-- The return value is the previous byte order.
		external
			"C inline use %"geos_c.h%""
		alias
			"return GEOSWKBWriter_getByteOrder($writer)"
		end

	c_wkb_writer_set_byte_order (writer: POINTER; byte_order: INTEGER)
			-- void GEOS_DLL GEOSWKBWriter_setByteOrder(GEOSWKBWriter* writer, int byteOrder)
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSWKBWriter_setByteOrder($writer, $byte_order)"
		end

	c_wkb_writer_get_include_srid (writer: POINTER): NATURAL
			-- char GEOS_DLL GEOSWKBWriter_getIncludeSRID(const GEOSWKBWriter* writer)
			-- Specify whether SRID values should be output.
		external
			"C inline use %"geos_c.h%""
		alias
			"return (unsigned int)GEOSWKBWriter_getIncludeSRID($writer)"
		end

	c_wkb_writer_set_include_srid (writer: POINTER; write_srid: NATURAL)
			-- void GEOS_DLL GEOSWKBWriter_setIncludeSRID(GEOSWKBWriter* writer, const char writeSRID)
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSWKBWriter_setIncludeSRID($writer, $write_srid)"
		end

	c_geos_free (buff: POINTER)
			-- void GEOS_DLL GEOSFree(void *buffer)
			-- Free buffers returned by stuff like GEOSWKBWriter_write(),
			-- GEOSWKBWriter_writeHEX() and GEOSWKTWriter_write().
		external
			"C inline use %"geos_c.h%""
		alias
			"GEOSFree($buff)"
		end

end
