note
	description: "Summary description for {GEOMETRY_NR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GEOMETRY_NR

inherit
	GEOS_OBJECT
	EXCEPTIONS

feature -- Binary predicates

	-- All returning 2 on exception, 1 on true, 0 on false

	disjoint (other: like Current): NATURAL
			-- returning 2 on exception, 1 on true, 0 on false
		require
			item_attached: attached item
			other_valid: other.is_valid = 1
		do
			Result := c_disjoint (item, other.as_pointer)
			if Result = 2 then
				raise ("Internal GEOS excetion")
			end
		end

	touches (other: like current): NATURAL
			-- returning 2 on exception, 1 on true, 0 on false
		require
			item_attached: attached item
			other_valid: other.is_valid = 1
		do
			Result := c_touches (item, other.as_pointer)
			if Result = 2 then
				raise ("Internal GEOS excetion")
			end
		end

	intersects (other: like Current): NATURAL
			-- returning 2 on exception, 1 on true, 0 on false
		require
			item_attached: attached item
			other_valid: other.is_valid = 1
		do
			Result := c_intersects (item, other.as_pointer)
			if Result = 2 then
				raise ("Internal GEOS excetion")
			end
		end

	crosses (other: like Current): NATURAL
			-- returning 2 on exception, 1 on true, 0 on false
		require
			item_attached: attached item
			other_valid: other.is_valid = 1
		do
			Result := c_crosses (item, other.as_pointer)
			if Result = 2 then
				raise ("Internal GEOS excetion")
			end
		end

	within (other: like Current): NATURAL
			-- returning 2 on exception, 1 on true, 0 on false
		require
			item_attached: attached item
			other_valid: other.is_valid = 1
		do
			Result := c_within (item, other.as_pointer)
			if Result = 2 then
				raise ("Internal GEOS excetion")
			end
		end

	contains (other: like Current): NATURAL
			-- returning 2 on exception, 1 on true, 0 on false
		require
			item_attached: attached item
			other_valid: other.is_valid = 1
		do
			Result := c_contains (item, other.as_pointer)
			if Result = 2 then
				raise ("Internal GEOS excetion")
			end
		end

	overlaps (other: like Current): NATURAL
			-- returning 2 on exception, 1 on true, 0 on false
		require
			item_attached: attached item
			other_valid: other.is_valid = 1
		do
			Result := c_overlaps (item, other.as_pointer)
			if Result = 2 then
				raise ("Internal GEOS excetion")
			end
		end

	equals (other: like Current): NATURAL
			-- returning 2 on exception, 1 on true, 0 on false
		require
			item_attached: attached item
			other_valid: other.is_valid = 1
		do
			Result := c_equals (item, other.as_pointer)
			if Result = 2 then
				raise ("Internal GEOS excetion")
			end
		end

	equals_exact (other: like Current; tolerance: DOUBLE): NATURAL
			-- returning 2 on exception, 1 on true, 0 on false
		require
			item_attached: attached item
			other_valid: other.is_valid = 1
		do
			Result := c_equals_exact (item, other.as_pointer, tolerance)
			if Result = 2 then
				raise ("Internal GEOS excetion")
			end
		end

	covers (other: like Current): NATURAL
			-- returning 2 on exception, 1 on true, 0 on false
		require
			item_attached: attached item
			other_valid: other.is_valid = 1
		do
			Result := c_covers (item, other.as_pointer)
			if Result = 2 then
				raise ("Internal GEOS excetion")
			end
		end

	covered_by (other: like Current): NATURAL
			-- returning 2 on exception, 1 on true, 0 on false
		require
			item_attached: attached item
			other_valid: other.is_valid = 1
		do
			Result := c_covered_by (item, other.as_pointer)
			if Result = 2 then
				raise ("Internal GEOS excetion")
			end
		end

