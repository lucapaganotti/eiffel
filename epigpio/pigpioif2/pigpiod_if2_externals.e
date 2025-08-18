note
	description: "Summary description for {PIGPIOD_IF2_EXTERNALS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PIGPIOD_IF2_EXTERNALS

inherit
	PIGPIO_CONSTANTS

create
	make

feature -- Initialization

	make
			--
		do
			create callbacks.make (0)
			create event_callbacks.make (0)
		end

feature {PIGPIO_IF2}-- C Utilities

	c_pigpiod_if2_version: INTEGER
			-- #define PIGPIOD_IF2_VERSION 17
		external
			"C inline use %"pigpiod_if2.h%""
		alias
			"return PIGPIOD_IF2_VERSION;"
		end

	c_get_pigpio_version (pi: INTEGER): NATURAL_32
			-- uint32_t get_pigpio_version(int pi)
		external
			"C inline use %"pigpiod_if2.h%""
		alias
			"return get_pigpio_version($pi);"
		end

	c_pigpiod_if2_pigpio_error (err: INTEGER): POINTER
			-- char *pigpio_error(int errnum)
		external
			"C inline use %"pigpiod_if2.h%""
		alias
			"return pigpio_error($err);"
		end

feature {PIGPIO_IF2} -- C Essential commands

	c_pigpiod_if2_start (address, port: POINTER): INTEGER
			-- int pigpio_start(const char *addrStr, const char *portStr)
		external
			"C inline use %"pigpiod_if2.h%""
		alias
			"return pigpio_start ($address, $port);"
		end

	c_pigpiod_if2_stop (h: INTEGER)
			-- void pigpio_stop(int pi)
		external
			"C inline use %"pigpiod_if2.h%""
		alias
			"pigpio_stop ($h);"
		end

feature {PIGPIO_IF2} -- C Basic commands

	c_pigpiod_if2_read (pi: INTEGER gpio: NATURAL): INTEGER
			-- int gpio_read(int pi, unsigned gpio)
		external
			"C inline use %"pigpiod_if2.h%""
		alias
			"return gpio_read ($pi, $gpio);"
		end

	c_pigpiod_if2_write (pi: INTEGER gpio, level: NATURAL): INTEGER
			-- int gpio_write(int pi, unsigned gpio, unsigned level)
		external
			"C inline use %"pigpiod_if2.h%""
		alias
			"return gpio_write ($pi, $gpio, $level);"
		end

	c_pigpiod_if2_set_mode (pi: INTEGER gpio, mode: NATURAL): INTEGER
			-- int set_mode(int pi, unsigned gpio, unsigned mode)
		external
			"C inline use %"pigpiod_if2.h%""
		alias
			"return set_mode ($pi, $gpio, $mode);"
		end

	c_pigpiod_if2_get_mode (pi: INTEGER gpio: NATURAL): INTEGER
			-- int get_mode(int pi, unsigned gpio)
		external
			"C inline use %"pigpiod_if2.h%""
		alias
			"return get_mode ($pi, $gpio)"
		end

	c_pigpiod_if2_set_pull_up_down (pi: INTEGER gpio, pud: NATURAL): INTEGER
			-- int set_pull_up_down(int pi, unsigned gpio, unsigned pud)
		external
			"C inline use %"pigpiod_if2.h%""
		alias
			"return set_pull_up_down ($pi, $gpio, $pud);"
		end

