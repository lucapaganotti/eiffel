note
	description: "test application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_APP

	inherit
		EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			host: STRING
		do
			create host.make_from_string ("nov03.dyndns.org")
			create conn.make_with_host_and_port (host, 30003)
			create tracker.make_tracker
			tracker.set_connector (conn)


			conn.connect
			if conn.connected then
				print ("Socket connected%N")
				tracker.join
				tracker.launch
				tracker.run
				from
				until false
				loop
					launch ("clear")
					sleep (100000000)
					--io.put_string ("Sleeping for 10 seconds%N")
					--tracker.pause
					dump_tracked_aircrafts
					sleep (10000000000)
					--io.put_string ("Pause tracker for 15 seconds%N")
					--sleep (15 * 1000000000)
					--tracker.run
					--io.put_string ("Run tracker for 10 seconds%N")
					--sleep (10 * 1000000000)
					--dump_tracked_aircrafts
				end
			else
				io.put_string (conn.error)
			end

			conn.disconnect
		rescue
			io.put_string ("Network error, sleeping for a while ...%N")
			sleep (2000000000)
			io.put_string ("Retry now%N")
			retry
		end

feature -- Basic operations

	dump_tracked_aircrafts
			--
		local
			map: STRING_TABLE[AIRCRAFT]
			trk: INTEGER
			fi: FORMAT_INTEGER
		do
			create fi.make (2)
			create map.make (0)
			map := tracker.aircraft_map.twin
			from map.start
			until map.after
			loop
				if not map.item_for_iteration.callsign.same_string_general ({MSG_CONSTANTS}.not_assigned) then
					io.put_string (fi.formatted (trk + 1) + " ")
					map.item_for_iteration.debug_output
					trk := trk +1
				end
				map.forth
			end
			io.put_string ("Aircrafts: " + trk.out + "/" + map.count.out + "%N")
		end

feature {NONE} -- Implementation

	tracker: TRACKER
	conn:    SBS_CONNECTOR

end