feature -- Unary predicates

	-- All returning 2 on exception, 1 on true, 0 on false

	is_empty: NATURAL
			--
		require
			item_attached: attached item
		do
			Result := c_is_empty (item)
			if Result = 2 then
				raise ("Internal GEOS exception")
			end
		end

	is_simple: NATURAL
			--
		require
			item_attached: attached item
		do
			result := c_is_simple (item)
			if Result = 2 then
				raise ("Internal GEOS exception")
			end
		end

	is_ring: NATURAL
			--
		require
			item_attached: attached item
		do
			Result := c_is_ring (item)
			if Result = 2 then
				raise ("Internal GEOS exception")
			end
		end

	has_z: NATURAL
			--
		require
			item_attached: attached item
		do
			Result := c_has_z (item)
			if Result = 2 then
				raise ("Internal GEOS exception")
			end
		end

	is_closed: NATURAL
			--
		require
			item_attached: attached item
		do
			Result := c_is_closed (item)
			if Result = 2 then
				raise ("Internal GEOS exception")
			end
		end

feature -- Validity checking

	is_valid: NATURAL
			-- return 2 on exception, 1 on true, 0 on false
		require
			item_attached: attached item
		do
			Result := c_is_valid (item)
			if Result = 2 then
				raise ("Internal GEOS exception")
			end
		end

	is_valid_reason: STRING
			-- return NULL on exception, a string to GEOSFree otherwise
		require
			item_attached: attached item
		do
			create Result.make_from_c (c_is_valid_reason (item))
		end


	-- TODO: implement this
--	c_is_valid_detail (g: POINTER; flags: INTEGER; reason, location: POINTER): NATURAL
--			-- char GEOS_DLL GEOSisValidDetail(const GEOSGeometry* g, int flags, char** reason, GEOSGeometry** location)
--			-- Caller has the responsibility to destroy `reason' (GEOSFree)
--			-- and `location' (GEOSGeom_destroy) params
--			-- return 2 on exception, 1 when valid, 0 when invalid
--			-- Use enum GEOSValidFlags values for the flags param. I.e {GEOS_VALID_FLAGS_CONSTANTS}
--		external
--			"C inline use %"geos_c.h%""
--		alias
--			"return (unsigned int)GEOSisValidDetail($g, $flags, $reason, $location)"
--		end

feature -- Geometry info

	type: STRING
			-- Return NULL on exception, result must be freed by caller.
		require
			item_attached: attached item
		do
			create Result.make_from_c (c_type (item))
		end

	type_id: INTEGER
			-- Return -1 on exception
			-- See {GEOS_GEOM_TYPES_CONSTANTS}
		require
			item_attached: attached item
		do
			result := c_type_id (item)
		end

	srid: INTEGER
			-- Return 0 on exception
		require
			item_attached: attached item
		do
			Result := c_type_id (item)
		end

	geometries_number: INTEGER
			-- May be called on all geometries in GEOS 3.x, returns -1 on error and 1
			-- for non-multi geometries. Older GEOS versions only accept
			-- GeometryCollections or Multi* geometries here, and are likely to crash
			-- when fed simple geometries, so beware if you need compatibility with
			-- old GEOS versions.
		require
			item_attached: attached item
		do
			Result := c_get_num_geometries (item)
		end

	interior_rings: INTEGER
			-- Return -1 on exception
		require
			item_attached: attached item
		do
			Result := c_get_interior_rings_number (item)
		end

	points: INTEGER
			-- Return -1 on exception, Geometry must be a LineString.
		require
			item_attached: attached item
			correct_type_id: type_id = geos_linestring
		do
			Result := c_get_points_number (item)
		end

	x: DOUBLE
			-- Return -1 on exception, Geometry must be a Point.
		require
			item_attached: attached item
			correct_type: type_id = geos_point
		local
			r: INTEGER
		do
			r := c_get_x (item, $Result)
			if r = -1 then
				raise ("Internal GEOS exception")
			end
		end

	y: DOUBLE
			-- Return -1 on exception, Geometry must be a Point.
		require
			item_attached: attached item
			correct_type: type_id = geos_point
		local
			r: INTEGER
		do
			r := c_get_y (item, $Result)
			if r = -1 then
				raise ("Internal GEOS exception")
			end
		end

	coordinate_number: INTEGER
			-- Return -1 on exception
		require
			item_attached: attached item
		do
			Result := c_coordinate_number (item)
			if Result = -1 then
				raise ("Internal GEOS exception")
			end
		end

	dimensions: INTEGER
			-- Return 0 on exception (or empty geometry)
		require
			item_attached: attached item
		do
			Result := c_dimensions (item)
			if Result = 0 then
				raise ("Internal GEOS exception")
			end
		end

	coordinate_dimension: INTEGER
			-- Return 2 or 3.
		require
			item_attached: attached item
		do
			Result := c_coordinate_dimension (item)
		end




	-- TODO: implement this feature
