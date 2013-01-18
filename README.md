Hangman
=======

Hangman game solver written in Haskell.

Build Instructions
------------------

    $ make

Overview
--------

Hangman expects a list of words in the standard input and produces list of
possible candidates for the `<puzzle>` word provided as a command line
parameter, optionally filtering out any words from the standard input
containing characters in the `<letters>` command line parameter.

To see a list of options, simply invoke Hangman with no parameters:

    $ hang
    Usage: cat words.txt | hang <puzzle> <letters>
    
    Options:
      <puzzle>  Word being guessed.
                 * Only letters allowed.
                 * Use underscore to indicate unknown letters.
      <letters> Letters known not to be in the puzzle word.
                 * Only letters allowed.
    
    This program solves the game of hangman. It reads a list of words from the
    standard input and tries to solve the <puzzle> word, ignoring the words
    containing any characters in <letters>.
    
    Example:
      $ cat words.txt | hang h__se aimn
        hesse
        house
        horse
        house
    
    Project page: http://github.com/LeandroLovisolo/hangman
          Author: Leandro Lovisolo <leandro@leandro.me>

*Tip:* create a terminal alias for hang:

    $ alias hang="cat words.txt | ./hang"

The word list included with Hangman (`words.txt`) was taken from GNU Aspell
[ftp://ftp.gnu.org/gnu/aspell/dict/0index.html](ftp://ftp.gnu.org/gnu/aspell/dict/0index.html)