note
	description: "test_postgres application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	PG_TEST

inherit
	ARGUMENTS
	LIBPQ_FE_FUNCTIONS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			connstr, query, msg, fname, fvalue: STRING
			dbh: POINTER
			status: POINTER
			res: POINTER
			r, i, tnum, fnum : INTEGER
		do
			create connstr.make_from_string ("host=localhost port=5432 user=buck password=chi66rone; dbname=buck connect_timeout=10")
			create query.make_from_string ("select * from spatial_ref_sys;")
			create msg.make_empty
			create fname.make_empty
			create fvalue.make_empty

			--| Add your code here
			print ("Hello postgresql from eiffel !%N")

			dbh := pqconnectdb (connstr)
			io.put_string ("Status code: " + pqstatus (dbh).out + "%N")
			io.put_string ("Protocol version: " + pqprotocol_version (dbh).out + "%N")
			io.put_string ("Server version: " + pqserver_version (dbh).out + "%N")

			res := pqexec (dbh, query)
			--res := pqget_result (dbh)
			io.put_string ("Result status: " + pqresult_status (res).out + "%N")
			tnum := pqntuples (res)
			io.put_string ("Got " + tnum.out + " tuples%N")
			fnum := pqnfields (res)
			io.put_string ("Each row has " + fnum.out + " fields%N")
			io.put_string ("Fields list:%N")
			from i := 0
			until i = fnum
			loop
				fname.from_c (pqfname (res, i))
				io.put_string ("%Tfield " + i.out + " --> " + fname + "%N")
				i := i + 1
			end

			from r := 0
			until r = tnum
			loop
				msg := ""
				from i := 0
				until i = fnum
				loop
					fvalue.from_c (pqgetvalue (res, r, i))
					msg.append (fvalue)
					msg.append (" ")
					i := i + 1
				end
				msg.append ("%N")
				io.put_string (msg)
				r := r + 1
			end

--			msg.from_c (pqresult_error_message (status))
--			io.put_string ("Error: " + msg + "%N")

			pqfinish (dbh)
		end

end
