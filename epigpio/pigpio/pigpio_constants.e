note
	description: "Summary description for {PIGPIO_CONSTANTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PIGPIO_CONSTANTS

feature -- Constants

	pigpio_version: STRING
			--
		do
			Result := "pigpio version: " + c_pigpio_version.out
		end

	pigpio_min_gpio: INTEGER
			--
		do
			Result := c_pigpio_min_gpio
		end

	pigpio_max_gpio: INTEGER
			--
		do
			Result := c_pigpio_max_gpio
		end

	pigpio_max_user_gpio: INTEGER
			--
		do
			Result := c_pigpio_max_user_gpio
		end

feature -- pigpio levels

	pigpio_off, pigpio_clear, pi_gpio_low: INTEGER
			--
		do
			Result := c_pigpio_pi_off
		end

	pigpio_on, pigpio_set, pi_gpio_high: INTEGER
			--
		do
			Result := c_pigpio_pi_on
		end

feature -- pigpio timeout

	pigpio_min_timeout: INTEGER
			--
		do
			Result := c_pigpio_pi_timeout
		end

feature -- pigpio modes

	pigpio_pi_input: INTEGER
			--
		do
			Result := c_pigpio_pi_input
		end

	pigpio_pi_output: INTEGER
			--
		do
			Result := c_pigpio_pi_output
		end

	pigpio_pi_alt0: INTEGER
			--
		do
			Result := c_pigpio_pi_alt0
		end

	pigpio_pi_alt1: INTEGER
			--
		do
			Result := c_pigpio_pi_alt1
		end

	pigpio_pi_alt2: INTEGER
			--
		do
			Result := c_pigpio_pi_alt2
		end

	pigpio_pi_alt3: INTEGER
			--
		do
			Result := c_pigpio_pi_alt3
		end

	pigpio_pi_alt4: INTEGER
			--
		do
			Result := c_pigpio_pi_alt4
		end

	pigpio_pi_alt5: INTEGER
			--
		do
			Result := c_pigpio_pi_alt5
		end

feature -- Pull up and pull down resistor

	pigpio_pi_pud_off: INTEGER
			--
		do
			Result := c_pigpio_pi_pud_off
		end

	pigpio_pi_pud_down: INTEGER
			--
		do
			Result := c_pigpio_pi_pud_down
		end

	pigpio_pi_pud_up: INTEGER
			--
		do
			Result := c_pigpio_pi_pud_up
		end

feature -- Dutycycle

	pigpio_pi_default_dutycycle_range: INTEGER
			--
		do
			Result:= c_pigpio_pi_default_dutycycle_range
		end

	pigpio_pi_min_dutycycle_range: INTEGER
			--
		do
			Result := c_pigpio_pi_min_dutycycle_range
		end

	pigpio_pi_max_dutycycle_range: INTEGER
			--
		do
			Result := c_pigpio_pi_max_dutycycle_range
		end

feature {NONE} -- C Servo

	pigpio_pi_servo_off: INTEGER
			--
		do
			Result := c_pigpio_pi_servo_off
		end

	pigpio_pi_min_servo_pulsewidth: INTEGER
			--
		do
			Result := c_pigpio_pi_min_servo_pulsewidth
		end

	pigpio_pi_max_servo_pulsewidth: INTEGER
			--
		do
			Result := c_pigpio_pi_max_servo_pulsewidth
		end

feature -- gpio ISR

	rising_edge: INTEGER
			--
		do
			Result := c_pigpio_rising_edge
		end

	falling_edge: INTEGER
			--
		do
			Result := c_pigpio_falling_edge
		end

	either_edge: INTEGER
			--
		do
			Result := c_pigpio_either_edge
		end

feature {NONE}-- C pigpio externals

	c_pigpio_version: INTEGER
			-- #define PIGPIO_VERSION 79
		external
			"C inline use %"pigpio.h%""
		alias
			"return PIGPIO_VERSION"
		end

	c_pigpio_min_gpio: INTEGER
			-- #define PI_MIN_GPIO       0
		external
			"C inline use %"pigpio.h%""
		alias
			"return PI_MIN_GPIO"
		end

	c_pigpio_max_gpio: INTEGER
			-- #define PI_MAX_GPIO      53
		external
			"C inline use %"pigpio.h%""
		alias
			"return PI_MAX_GPIO"
		end

	c_pigpio_max_user_gpio: INTEGER
			-- #define PI_MAX_USER_GPIO 31
		external
			"C inline use %"pigpio.h%""
		alias
			"return PI_MAX_USER_GPIO"
		end



feature {NONE}-- C pigpio levels

	c_pigpio_pi_off: INTEGER
			-- #define PI_OFF   0
		external
			"C inline use %"pigpio.h%""
		alias
			"return PI_OFF"
		end

	c_pigpio_pi_on: INTEGER
			-- #define PI_ON   1
		external
			"C inline use %"pigpio.h%""
		alias
			"return PI_ON"
		end

	c_pigpio_pi_clear: INTEGER
			-- #define PI_CLEAR   0
		external
			"C inline use %"pigpio.h%""
		alias
			"return PI_CLEAR"
		end

	c_pigpio_pi_set: INTEGER
			-- #define PI_SET   1
		external
			"C inline use %"pigpio.h%""
		alias
			"return PI_SET"
		end

	c_pigpio_pi_low: INTEGER
			-- #define PI_LOW   0
		external
			"C inline use %"pigpio.h%""
		alias
			"return PI_LOW"
		end

	c_pigpio_pi_high: INTEGER
			-- #define PI_HIGH   1
		external
			"C inline use %"pigpio.h%""
		alias
			"return PI_HIGH"
		end

