note
	description: "test_econf application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECONF_TESTER

inherit
	ARGUMENTS
	CFG_EXTERNAL_DEFINES
	CFG_EXTERNALS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
			create h
			h := h.memory_alloc (c_config_t_size)
			print ("VERSION: " + version + nl)

			init
			destroy
		end

feature -- Constants

	nl: STRING
			-- the newline char as string
		do
			Result := "%N"
		end

	dot: CHARACTER
			-- the dot char
		do
			Result := '.'
		end


feature -- Library version

	version: STRING
			-- retrieve version constants
		do
			Result := c_major_version.out + dot.out + c_minor_version.out + dot.out + c_revision_version.out
		end

feature -- Initialization and deinitialization

	init
			-- Init libconfig handle
		require
			handle_attached: attached handle
		do
			c_config_init (handle)
		end

	destroy
			-- Deinit libconfig handle
		require
			handle_attached: attached handle
		do
			c_config_destroy (handle)
		end

feature -- Access

	handle: POINTER
			-- the libconfig handle
		do
			Result := h
		end

feature {NONE} -- Implementation

	h: POINTER

end
