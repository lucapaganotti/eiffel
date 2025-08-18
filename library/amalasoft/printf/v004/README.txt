Readme.txt - Intro to the AEL_PRINTF cluster

The Amalasoft Eiffel Printf Cluster is a collection of classes that implements
a printf facility for the Eiffel language.  It depends on the Eiffel base 
libraries (available in open source or commercial form from Eiffel 
Software www.eiffel.com) and is, like other Eiffel code, portable across 
platforms.

In use, the printf calls are quite simple and are very reminiscent of the 
printf function in C and its close relatives.  Here is an example that
prints a table-row-like line including a number and 3 strings (right,
center and left justified).

 printf("|%%3d|%%10s|%%=10s|%%-10s|%N", << 1, "right", "center", "left" >>)

This call produces the following output

|  1|     right|  center  |left      |

Unlike classic C printf, this cluster is fairly resilient.  For example,
a mismatched or empty arg list will not cause an illegal memory access,
as C printf often can.
There is no option to ommit the arglist, as there is in C.  This would be
a syntax error, caught by the Eiffel compiler.  If for some reason you
feel the need to call printf without an arg list, you must provide an
empty manifest array ("<<>>") or an explicit Void.

A mismatched format-to-arg pair will not cause an exception or even the
ever-popular segmentation fault that often happens with C printf.  It 
will instead produce an output that should be detectable and debuggable.
It will not be what you wanted, but it will be what you requested. The
default format for a mismatched type is simply the type's built-in 'out'
function.  For all but a few basic types, this corresponds to the
'tagged_out' function.

The printf cluster does not include an equivalent to scanf at this time.

     ------------------------------------------------------------

The cluster includes the following classes:

  AEL_PRINTF
    The "face" of the cluster; the class to be inherited by classes
    needing the facility (it can also be instantiated as a supplier).
    AEL_PRINTF offers the key client features including printf, sprintf,
    fprintf and aprintf ("append" printf, that returns a formatted string),
    as well as the key error handling routines.
    There is typically no need for clients to access directly any other
    class from the cluster.

  AEL_PF_FORMATTING_CONSTANTS
    Provides constant values used by the other members of the cluster
    It holds the shared error list (last_printf_errors) and provides a
    shared (onced) instance of AEL_PF_FORMATTING_ROUTINES.

  AEL_PF_FORMATTING_ROUTINES
    Provides the core formatting routines used by the front-end routines
    in AEL_PRINTF.

  AEL_PF_FORMAT_ERROR
    Encapsulation of a single error instance (for when a run-time error
    occurs, due to mismatched parameters and such)

  AEL_PF_FORMAT_ERROR_SUPPORT
    Provides routines to interface with the shared error list

  AEL_PF_FORMAT_PARAM
    The heart of the cluster.  Provides format string parsing and
    interpretation, argument coordination and output routines

     ------------------------------------------------------------

 The various string formatting routines provide a means by which to
 format strings for output or other purposes in a manner reminiscent 
 of (but not identical to) the traditional printf functions in C and
 similar languages.

  Format string construction (in order):

    %
    [<decoration_flag>]
    [<alignment_flag>]
    [<fill_specifier>]
    [<field_width>]
    <field_type>

  Where:

    <decoration_flag> ::=  '#'
      Decoration consumes part of the field width
      Decoration is applies as follows:
        "0x" preceding hexadecimal values
        "0" preceding octal values
        "b" following binary values
        Decimal values show commas at thousands

    <alignment_flag> ::=  '-' |   '+'  |  '='
                         (left   right  centered)

    <fill_specifier> ::=  <character>
      Fills remainder of field width
      with given character (default is blank)

    <field_width> ::=  <simple_width> | <complex_width>

    <field_type> ::=  <character>

      Field type can be at least on of the following:
        'B' denotes a BOOLEAN expression
            This shows as "True" or "False"
        'b' denotes a BINARY INTEGER expression
            This shows as ones and zeroes
        'c' denotes a single CHARACTER
        'd' denotes a DECIMAL INTEGER expression
        'f' denotes a REAL or DOUBLE expression
            Field width for floating point values
            are given in the form:
             <overall_width>"."<right_width>
             Where overall_width is the minimum
             width of the entire representation,
             and <right_width> is the width for
             the fractional part (a.k.a. precision)
             A precision of 0 results in a whole number
             representation, without decimal point
             (effectively rounded to integer)
        'o' denotes an OCTAL INTEGER expression
        's' denotes character STRING
        'u' denotes an UNSIGNED DECIMAL INTEGER expression
        'x' denotes a HEXADECIMAL INTEGER expression
        
 In use, a class calls one of the printf routines with at least
 a format string and an argument list.

 The argument list is any proper descendent of FINITE, and is most often
 a manifest ARRAY.  It can also be Void if there are no arguments.

 The argument list contains the arguments that align (positionally) with
 the format specifiers in the format string.

 Clients wishing access to the printf routines should inherit AEL_PRINTF.
 It is also possible to instantiate AEL_PRINT as a supplier, using the
 default creation mechanism.

 The printf routines have the following contract view:

  aprintf (fmt: STRING; args: FINITE [ANY]): STRING
    -- A new string object formatted according to
    -- the given format 'fmt' and arguments 'args'
    require
      format_string_exists: fmt /= Void
    ensure
      exists: Result /= Void

  fprintf (f: FILE; fmt: STRING; args: FINITE [ANY])
    -- Write to the end of the given open FILE a string formatted
    -- according to given the format 'fmt' and arguments 'args'
    require
      exists: f /= Void
      file_exists: f.exists
      file_is_open: f.is_open_write or f.is_open_append
      format_string_exists: fmt /= Void

  printf (fmt: STRING; args: FINITE [ANY])
    -- Write to the standard output a string formatted
    -- according to the given format 'fmt' and arguments 'args'
    require
      format_string_exists: fmt /= Void

  sprintf (buf: STRING; fmt: STRING; args: FINITE [ANY])
    -- Replace the given STRING 'buf''s contents
    -- with a string formatted according to
    -- the format 'fmt' and arguments 'args'
    require
      buffer_exists: buf /= Void
      format_string_exists: fmt /= Void


 Comparative examples for each AEL_PRINTF routine:

  local
    str1, str2: STRING
    tf: PLAIN_TEXT_FILE
  do
    str1 := "Roger"

    str2 := aprintf ("My name is: %%s%%N", << str1 >>)

    printf ("My name is: %%s%%N", << str1 >>)

    create tf.make_open_write ("/tmp/test")
    fprintf (tf, "My name is: %%s%%N", << str1 >>)
    tf.close

    create str1.make (32)
    sprintf (str2, "My name is: %%s%%N", << str1 >>)
