note
	description: "Summary description for {PIGPIO_IF2}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PIGPIO_IF2

inherit
	PIGPIOD_IF2_EXTERNALS
	rename
		make as make_externals
	end

create
	make

feature -- Initialization

	make
			--
		do
			make_externals
			create events.make (0)
		end

feature -- Access

	events: ARRAYED_LIST[PIGPIO_EVENT]

feature -- Version

	pigpiod_if2_version: STRING
			--
		do
			Result := "pigpiod if2 version: " + c_pigpiod_if2_version.out
		end

	get_pigpio_version: STRING
			--
		require
			connected: running
		do
			Result := "pigpio version: "+ c_get_pigpio_version(handle).out
		end

feature -- Queries

	is_connected: BOOLEAN
			--
		do
			Result := handle >= 0
		end


feature -- Essential commands

	start (address: STRING port: INTEGER)
			--
		do
			handle := c_pigpiod_if2_start (address.area.base_address, port.out.area.base_address)
			if is_connected then
				running := true
			end
		end

	stop
			--
		do
			c_pigpiod_if2_stop (handle)
			running := false
		end

feature -- Basic commands

	read_gpio (gpio: NATURAL): INTEGER
			--
		require
			connected: running
		do
			Result := c_pigpiod_if2_read (handle, gpio)
		end

	write_gpio (gpio, level: NATURAL): BOOLEAN
			--
		require
			connected: running
		local
			l_res: INTEGER
		do
			l_res := c_pigpiod_if2_write (handle, gpio, level)
			Result := l_res = 0
		end

	set_mode (gpio, mode: NATURAL): BOOLEAN
			--
		require
			connected: running
		local
			l_res: INTEGER
		do
			l_res := c_pigpiod_if2_set_mode (handle, gpio, mode)
			Result := l_res = 0
		end

	get_mode (gpio: NATURAL): INTEGER
			--
		require
			connected: running
		do
			Result := c_pigpiod_if2_get_mode (handle, gpio)
		end

	set_pull_up_down (gpio, pud: NATURAL): INTEGER
			--
		require
			connected: running
		do
			Result := c_pigpiod_if2_set_pull_up_down (handle, gpio, pud)
		end

feature -- PWM

	set_pwm_dutycycle (user_gpio, dutycycle: NATURAL): BOOLEAN
			--
		require
			connected: running
		local
			l_res: INTEGER
		do
			l_res := c_pigpiod_if2_set_pwm_dutycycle (handle, user_gpio, dutycycle)
			Result := l_res = 0
		end

	get_pwm_dutycycle (user_gpio: NATURAL): INTEGER
			--
		require
			connected: running
		do
			Result := c_pigpiod_if2_get_pwm_dutycycle (handle, user_gpio)
		end

	set_pwm_range (user_gpio, range: NATURAL): BOOLEAN
			--
		require
			connected: running
		local
			l_res: INTEGER
		do
			l_res := c_pigpiod_if2_set_pwm_range (handle, user_gpio, range)
			Result := l_res = 0
		end

	get_pwm_range (user_gpio: NATURAL): INTEGER
			--
		require
			connected: running
		do
			Result := c_pigpiod_if2_get_pwm_range (handle, user_gpio)
		end

	get_pwm_real_range (user_gpio: NATURAL): INTEGER
			--
		require
			connected: running
		do
			Result := c_pigpiod_if2_get_pwm_real_range (handle, user_gpio)
		end

	set_pwm_frequency (user_gpio, frequency: NATURAL): BOOLEAN
			--
		require
			connected: running
		local
			l_res: INTEGER
		do
			l_res := c_pigpiod_if2_set_pwm_frequency (handle, user_gpio, frequency)
			Result := l_res = 0
		end

	get_pwm_frequency (user_gpio: NATURAL): INTEGER
			--
		require
			connected: running
		do
			Result := c_pigpiod_if2_get_pwm_frequency (handle, user_gpio)
		end

	set_servo_pulsewidth (user_gpio, pulsewidth: NATURAL): BOOLEAN
			--
		require
			connected: running
		local
			l_res: INTEGER
		do
			l_res := c_pigpiod_if2_set_servo_pulsewidth (handle, user_gpio, pulsewidth)
			Result := l_res = 0
		end

	get_servo_pulsewidth (user_gpio: NATURAL): INTEGER
			--
		require
			connected: running
		do
			Result := c_pigpiod_if2_get_servo_pulsewidth (handle, user_gpio)
		end