feature {PIGPIO_IF2} -- C PWM

	c_pigpiod_if2_set_pwm_dutycycle (pi: INTEGER user_gpio, dutycycle: NATURAL): INTEGER
			-- int set_PWM_dutycycle(int pi, unsigned user_gpio, unsigned dutycycle)
		external
			"C inline use %"pigpiod_if2.h%""
		alias
			"return set_PWM_dutycycle ($pi, $user_gpio, $dutycycle);"
		end

	c_pigpiod_if2_get_pwm_dutycycle (pi: INTEGER user_gpio: NATURAL): INTEGER
			-- int get_PWM_dutycycle(int pi, unsigned user_gpio)
		external
			"C inline use %"pigpiod_if2.h%""
		alias
			"return get_PWM_dutycycle ($pi, $user_gpio);"
		end

	c_pigpiod_if2_set_pwm_range (pi: INTEGER user_gpio, range: NATURAL): INTEGER
			-- int set_PWM_range(int pi, unsigned user_gpio, unsigned range)
		external
			"C inline use %"pigpiod_if2.h%""
		alias
			"return set_PWM_range ($pi, $user_gpio, $range);"
		end

	c_pigpiod_if2_get_pwm_range (pi: INTEGER user_gpio: NATURAL): INTEGER
			-- int get_PWM_range(int pi, unsigned user_gpio)
		external
			"C inline use %"pigpiod_if2.h%""
		alias
			"return get_PWM_range ($pi, $user_gpio);"
		end

	c_pigpiod_if2_get_pwm_real_range (pi: INTEGER user_gpio: NATURAL): INTEGER
			-- int get_PWM_real_range(int pi, unsigned user_gpio)
		external
			"C inline use %"pigpiod_if2.h%""
		alias
			"return get_PWM_real_range ($pi, $user_gpio);"
		end

	c_pigpiod_if2_set_pwm_frequency (pi: INTEGER user_gpio, frequency: NATURAL): INTEGER
			-- int set_PWM_frequency(int pi, unsigned user_gpio, unsigned frequency)
		external
			"C inline use %"pigpiod_if2.h%""
		alias
			"return set_PWM_frequency ($pi, $user_gpio, $frequency);"
		end

	c_pigpiod_if2_get_pwm_frequency (pi: INTEGER user_gpio: NATURAL): INTEGER
			-- int get_PWM_range(int pi, unsigned user_gpio)
		external
			"C inline use %"pigpiod_if2.h%""
		alias
			"return get_PWM_frequency ($pi, $user_gpio);"
		end

	c_pigpiod_if2_set_servo_pulsewidth (pi: INTEGER user_gpio, pulsewidth: NATURAL): INTEGER
			-- int set_servo_pulsewidth(int pi, unsigned user_gpio, unsigned pulsewidth)
		external
			"C inline use %"pigpiod_if2.h%""
		alias
			"return set_servo_pulsewidth ($pi, $user_gpio, $pulsewidth);"
		end

	c_pigpiod_if2_get_servo_pulsewidth (pi: INTEGER user_gpio: NATURAL): INTEGER
			-- int get_servo_pulsewidth(int pi, unsigned user_gpio)
		external
			"C inline use %"pigpiod_if2.h%""
		alias
			"return get_servo_pulsewidth ($pi, $user_gpio);"
		end

