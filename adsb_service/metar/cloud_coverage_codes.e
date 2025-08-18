note
	description: "Summary description for {CLOUD_COVERAGE_CODES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CLOUD_COVERAGE_CODES

feature -- Cloud coverage codes and meanings

	cloud_coverage_skc:                           STRING = "SKC"
	cloud_coverage_meaning_skc:                   STRING = "No cloud/Sky clear"

	cloud_coverage_ncd:                           STRING = "NCD"
	cloud_coverage_meaning_ncd:                   STRING = "Nill cloud detected"

	cloud_coverage_clr:                           STRING = "CLR"
	cloud_coverage_meaning_clr:                   STRING = "No clouds below 12.000 ft (3700 m)(US) or 25.000 ft (7600)(Canada)"

	cloud_coverage_nsc:                           STRING = "NSC"
	cloud_coverage_meaning_nsc:                   STRING = "No (nil) significant cloud"

	cloud_coverage_few:                           STRING = "FEW"
	cloud_coverage_meaning_few:                   STRING = "Few (1-2 oktas)"

	cloud_coverage_sct:                           STRING = "SCT"
	cloud_coverage_meaning_sct:                   STRING = "Scattered (3-4 oktas)"

	cloud_coverage_bkn:                           STRING = "BKN"
	cloud_coverage_meaning_bkn:                   STRING = "Broken (5-7 oktas)"

	cloud_coverage_ovc:                           STRING = "OVC"
	cloud_coverage_meaning_ovc:                   STRING = "Overcast (8 oktas --> full coverage)"

	cloud_coverage_tcu:                           STRING = "TCU"
	cloud_coverage_meaning_tcu:                   STRING = "Towering Cumulus Cloud (STC016TCU)"

	cloud_coverage_cb:                            STRING = "CB"
	cloud_coverage_meaning_cb:                    STRING = "Cumulonimbus cloud (FEW015CB)"

	cloud_coverage_vv:                            STRING = "VV"
	cloud_coverage_meaning_vv:                    STRING = "Vertical visibility (clouds cannot be seen because of fog or heavy precipitation)"

end
