note
	description: "Summary description for {GEOS_BYTE_ORDERS_CONSTANTS}."
	author: "Luca Paganotti - luca <dot> paganotti <at> gmail <dot> com"
	date: "$Date$"
	revision: "$Revision$"

class
	GEOS_BYTE_ORDERS_CONSTANTS

feature -- Constants

	geos_wkb_xdr: INTEGER = 0
			-- GEOSByteOrders --> GEOS_WKB_XDR
	geos_wkb_ndr: INTEGER = 1
			-- GEOSByteOrders --> GEOS_WKB_NDR

end
