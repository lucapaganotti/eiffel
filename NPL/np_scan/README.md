# **Noise profile lexer grammar definition**

## *Goals*

* Problem definition
* Decide the language name
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

### *The NPL language*

*NPL* is a programming language, in order to develop such a language and its 
related tools a *lexer* and a *parser* are needed.

#### *NPL lexer*

The *NPL lexer* processes *NPL* source code and performs a lexical analysis
recognizing *NPL* source code tokens.
The set of *NPL* tokens is its *lexical grammar*.