feature {NONE}-- C pigpio timeout

	c_pigpio_pi_timeout: INTEGER
			-- #define PI_TIMEOUT 2
		external
			"C inline use %"pigpio.h%""
		alias
			"return PI_TIMEOUT"
		end

feature {NONE}-- C pigpio modes

	c_pigpio_pi_input: INTEGER
			-- #define PI_INPUT  0
		external
			"C inline use %"pigpio.h%""
		alias
			"return PI_INPUT"
		end

	c_pigpio_pi_output: INTEGER
			-- #define PI_OUTPUT  1
		external
			"C inline use %"pigpio.h%""
		alias
			"return PI_OUTPUT"
		end

	c_pigpio_pi_alt0: INTEGER
			-- #define PI_ALT0   4
		external
			"C inline use %"pigpio.h%""
		alias
			"return PI_ALT0"
		end

	c_pigpio_pi_alt1: INTEGER
			-- #define PI_ALT1   5
		external
			"C inline use %"pigpio.h%""
		alias
			"return PI_ALT1"
		end

	c_pigpio_pi_alt2: INTEGER
			-- #define PI_ALT2   6
		external
			"C inline use %"pigpio.h%""
		alias
			"return PI_ALT2"
		end

	c_pigpio_pi_alt3: INTEGER
			-- #define PI_ALT3   7
		external
			"C inline use %"pigpio.h%""
		alias
			"return PI_ALT3"
		end

	c_pigpio_pi_alt4: INTEGER
			-- #define PI_ALT4   3
		external
			"C inline use %"pigpio.h%""
		alias
			"return PI_ALT4"
		end

	c_pigpio_pi_alt5: INTEGER
			-- #define PI_ALT5  2
		external
			"C inline use %"pigpio.h%""
		alias
			"return PI_ALT5"
		end

feature {NONE} -- C Pull up and pull down resistor

	c_pigpio_pi_pud_off: INTEGER
			-- #define PI_PUD_OFF  0
		external
			"C inline use %"pigpio.h%""
		alias
			"return PI_PUD_OFF"
		end

	c_pigpio_pi_pud_down: INTEGER
			-- #define PI_PUD_DOWN  1
		external
			"C inline use %"pigpio.h%""
		alias
			"return PI_PUD_DOWN"
		end

	c_pigpio_pi_pud_up: INTEGER
			-- #define PI_PUD_UP   2
		external
			"C inline use %"pigpio.h%""
		alias
			"return PI_PUD_UP"
		end

feature {NONE} -- C dutycycle

	c_pigpio_pi_default_dutycycle_range: INTEGER
			-- #define PI_DEFAULT_DUTYCYCLE_RANGE   255
		external
			"C inline use %"pigpio.h%""
		alias
			"return PI_DEFAULT_DUTYCYCLE_RANGE"
		end

	c_pigpio_pi_min_dutycycle_range: INTEGER
			-- #define PI_MIN_DUTYCYCLE_RANGE        25
		external
			"C inline use %"pigpio.h%""
		alias
			"return PI_MIN_DUTYCYCLE_RANGE"
		end

	c_pigpio_pi_max_dutycycle_range: INTEGER
			-- #define PI_MAX_DUTYCYCLE_RANGE     40000
		external
			"C inline use %"pigpio.h%""
		alias
			"return PI_MAX_DUTYCYCLE_RANGE"
		end

feature {NONE} -- C Servo

	c_pigpio_pi_servo_off: INTEGER
			-- #define PI_SERVO_OFF 0
		external
			"C inline use %"pigpio.h%""
		alias
			"return PI_SERVO_OFF"
		end

	c_pigpio_pi_min_servo_pulsewidth: INTEGER
			-- #define PI_MIN_SERVO_PULSEWIDTH 500
		external
			"C inline use %"pigpio.h%""
		alias
			"return PI_MIN_SERVO_PULSEWIDTH"
		end

	c_pigpio_pi_max_servo_pulsewidth: INTEGER
			-- #define PI_MAX_SERVO_PULSEWIDTH 2500
		external
			"C inline use %"pigpio.h%""
		alias
			"return PI_MAX_SERVO_PULSEWIDTH"
		end

feature {NONE} -- C gpio ISR

	c_pigpio_rising_edge: INTEGER
			-- #define RISING_EDGE  0
		external
			"C inline use %"pigpio.h%""
		alias
			"return RISING_EDGE"
		end

	c_pigpio_falling_edge: INTEGER
			-- #define FALLING_EDGE 1
		external
			"C inline use %"pigpio.h%""
		alias
			"return FALLING_EDGE"
		end

	c_pigpio_either_edge: INTEGER
			-- #define EITHER_EDGE  2
		external
			"C inline use %"pigpio.h%""
		alias
			"return EITHER_EDGE"
		end










end
