note
	description: "Summary description for {AUTH_TOKEN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AUTH_TOKEN

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create token.make_empty
			create expiry.make_now
		end

	make_with_params (t: STRING e: DATE_TIME)
			--
		do
			token  := t
			expiry := e
		end

feature -- Access

	token:  STRING
	expiry: DATE_TIME

	is_expired: BOOLEAN
			--
		do
			Result := create {DATE_TIME}.make_now > expiry
		end

feature -- Commands

	set_token (t: STRING)
			--
		require
			t_attached: attached t
		do
			token := t
		ensure
			token_set: token.is_equal (t)
		end

	set_expiry (e: DATE_TIME)
			--
		require
			e_attached: attached e
		do
			expiry := e
		ensure
			expiry_set: expiry = e
		end

end
