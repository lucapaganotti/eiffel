note
	description: "Summary description for {METAR_DATA}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	METAR_DATA

inherit
	XML_CALLBACKS

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create data_source.make_empty
			create request_type.make_empty
			create errors.make_empty
			create warnings.make_empty
			create data.make (0)
		end

feature -- Access

	request_index: INTEGER
			-- Index request

	data_source:   STRING
			-- Data source

	request_type:  STRING
			-- Request type

	errors:        STRING
			-- Errors container, a STRING for the time being

	warnings:      STRING
			-- Warnings container, a STRING for the time being

	time_taken:    INTEGER
			-- Request time in ms

	data:          ARRAYED_LIST[METAR]
			-- METAR data stations list


feature -- Measurement

feature -- Status report

feature -- Status setting

	set_request_index (a_index: like request_index)
			-- Index request setter
		do
			request_index := a_index
		end

	set_data_source (a_data_source: like data_source)
			-- Data source
		do
			data_source := a_data_source
		end

	set_request_type (a_type: like request_type)
			-- Request type
		do
			request_type := a_type
		end

	set_errors (a_errors: like errors)
			-- Errors container, a STRING for the time being
		do
			errors := a_errors
		end

	set_warnings (a_warnings: like warnings)
			-- Warnings container, a STRING for the time being
		do
			warnings := a_warnings
		end

	set_time_taken (a_time_taken: like time_taken)
			-- Request time in ms
		do
			time_taken := a_time_taken
		end

	setdata (a_data: like data)
			-- METAR data stations list
		do
			data := a_data
		end

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- XML callbacks

	on_start
			--
		do

		end

	on_finish
			--
		do

		end

	on_xml_declaration (a_version: READABLE_STRING_32; an_encoding: detachable READABLE_STRING_32; a_standalone: BOOLEAN)
			--
		do

		end

	on_error (a_message: READABLE_STRING_32)
			--
		do

		end

	on_processing_instruction (a_name, a_content: READABLE_STRING_32)
			--
		do

		end

	on_comment (a_content: READABLE_STRING_32)
			--
		do

		end

	on_start_tag (a_namespace, a_prefix: detachable READABLE_STRING_32; a_local_part: READABLE_STRING_32)
			--
		do

		end

	on_attribute (a_namespace, a_prefix: detachable READABLE_STRING_32; a_local_part, a_value: READABLE_STRING_32)
			--
		do

		end

	on_start_tag_finish
			--
		do

		end

	on_end_tag (a_namespace, a_prefix: detachable READABLE_STRING_32; a_local_part: READABLE_STRING_32)
			--
		do

		end

	on_content (a_content: READABLE_STRING_32)
			--
		do

		end

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation



invariant
	invariant_clause: True -- Your invariant here

end
