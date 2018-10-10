note
	description: "Summary description for {GEOS_GEOM_TYPES_CONSTANTS}."
	author: "Luca Paganotti - luca <dot> paganotti <at> gmail <dot> com"
	date: "$Date$"
	revision: "$Revision$"

class
	GEOS_GEOM_TYPES_CONSTANTS

feature -- Constants

	geos_point: INTEGER = 0
			-- GEOSGeomTypes --> GEOS_POINT
	geos_linestring: INTEGER = 1
			-- GEOSGeomTypes --> GEOS_LINESTRING
	geos_linearring: INTEGER = 2
			-- GEOSGeomTypes --> GEOS_LINEARRING
	geos_polygon: INTEGER = 3
			-- GEOSGeomTypes --> GEOS_POLYGON
	geos_multipoint: INTEGER = 4
			-- GEOSGeomTpes --> GEOS_MULTIPOINT
	geos_multilinestring: INTEGER = 5
			-- GEOSGeomTypes --> GEOS_MULTILINESTRING
	geos_multipolygon: INTEGER = 6
			-- GEOSGeomTypes --> GEOS_MULTIPOLYGON
	geos_geometrycollection: INTEGER = 7
			-- GEOSGeomTypes --> GEOS_GEOMETRYCOLLECTION

end
