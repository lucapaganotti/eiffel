note
	description: "Summary description for {TRACKER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TRACKER

inherit
	WORKER_THREAD
	redefine
		make
	end

	EXCEPTIONS

create
	make,
	make_tracker

feature {NONE} -- Initialization

	make (a_action: PROCEDURE)
			--
		do
			Precursor (a_action)
			create map.make (0)
		end

	make_tracker
			-- Initialization for `Current'.
		do
			make (agent run_tracker)
			create map.make (0)
		end

feature -- Access

	connector: detachable SBS_CONNECTOR
			--
		do
			Result := conn
		end

	aircraft_map: STRING_TABLE[AIRCRAFT]
			--
		do
			Result := map
		end

	running: BOOLEAN
			--
		do
			Result := alive
		end

	paused: BOOLEAN
			--
		do
			Result := not alive
		end

feature -- Measurement

feature -- Status report

	connected: BOOLEAN
			--
		require
			attached_connector: attached connector
		do
			if attached conn as c then
				Result := c.connected
			end
		end

feature -- Status setting

	set_connector (c: SBS_CONNECTOR)
			--
		require
			attached_c: attached c
		do
			conn := c
		end

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

	run
			--
		do
			alive := True
		end

	pause
			--
		do
			alive := False
		end

	run_tracker
			--
		local
			msg:  SBS_MSG
			acft: AIRCRAFT
			beat: BEAT
		do
			create msg.make
			from
			until false --not connected
			loop
				if running then
					if attached conn as c and then c.connected then
						c.check_network
						c.read_line
						msg.clear
						msg.set_text (c.last_string)
						c.raw_socket.last_string.wipe_out
						msg.parse
						if msg.hex.is_empty then
							if c.has_error or c.raw_socket.network then
								io.put_string ("Socket error: " + c.raw_socket.error_number.out + " - " + c.error + "%N")
								sleep (5000000000)
								io.put_string ("Reconnect socket ...%N")
								c.reconnect
							end
						end
						if not map.has (msg.hex)  then
							-- aircraft not in map
							create acft.make
							acft.set_hex (msg.hex)
							if not msg.callsign.is_empty then
								acft.set_callsign (msg.callsign)
							end
							acft.set_squawk (msg.squawk)
							acft.set_alert (msg.alert)
							acft.set_emergency (msg.emergency)
							acft.set_spi (msg.spi)
							acft.set_on_ground (msg.on_ground)
							if msg.type.same_string ({MSG_TYPE}.transmission) and msg.transmission = {TRANSMISSION_TYPE}.airborne_position then
								create beat.make
								beat.set_longitude (msg.longitude)
								beat.set_latitude (msg.latitude)
								beat.set_elevation (msg.altitude)
								beat.set_time (create {DATE_TIME}.make_by_date_time (msg.date_msg_generated, msg.time_msg_generated))
								if acft.beats.count = 0 then
									acft.beats.extend (beat)
								else
									if not beat.position.is_equal (acft.beats.last.position) then
										acft.beats.extend (beat)
									end
								end
							end
							map.extend (acft.twin, acft.hex.twin)
						else
							-- aircraft already in map
							acft := map.item (msg.hex)
							if attached acft as a then
								if a.callsign.same_string_general ({MSG_CONSTANTS}.not_assigned) and then not msg.callsign.is_empty then
									a.set_callsign (msg.callsign)
								end
								if msg.squawk /= 0 then
									a.set_squawk (msg.squawk)
								end
								if msg.alert /= 0 then
									a.set_alert (msg.alert)
								end
								if msg.emergency /= 0 then
									a.set_emergency (msg.emergency)
								end
								if msg.spi /= 0 then
									a.set_spi (msg.spi)
								end
								if msg.on_ground /= 0 then
									a.set_on_ground (msg.on_ground)
								end
								if msg.type.same_string ({MSG_TYPE}.transmission) and msg.transmission = {TRANSMISSION_TYPE}.airborne_position then
									create beat.make
									beat.set_longitude (msg.longitude)
									beat.set_latitude (msg.latitude)
									beat.set_elevation (msg.altitude.to_double)
									beat.set_time (create {DATE_TIME}.make_by_date_time (msg.date_msg_generated, msg.time_msg_generated))
									if a.beats.count = 0 then
										a.beats.extend (beat)
									else
										if not beat.position.is_equal (a.beats.last.position) then
											a.beats.extend (beat)
										end
									end
								end
								map.replace (a, msg.hex)
							end
						end
					else
						if attached conn as c then
							if not c.connected then
								c.connect
							end
						end
					end
				else
					sleep (1000000000)
				end
			end
		rescue
			io.put_string ("Network problem, sleeping for a while ...%N")
			sleep (10000000000)
			io.put_string ("Retry now%N")
			retry
		end

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	conn: detachable SBS_CONNECTOR

	map: STRING_TABLE[AIRCRAFT]
			--

	alive: BOOLEAN
			--

invariant
	invariant_clause: True -- Your invariant here

end
