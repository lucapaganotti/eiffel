-- enum wrapper
class POSTGRES_POLLING_STATUS_TYPE_ENUM_EXTERNAL

feature {ANY}

	is_valid_enum (a_value: INTEGER): BOOLEAN
			-- Is `a_value' a valid integer code for this enum ?
		do
			Result := a_value = pgres_polling_failed or a_value = pgres_polling_reading or a_value = pgres_polling_writing or a_value = pgres_polling_ok or a_value = pgres_polling_active
		end

	pgres_polling_failed: INTEGER
		external
			"C macro use <my_postgres.h>"
		alias
			"PGRES_POLLING_FAILED"
		end

	pgres_polling_reading: INTEGER
		external
			"C macro use <my_postgres.h>"
		alias
			"PGRES_POLLING_READING"
		end

	pgres_polling_writing: INTEGER
		external
			"C macro use <my_postgres.h>"
		alias
			"PGRES_POLLING_WRITING"
		end

	pgres_polling_ok: INTEGER
		external
			"C macro use <my_postgres.h>"
		alias
			"PGRES_POLLING_OK"
		end

	pgres_polling_active: INTEGER
		external
			"C macro use <my_postgres.h>"
		alias
			"PGRES_POLLING_ACTIVE"
		end

end