feature {PIGPIO_IF2} -- C Intermediate commands

	c_pigpiod_if2_gpio_trigger (pi: INTEGER user_gpio, pulse_len, level: NATURAL): INTEGER
			-- int gpio_trigger(int pi, unsigned user_gpio, unsigned pulseLen, unsigned level)
		external
			"C inline use %"pigpiod_if2.h%""
		alias
			"return gpio_trigger ($pi, $user_gpio, $pulse_len, $level);"
		end

	c_pigpiod_if2_read_bank_1 (pi: INTEGER): NATURAL_32
			-- uint32_t read_bank_1(int pi)
		external
			"C inline use %"pigpiod_if2.h%""
		alias
			"return read_bank_1 ($pi);"
		end

	c_pigpiod_if2_read_bank_2 (pi: INTEGER): NATURAL_32
			-- uint32_t read_bank_2(int pi)
		external
			"C inline use %"pigpiod_if2.h%""
		alias
			"return read_bank_2 ($pi);"
		end

	c_pigpiod_if2_clear_bank_1 (pi: INTEGER bits: NATURAL_32): INTEGER
			-- int clear_bank_1(int pi, uint32_t bits)
		external
			"C inline use %"pigpiod_if2.h%""
		alias
			"return clear_bank_1 ($pi, $bits)"
		end

	c_pigpiod_if2_clear_bank_2 (pi: INTEGER bits: NATURAL_32): INTEGER
			-- int clear_bank_1(int pi, uint32_t bits)
		external
			"C inline use %"pigpiod_if2.h%""
		alias
			"return clear_bank_2 ($pi, $bits);"
		end

	c_pigpiod_if2_set_bank_1 (pi: INTEGER bits: NATURAL_32): INTEGER
			-- int set_bank_1(int pi, uint32_t bits)
		external
			"C inline use %"pigpiod_if2.h%""
		alias
			"return set_bank_1 ($pi, $bits);"
		end

	c_pigpiod_if2_set_bank_2 (pi: INTEGER bits: NATURAL_32): INTEGER
			-- int set_bank_1(int pi, uint32_t bits)
		external
			"C inline use %"pigpiod_if2.h%""
		alias
			"return set_bank_2 ($pi, $bits);"
		end

	c_pigpiod_if2_callback (pi: INTEGER user_gpio: NATURAL edge: NATURAL func: POINTER): INTEGER
			-- int callback(int pi, unsigned user_gpio, unsigned edge, CBFunc_t f)
		external
			"C inline use %"pigpiod_if2.h%""
		alias
			"return callback($pi, $user_gpio, $edge, $func);"
		end

	c_pigpiod_if2_callback_ex (pi: INTEGER user_gpio: NATURAL edge: NATURAL func: POINTER userdata: POINTER): INTEGER
			-- int callback_ex(int pi, unsigned user_gpio, unsigned edge, CBFunc_t f, void* userdata)
		external
			"C inline use %"pigpiod_if2.h%""
		alias
			"return callback_ex($pi, $user_gpio, $edge, $func, $userdata);"
		end

	c_pigpiod_if2_callback_cancel (callback_id: INTEGER): INTEGER
			-- int callback_cancel(unsigned callback_id)
		external
			"C inline use %"pigpiod_if2.h%""
		alias
			"return callback_cancel($callback_id);"
		end

	c_pigpiod_if2_wait_for_edge (pi: INTEGER user_gpio: NATURAL edge: NATURAL timeout: DOUBLE): INTEGER
			-- int wait_for_edge(int pi, unsigned user_gpio, unsigned edge, double timeout)
		external
			"C inline use %"pigpiod_if2.h%""
		alias
			"return wait_for_edge($pi, $user_gpio, $edge, $timeout);"
		end

feature {PIGPIO_IF2} -- C Callbacks

	c_pigpiod_if2_set_routine (routine: POINTER)
		external
			"C inline use %"epigpio.h%""
		alias
			"c_set_routine ($routine);"
		end

	c_pigpiod_if2_set_object (obj: POINTER)
		external
			"C inline use %"epigpio.h%""
		alias
			"c_set_object ($obj);"
		end

	c_pigpiod_if2_get_either_edge_callback: POINTER
			--
		external
			"C inline use %"epigpio.h%""
		alias
			"return c_get_either_edge_callback();"
		end

	c_pigpiod_if2_get_rising_edge_callback: POINTER
			--
		external
			"C inline use %"epigpio.h%""
		alias
			"return c_get_rising_edge_callback();"
		end

	c_pigpiod_if2_get_falling_edge_callback: POINTER
			--
		external
			"C inline use %"epigpio.h%""
		alias
			"return c_get_falling_edge_callback();"
		end

	c_pigpiod_if2_get_either_edge_callback_ex: POINTER
			--
		external
			"C inline use %"epigpio.h%""
		alias
			"return c_get_either_edge_callback_ex();"
		end

	c_pigpiod_if2_get_rising_edge_callback_ex: POINTER
			--
		external
			"C inline use %"epigpio.h%""
		alias
			"return c_get_rising_edge_callback_ex();"
		end

	c_pigpiod_if2_get_falling_edge_callback_ex: POINTER
			--
		external
			"C inline use %"epigpio.h%""
		alias
			"return c_get_falling_edge_callback_ex();"
		end

