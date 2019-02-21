# **Noise profile lexer grammar definition**

## *Goals*

* Problem definition
* Decide the language name
* Tools overview
* Describe the language
* Define language syntax
* Implement an eiffel lexer
* Implement an eiffel parser

### *The problem*

There is the need of defining a *Noise Procedure* (**NP**) as a software object
in order to be able to build it, verify its correctness and then check it
against a specific radar track.
One possible solution is to define a specific language whose instructions build 
up the *NP*, the parsing of the source code can verify NP correctness and then
its execution can give usefull results.

### *The language name*

The language name will be **NPL**.

### *Tools overview*

For the time being two alternative development paths are feasible:

* use eiffel ecosystem, but publish as open source item
  * have to acquire knowledge about the tools, but probably the fastest path
* use C tools like *bison*, *yacc*, *lex*, *flex* 
  * have to acquire more knowledge about the tools

### *The NPL language*

*NPL* is a programming language, in order to develop such a language and its 
related tools a *lexer* and a *parser* are needed.

#### *NPL lexer*

The *NPL lexer* processes *NPL* source code and performs a lexical analysis
recognizing *NPL* source code tokens.
The set of *NPL* tokens is its *lexical grammar*.


// vim: set ts=2 number: 
