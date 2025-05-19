note
	description: "Summary description for {MEAN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MEAN

inherit
	CURL_EASY_EXTERNALS
	CURL_OPT_CONSTANTS
	CURL_CODES

create
	make

feature {NONE} -- Initialization

	make (icao: STRING)
			-- Initialization for `Current'.
		do
			addr := icao
			create source.make_empty
			create dest.make_empty
			create type.make_empty
			create pos.make (0)
			create last_logged.make_now

			create tracks_path.make_empty
		end

feature -- Access

	addr:          STRING
	callsign:      detachable STRING
	source:        STRING
	dest:          STRING
	type:          STRING
	pos:           ARRAYED_LIST[POSITION]
	ground_speed:  DOUBLE
	track_angle:   DOUBLE
	vertical_rate: INTEGER
	last_logged:   DATE_TIME

	tracks_path:   STRING

feature -- Commands

	set_callsign (cs: STRING)
			--
		do
			callsign := cs
		end

	set_ground_speed (gs: DOUBLE)
			--
		do
			ground_speed := gs
		end

	set_track_angle (ta: DOUBLE)
			--
		do
			track_angle := ta
		end

	set_vertical_rate (vr: INTEGER)
			--
		do
			vertical_rate := vr
		end

	set_last_logged (ll: DATE_TIME)
			--
		do
			last_logged := ll
		end

	set_tracks_path (p: STRING)
			--
		do
			tracks_path := p
		end

	write: BOOLEAN
			-- write `Current' as a json object
		local
			l_filename: STRING
			l_mtext:    STRING
			l_f:        PLAIN_TEXT_FILE
		do
			if pos.count > 0 then
				l_filename := make_file_name
				if l_filename.is_empty then
					Result := false
				else
					create l_mtext.make_empty
					l_mtext.append ("{")
					l_mtext.append ("%"A%":%"" + addr + "%",")
					l_mtext.append ("%"CS%":")
					if attached {STRING} callsign as l_cs then
						if not l_cs.is_empty then
							l_mtext.append ("%"" + l_cs + "%",")
						else
							l_mtext.append ("%"NA%",")
						end
					else
						l_mtext.append ("%"NA%",")
					end
					l_mtext.append ("%"S%":")
					if not source.is_empty then
						l_mtext.append (source)
					else
						l_mtext.append("%"NA%"")
					end
					l_mtext.append (",")
					l_mtext.append ("%"D%":")
					if not dest.is_empty then
						l_mtext.append (dest)
					else
						l_mtext.append ("%"NA%"")
					end
					l_mtext.append (",")
					l_mtext.append ("%"AT%":")
					if not type.is_empty then
						l_mtext.append (type)
					else
						l_mtext.append ("%"NA%"")
					end
					 l_mtext.append (",")
					l_mtext.append ("%"POS%": [")
					from
						pos.start
					until
						pos.after
					loop
						l_mtext.append ("{")
						l_mtext.append ("%"X%":" + pos.item.x.out + ",")
						l_mtext.append ("%"Y%":" + pos.item.y.out + ",")
						l_mtext.append ("%"Z%":" + pos.item.z.out + ",")
						l_mtext.append ("%"T%":%"" + pos.item.t.out + "%",")
						l_mtext.append ("%"GS%":" + ground_speed.out + ",")
						l_mtext.append ("%"TA%":" + track_angle.out + ",")
						l_mtext.append ("%"VR%":" + vertical_rate.out)
						l_mtext.append ("}")
						if not pos.islast then
							l_mtext.append (",")
						end
						pos.forth
					end

					l_mtext.append ("]")

					l_mtext.append ("}")

					create l_f.make_open_read_append (l_filename)
					l_f.put_string (l_mtext)
					l_f.put_new_line
					l_f.flush
					l_f.close
				end
			else
				Result := false
			end
		end

feature -- Implementation

	make_file_name : STRING
			--
		local
			l_dt: DATE_TIME
		do
			create Result.make_empty
			if pos.count > 0 then
				-- can write somethig to file
				Result.append (tracks_path)
				l_dt := pos[1].t
				Result.append ("/" + l_dt.formatted_out ("yyyy[0]mm[0]dd"))
				Result.append (".json")
			end
		end

feature  -- Privates

	curl_handle: POINTER

	request_route
			--
		local
			url: STRING
			postfields: STRING
			slist: POINTER
			res: INTEGER
		do
			create url.make_empty
			url := "https://www.sara-servic.com/softech/Authentication"
			create postfields.make_empty

			if is_api_available then

				curl_handle := init

				if curl_handle /= Void then
					setopt_string (curl_handle, curlopt_url, url)
					setopt_string (curl_handle, curlopt_postfields, postfields)

					res := perform (curl_handle)

					if res /= curle_ok then
						io.put_string ("cURL error " + res.out)
					end
				end

			end

			cleanup (curl_handle)
		end

end
