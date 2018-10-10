note
	description: "Summary description for {GEOS_RELATE_BOUNDARY_NODE_RULES_CONSTANTS}."
	author: "Luca Paganotti - luca <dot> paganotti <at> gmail <dot> com"
	date: "$Date$"
	revision: "$Revision$"

class
	GEOS_RELATE_BOUNDARY_NODE_RULES_CONSTANTS

feature -- Constants

	-- These are for use with GEOSRelateBoundaryNodeRule (flags param)
	-- MOD2 and OGC are the same rule, and is the default used by GEOSRelatePattern

	geos_relate_boundary_mod2: NATURAL = 1
			--
	geos_relate_boundary_ogc: NATURAL = 1
			--
	geos_relate_boundary_endpoint: NATURAL = 2
			--
	geos_relate_boundary_multivalent_endpoint: NATURAL = 3
			--
	geos_relate_boundary_monovalent_endpoint: NATURAL = 4
			--

end