--	c_get_interior_ring_n (g: POINTER; n: INTEGER): POINTER
--			-- const GEOSGeometry GEOS_DLL *GEOSGetInteriorRingN(const GEOSGeometry* g, int n)
--			-- Return NULL on exception, Geometry must be a Polygon.
--			-- Returned object is a pointer to internal storage: it must NOT be destroyed directly.
--		external
--			"C inline use %"geos_c.h%""
--		alias
--			"return (GEOSGeometry*)GEOSGetInteriorRingN($g, $n)"
--		end

	-- TODO: impement this feature
--	c_get_exterior_ring (g: POINTER): POINTER
--			-- const GEOSGeometry GEOS_DLL *GEOSGetExteriorRing(const GEOSGeometry* g)
--			-- Return NULL on exception, Geometry must be a Polygon.
--			-- Returned object is a pointer to internal storage: it must NOT be destroyed directly.
--		external
--			"C inline use %"geos_c.h%""
--		alias
--			"return (GEOSGeometry*)GEOSGetExteriorRing($g)"
--		end


feature -- Status setting

	set_srid (id: INTEGER)
			--
		require
			item_attached: attached item
		do
			c_set_srid (item, id)
		end

	-- TODO: implement this feature
--	c_get_geometry_n (g: POINTER; n: INTEGER): POINTER
--			-- const GEOSGeometry GEOS_DLL *GEOSGetGeometryN(const GEOSGeometry* g, int n)
--			-- Return NULL on exception.
--			-- Returned object is a pointer to internal storage: it must NOT be destroyed directly.
--			-- Up to GEOS 3.2.0 the input geometry must be a Collection, in
--			-- later version it doesn't matter (getGeometryN(0) for a single will return the input).
--		external
--			"C inline use %"geos_c.h%""
--		alias
--			"return (GEOSGeometry*)GEOSGetGeometryN($g, $n)"
--		end

feature -- Transformation

	normalize: INTEGER
			-- Return -1 on exception
		require
			item_attached: attached item
		do
			Result := c_normalize (item)
		end

	coordinate_sequence: COORDINATE_SEQUENCE_NR
			--
		do
			Result := coord_seq
		end












	-- TODO: implement this feature
--	c_get_coordinate_sequence (g: POINTER): POINTER
--			-- const GEOSCoordSequence GEOS_DLL *GEOSGeom_getCoordSeq(const GEOSGeometry* g)
--			-- Return NULL on exception.
--			-- Geometry must be a LineString, LinearRing or Point.
--		external
--			"C inline use %"geos_c.h%""
--		alias
--			"return (GEOSCoordSequence*)GEOSGeom_getCoordSeq($g)"
--		end

	-- TODO: implement this feature
--	c_point_n (g: POINTER; n: INTEGER): POINTER
--			-- GEOSGeometry GEOS_DLL *GEOSGeomGetPointN(const GEOSGeometry *g, int n)
--			-- Return NULL on exception.
--			-- Must be LineString and must be freed by called.
--		external
--			"C inline use %"geos_c.h%""
--		alias
--			"return GEOSGeomGetPointN($g, $n)"
--		end

	-- TODO: implement this feature
--	c_start_point (g: POINTER): POINTER
--			-- GEOSGeometry GEOS_DLL *GEOSGeomGetStartPoint(const GEOSGeometry *g)
--			-- Return NULL on exception.
--			-- Must be LineString and must be freed by called.
--		external
--			"C inline use %"geos_c.h%""
--		alias
--			"return GEOSGeomGetStartPoint($g)"
--		end

	-- TODO: implement this feature
--	c_end_point (g: POINTER): POINTER
--			-- GEOSGeometry GEOS_DLL *GEOSGeomGetEndPoint(const GEOSGeometry *g)
--			-- Return NULL on exception.
--			-- Must be LineString and must be freed by called.
--		external
--			"C inline use %"geos_c.h%""
--		alias
--			"return GEOSGeomGetEndPoint($g)"
--		end

feature -- Removal

	dispose
			--
		do
			c_geom_destroy (item)
		end

feature  {NONE} -- Implementation

	coord_seq: COORDINATE_SEQUENCE_NR

end
