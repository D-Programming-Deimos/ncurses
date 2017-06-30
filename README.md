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

Building on macOS
-----------------

The stock ncurses libraries on macOS don't include the wide libraries. Thus the full ncurses version needs to be installed with [Homebrew](https://brew.sh/). Homebrew installs ncurses below ```/usr/local/opt/ncurses```, where the dub configuration will pick it up.

First install Homebrew using the instructions on the web site, then you can add the ncurses package with

````
brew install ncurses
````

WARNINGS & PRECAUTIONS
----------------------
What files make up the 'official' ncurses package?
