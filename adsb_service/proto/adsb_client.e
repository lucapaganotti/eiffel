note
	description: "Summary description for {ADSB_CLIENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ADSB_CLIENT

	inherit
		EXCEPTIONS

feature -- Access

	now:                     DATE_TIME
	last_check:              DATE_TIME
	last_msg:                DATE_TIME

	host:                    STRING
	tracks_path:             STRING
	to:                      INTEGER_32
	max_seconds_between_msg: INTEGER_32

	logger:                  LOG_LOGGING_FACILITY
	--auth_token:         AUTH_TOKEN
	routes_url:              STRING
	routes_url2:             STRING
	pj4geo:                  STRING
	pj4proj:                 STRING
	ref_arpt:                STRING
	mrt:                     POINT
	distance_threshold:      INTEGER

	format_double:           FORMAT_DOUBLE

	socket:                  detachable ADSB_NETWORK_STREAM_SOCKET

	means:                   HASH_TABLE [MEAN, STRING]

	running:                 BOOLEAN

feature -- Status

	is_endpoint_reachable: BOOLEAN
			--
		local
			af: INET_ADDRESS_FACTORY
		do
			create af
			Result := attached af.create_from_name (host)
		end

feature -- Operations

	start
			--
		deferred end

	stop
			--
		deferred end

	process
			--
		deferred end

	clean_map
			--
		local
			l_now: DATE_TIME
			l_delta_t: INTERVAL [DATE_TIME]
			l_m: MEAN
		do
			create l_now.make_now
			logger.write_information ("clean map started @ " + l_now.formatted_out ("yyyy/[0]mm/[0]dd [0]hh:[0]mi:[0]ss.ff3") + " " + means.count.out)
			from
				means.start
			until
				means.after
			loop
				l_m := means.item_for_iteration
				create l_delta_t.make (l_m.last_logged, l_now)
				if attached {DATE_TIME_DURATION} l_delta_t.duration as l_d then
					l_d.set_origin_date_time (create {DATE_TIME}.make (1970, 1, 1, 0, 0, 0))
				    if l_d.seconds_count > to then
				    	if l_m.pos.count > 0 then
				    		-- save mean to file
							logger.write_information ("write " + l_m.addr + " to disk")
							if attached {STRING} l_m.callsign as l_cs then
								logger.write_information (l_m.addr + " " + l_cs + " [" + l_m.pos.count.out + "] " +
								                          l_m.squawk.out + " " + l_m.alerted.out + " " + l_m.emergency.out + " " +
								                          l_m.on_ground.out)
							end

							if l_m.write then
								logger.write_information (l_m.addr + " WRITTEN to disk")
							else
								logger.write_warning (l_m.addr + " NOT WRITTEN to disk")
							end
				    	end

						-- remove mean from map
						logger.write_information ("remove " + l_m.addr + " from map")
						means.remove (l_m.addr)
						logger.write_information (l_m.addr + " REMOVED from map")
					end
				end
				if not means.after then
					means.forth
				end
			end
			create l_now.make_now
			logger.write_information ("clean map finished @ " + l_now.formatted_out ("yyyy/[0]mm/[0]dd [0]hh:[0]mi:[0]ss.ff3") + " " + means.count.out)
		end

feature -- Commands

	set_host (h: STRING)
			--
		require
			h_attached: attached h
		do
			host := h
		ensure
			host_set: host = h
		end

	set_port (p: INTEGER)
			--
		deferred
		end

	set_tracks_path (tp: STRING)
			--
		do
			tracks_path := tp
		end

	set_means (m: HASH_TABLE[MEAN, STRING])
			--
		require
			m_attached: attached m
		do
			means := m
		ensure
			means_set: means = m
		end

	set_timeout (t: INTEGER_32)
			--
		do
			to := t
		end

	set_max_seconds_between_msg (t: INTEGER_32)
			--
		do
			max_seconds_between_msg := t
		end

	set_logger (l: LOG_LOGGING_FACILITY)
			--
		do
			logger := l
		end

	-- set_auth_token (t: AUTH_TOKEN)
	--		--
	--	require
	--		token_attached_and_valid: attached t and then
	--			(attached t.token and then not t.token.is_empty and then
	--			 attached t.expiry)
	--	do
	--		auth_token := t
	--		if means.count > 0 then
	--			from means.start
	--			until means.after
	--			loop
	--				means.item_for_iteration.set_auth_token (t)
	--				means.forth
	--			end
	--		end
	--	ensure
	--		token_set: auth_token = t
	--	end

	set_routes_url (u: STRING)
			--
		require
			url_attached_and_valid: attached u and then not u.is_empty
		do
			routes_url := u
		ensure
			routes_url_set: routes_url = u
		end

	set_routes_url2 (u: STRING)
			--
		require
			url_attached_and_valid: attached u and then not u.is_empty
		do
			routes_url2 := u
		ensure
			routes_url2_set: routes_url2 = u
		end

	set_pj4geo (pj: STRING)
			--
		require
			pj_attached_and_valid: attached pj and then not pj.is_empty
		do
			pj4geo := pj
		ensure
			pj4geo_set: pj4geo = pj
		end

	set_pj4proj (pj: STRING)
			--
		require
			pj_attached_and_valid: attached pj and then not pj.is_empty
		do
			pj4proj := pj
		ensure
			pj4proj_set: pj4geo = pj
		end

	set_mrt (p: POINT)
			--
		require
			p_attached_and_valid: attached p and then p.is_valid
		do
			mrt := p
		ensure
			mrt_set: mrt = p
		end

	set_distance_threshold (d: INTEGER)
			--
		require
			d_valid: d >= d.min_value and d <= d.max_value
		do
			distance_threshold := d
		ensure
			distance_threshold_set: distance_threshold = d
		end

	set_reference_airport (a: STRING)
			--
		require
			a_attached: attached a
		do
			ref_arpt := a
		ensure
			airport_set: ref_arpt = A
		end

end
