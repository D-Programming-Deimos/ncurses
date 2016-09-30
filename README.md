Ncurses
=======
[![Build Status](https://travis-ci.org/D-Programming-Deimos/ncurses.svg?branch=master)](https://travis-ci.org/D-Programming-Deimos/ncurses)


This is currently in BETA.
--------------------------
There will be bugs.  C Macros are missing, enums are slightly renamed.
If you have any trouble, or think that something should be fixed,
then please create a bug report.

Variants of this package
------------------------

This package can be build in three variants:

 * **minimal**: The minimal (which is the default configuration) configurations only links the ncursesw library.

 * **panels**: The panels configuration additionally links the panelw library.

 * **full**: The full configuration additionally links the formw and menuw library.

To use a specific configuration in your projects, depend on this package by adding the following config snippet to your project's dub.json:

```
"subConfigurations": {
    "ncurses": "full"
}
```

WARNINGS & PRECAUTIONS
----------------------
What files make up the 'official' ncurses package?