feature -- Intermediate commands

	gpio_trigger (user_gpio, pulse_len, level: NATURAL): INTEGER
			--
		require
			connected: running
		do
			Result := c_pigpiod_if2_gpio_trigger (handle, user_gpio, pulse_len, level)
		end

	set_watchdog (pi: INTEGER user_gpio, timeout: NATURAL): BOOLEAN
			-- int set_watchdog(int pi, unsigned user_gpio, unsigned timeout)
		require
			connected: running
		local
			l_res: INTEGER
		do
			l_res := c_pigpiod_if2_set_watchdog (handle, user_gpio, timeout)
			Result := l_res = 0
		end

	read_bank_1 (pi: INTEGER): NATURAL_32
			--
		require
			connected: running
		do
			Result := c_pigpiod_if2_read_bank_1 (handle)
		end

	read_bank_2 (pi: INTEGER): NATURAL_32
			--
		require
			connected: running
		do
			Result := c_pigpiod_if2_read_bank_2 (handle)
		end

	clear_bank_1 (bits: NATURAL_32): BOOLEAN
			--
		require
			connected: running
		local
			l_res: INTEGER
		do
			l_res := c_pigpiod_if2_clear_bank_1 (handle, bits)
			Result := l_res = 0
		end

	clear_bank_2 (bits: NATURAL_32): BOOLEAN
			--
		require
			connected: running
		local
			l_res: INTEGER
		do
			l_res := c_pigpiod_if2_clear_bank_2 (handle, bits)
			Result := l_res = 0
		end

	set_bank_1 (bits: NATURAL_32): BOOLEAN
			--
		require
			connected: running
		local
			l_res: INTEGER
		do
			l_res := c_pigpiod_if2_set_bank_1 (handle, bits)
			Result := l_res = 0
		end

	set_bank_2 (bits: NATURAL_32): BOOLEAN
			--
		require
			connected: running
		local
			l_res: INTEGER
		do
			l_res := c_pigpiod_if2_set_bank_2 (handle, bits)
			Result := l_res = 0
		end

	callback (user_gpio: NATURAL edge: NATURAL func: POINTER): INTEGER
			--
		require
			connected: running
		local
			cid: INTEGER
		do
			cid := c_pigpiod_if2_callback (handle, user_gpio, edge, func)
			if cid >= 0 then
				callbacks.extend (cid)
				Result := cid
			end
		end

	callback_ex (user_gpio: NATURAL edge: NATURAL func: POINTER userdata: POINTER): INTEGER
			--
		require
			connected: running
		local
			cid: INTEGER
		do
			cid := c_pigpiod_if2_callback_ex (handle, user_gpio, edge, func, userdata)
			if cid >= 0 then
				callbacks.extend (cid)
				Result := cid
			end
		end

	callback_cancel (callback_id: INTEGER): BOOLEAN
			--
		require
			connected: running
		local
			l_res: INTEGER
		do
			l_res := c_pigpiod_if2_callback_cancel (callback_id)
			if l_res = 0 then
				callbacks.prune (callback_id)
			end
			Result := l_res = 0
		end

	wait_for_edge (pi: INTEGER user_gpio: NATURAL edge: NATURAL timeout: DOUBLE): BOOLEAN
			-- int wait_for_edge(int pi, unsigned user_gpio, unsigned edge, double timeout)
		require
			connected: running
		local
			l_res: INTEGER
		do
			l_res := c_pigpiod_if2_wait_for_edge (handle, user_gpio, edge, timeout)
			Result := l_res = 0
		end

feature -- Callbacks

	either_edge_callback: POINTER
			--
		do
			Result := c_pigpiod_if2_get_either_edge_callback
		end

	rising_edge_callback: POINTER
			--
		do
			Result := c_pigpiod_if2_get_rising_edge_callback
		end

	falling_edge_callback: POINTER
			--
		do
			Result := c_pigpiod_if2_get_falling_edge_callback
		end

	either_edge_callback_ex: POINTER
			--
		do
			Result := c_pigpiod_if2_get_either_edge_callback_ex
		end

	rising_edge_callback_ex: POINTER
			--
		do
			Result := c_pigpiod_if2_get_rising_edge_callback_ex
		end

	falling_edge_callback_ex: POINTER
			--
		do
			Result := c_pigpiod_if2_get_falling_edge_callback_ex
		end

feature -- Events

	add_event (e: PIGPIO_EVENT)
			--
		require
			e_attached: attached e
		do
			events.extend (e)
		ensure
			event_added: events.has (e)
		end

	remove_event(e: PIGPIO_EVENT): BOOLEAN
			--
		require
			e_attached: attached e
		do
			if events.has (e) then
				events.prune (e)
				Result := true
			end
		end

	trigger_event(e: PIGPIO_EVENT): BOOLEAN
			--
		require
			e_attached: attached e and running
		local
			l_res: INTEGER
		do
			l_res := c_pigpiod_if2_event_trigger (handle, e.id)
			Result := l_res = 0
		end

	event_callback_example: POINTER
			--
		do
			Result := c_pigpiod_if2_get_event_callback_example
		end

	event_callback_ex_example: POINTER
			--
		do
			Result := c_pigpiod_if2_get_event_callback_ex_example
		end

	event_callback (event: PIGPIO_EVENT): INTEGER
			--
		require
			connected: running
		local
			cid: INTEGER
		do
			if cid >= 0 then
				event_callbacks.extend (event.callback_id)
				Result := cid
			end
		end

	event_callback_ex (event: PIGPIO_EVENT userdata: POINTER): INTEGER
			--
		require
			connected: running
		local
			cid: INTEGER
		do
			cid := c_pigpiod_if2_event_callback_ex (handle, event.id, event.callback, userdata)
			if cid >= 0 then
				event_callbacks.extend (cid)
				Result := cid
			end
		end

	event_callback_cancel (callback_id: INTEGER): BOOLEAN
			--
		require
			connected: running
		local
			l_res: INTEGER
		do
			l_res := c_pigpiod_if2_event_callback_cancel (callback_id.as_natural_32)
			if l_res = 0 then
				event_callbacks.prune (callback_id)
				Result := l_res = 0
			end
		end

	wait_for_event (event: PIGPIO_EVENT timeout: DOUBLE): BOOLEAN
			--
		require
			connected: running
		local
			l_res: INTEGER
		do
			l_res := c_pigpiod_if2_wait_for_event (handle, event.id, timeout)
			Result := l_res = 0
		end

end