feature {PIGPIO_IF2} -- C Advanced commands

	c_pigpiod_if2_notify_open (pi: INTEGER): INTEGER
			-- int notify_open(int pi)
		external
			"C inline use %"epigpio.h%""
		alias
			"return notify_open($pi);"
		end

	c_pigpio_if2_notify_begin (pi: INTEGER nh: NATURAL bits: NATURAL_32): INTEGER
			-- int notify_begin(int pi, unsigned handle, uint32_t bits)
		external
			"C inline use %"epigpio.h%""
		alias
			"return notify_begin($pi, $nh, $bits);"
		end

	c_pigpiod_if2_notify_pause(pi: INTEGER nh:NATURAL): INTEGER
			-- int notify_pause(int pi, unsigned handle)
		external
			"C inline use %"epigpio.h%""
		alias
			"return notify_pause($pi, $nh);"
		end

	c_pigpiod_if2_notify_close (pi: INTEGER nh: NATURAL): INTEGER
			-- int notify_close(int pi, unsigned handle)
		external
			"C inline use %"epigpio.h%""
		alias
			"return notify_close($pi, $nh);"
		end

	c_pigpiod_if2_hardware_clock (pi: INTEGER gpio: NATURAL clkfreq: NATURAL): INTEGER
			-- int hardware_clock(int pi, unsigned gpio, unsigned clkfreq)
		external
			"C inline use %"epigpio.h%""
		alias
			"return hardware_clock($pi, $gpio, $clkfreq);"
		end

	c_pigpiod_if2_hardware_pwm (pi: INTEGER gpio: NATURAL pwm_freq: NATURAL pwm_duty: NATURAL_32): INTEGER
			-- int hardware_PWM(int pi, unsigned gpio, unsigned PWMfreq, uint32_t PWMduty)
		external
			"C inline use %"epigpio.h%""
		alias
			"return hardware_PWM($pi, $gpio, $pwm_freq, $pwm_duty);"
		end

	c_pigpiod_if2_set_watchdog (pi: INTEGER user_gpio: NATURAL timeout: NATURAL): INTEGER
			-- int set_watchdog(int pi, unsigned user_gpio, unsigned timeout)
		external
			"C inline use %"epigpio.h%""
		alias
			"return set_watchdog($pi, $user_gpio, $timeout);"
		end

	c_pigpiod_if2_set_glitch_filter (pi: INTEGER user_gpio: NATURAL steady: NATURAL): INTEGER
			-- int set_glitch_filter(int pi, unsigned user_gpio, unsigned steady)
		external
			"C inline use %"epigpio.h%""
		alias
			"return set_glitch_filter($pi, $user_gpio, $steady);"
		end

	c_pigpiod_if2_set_noise_filter (pi: INTEGER user_gpio: NATURAL steady: NATURAL active: NATURAL): INTEGER
			-- int set_noise_filter(int pi, unsigned user_gpio, unsigned steady, unsigned active)
		external
			"C inline use %"epigpio.h%""
		alias
			"return set_noise_filter($pi, $user_gpio, $steady, $active);"
		end

	c_pigpiod_if2_set_pad_strength (pi: INTEGER pad: NATURAL strength: NATURAL): INTEGER
			-- int set_pad_strength(int pi, unsigned pad, unsigned padStrength)
		external
			"C inline use %"epigpio.h%""
		alias
			"return set_pad_strength($pi, $pad, $strength);"
		end

	c_pigpio_if2_get_pad_strength (pi: INTEGER pad: NATURAL): INTEGER
			-- int get_pad_strength(int pi, unsigned pad)
		external
			"C inline use %"epigpio.h%""
		alias
			"return get_pad_strength($pi, $pad);"
		end

	c_pigpio_if2_shell (pi: INTEGER script_name: POINTER script_string: POINTER): INTEGER
			-- int shell_(int pi, char *scriptName, char *scriptString)
		external
			"C inline use %"epigpio.h%""
		alias
			"return shell_($pi, $script_name, $script_string);"
		end

feature {PIGPIO_IF2} -- C Events

	c_pigpiod_if2_get_event_callback_example: POINTER
			--
		external
			"C inline use %"epigpio.h%""
		alias
			"return c_get_event_callback_example();"
		end

	c_pigpiod_if2_get_event_callback_ex_example: POINTER
			--
		external
			"C inline use %"epigpio.h%""
		alias
			"return c_get_event_callback_ex_example();"
		end

	c_pigpiod_if2_event_callback (pi: INTEGER event: NATURAL func: POINTER): INTEGER
			-- int event_callback(int pi, unsigned event, evtCBFunc_t f)
		external
			"C inline use %"pigpiod_if2.h%""
		alias
			"return event_callback($pi, $event, $func);"
		end

	c_pigpiod_if2_event_callback_ex (pi: INTEGER event: NATURAL func: POINTER userdata: POINTER): INTEGER
			-- int event_callback_ex(int pi, unsigned event, evtCBFuncEx_t f, void *userdata)
		external
			"C inline use %"pigpiod_if2.h%""
		alias
			"return event_callback_ex($pi, $event, $func, $userdata);"
		end

	c_pigpiod_if2_event_callback_cancel (callback_id: NATURAL): INTEGER
			-- int event_callback_cancel(unsigned callback_id)
		external
			"C inline use %"pigpiod_if2.h%""
		alias
			"return event_callback_cancel($callback_id)"
		end

	c_pigpiod_if2_wait_for_event (pi: INTEGER event: NATURAL timeout: DOUBLE): INTEGER
			-- int wait_for_event(int pi, unsigned event, double timeout)
		external
			"C inline use %"pigpiod_if2.h%""
		alias
			"return wait_for_event($pi, $event, $timeout)"
		end

	c_pigpiod_if2_event_trigger (pi: INTEGER event: NATURAL): INTEGER
			-- int event_trigger(int pi, unsigned event)
		external
			"C inline use %"pigpiod_if2.h%""
		alias
			"return event_trigger($pi, $event)"
		end

feature {PIGPIO_IF2} -- Scripts

	c_pigpiod_if2_store_script (pi: INTEGER script: POINTER): INTEGER
			-- int store_script(int pi, char *script)
		external
			"C inline use %"epigpio.h%""
		alias
			"return store_script($pi, $script);"
		end

	c_pigpiod_if2_run_script (pi: INTEGER script_id: NATURAL num_par: NATURAL params: POINTER): INTEGER
			-- int run_script(int pi, unsigned script_id, unsigned numPar, uint32_t *param)
		external
			"C inline use %"epigpio.h%""
		alias
			"return run_script($pi, $script_id, $num_par, $params);"
		end

	c_pigpiod_if2_update_script (pi: INTEGER script_id: NATURAL num_par: NATURAL params: POINTER): INTEGER
			-- int update_script(int pi, unsigned script_id, unsigned numPar, uint32_t *param)
		external
			"C inline use %"epigpio.h%""
		alias
			"return update_script($pi, $script_id, $num_par, $params);"
		end

	c_pigpiod_if2_script_status (pi: INTEGER script_id: NATURAL params: POINTER): INTEGER
			-- int script_status(int pi, unsigned script_id, uint32_t *param)
		external
			"C inline use %"epigpio.h%""
		alias
			"return script_status($pi, $script_id, $params);"
		end

	c_pigpiod_if2_stop_script (pi: INTEGER script_id: NATURAL): INTEGER
			-- int stop_script(int pi, unsigned script_id)
		external
			"C inline use %"epigpio.h%""
		alias
			"return stop_script($pi, $script_id);"
		end

	c_pigpiod_if2_delete_script (pi: INTEGER script_id: NATURAL): INTEGER
			-- int delete_script(int pi, unsigned script_id)
		external
			"C inline use %"epigpio.h%""
		alias
			"return delete_script($pi, $script_id);"
		end

feature {PIGPIO_IF2} -- C I2C commnands

feature {PIGPIO_IF2} -- C I2C BIT BANG commnands

feature {PIGPIO_IF2} -- C I2C/SPI slave commnands

feature {PIGPIO_IF2} -- C Serial commnands

feature {PIGPIO_IF2} -- C Serial BIT BANG commnands (readonly)

feature {PIGPIO_IF2} -- C SPI commnands

feature {PIGPIO_IF2} -- C SPI BIT BANG commnands

feature {PIGPIO_IF2} -- C Files commnands

feature {PIGPIO_IF2} -- C Waves commnands

feature -- Access

	handle: INTEGER
			--

	notify_handle: INTEGER
			--

	running: BOOLEAN
			--

	callbacks:       ARRAYED_LIST[INTEGER]
			--

	event_callbacks: ARRAYED_LIST[INTEGER]
			--

end
