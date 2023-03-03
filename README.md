Ncurses
=======

## Description

This repository hosts D bindings for the C library ncurses, as well as some examples.

The bindings are implemented as source-only (`.di` files), and do not need to be compiled into a library or object files first.

## Status

The main C header files are up to date with ncurses 6.3, as it is [configured and packaged by Arch Linux](https://github.com/archlinux/svntogit-packages/blob/packages/ncurses/trunk/PKGBUILD).

C++ header files, and the termcap-related header files, are not currently translated.

## Build settings

### Dub configurations

Three dub configurations are made available, which select which libraries are added to be linked into your application:

 * **minimal**: The minimal (which is the default configuration) configurations only links the ncursesw library.

 * **panels**: The panels configuration additionally links the panelw library.

 * **full**: The full configuration additionally links the formw and menuw library.

To use a specific configuration in your projects, depend on this package by adding the following config snippet to your project's `dub.sdl`:

```sdlang
subConfiguration "ncurses" "full"
```

### Reentrant API

ncurses provides a reentrant API. If the ncurses library you are linking against was built with the reentrant API enabled, you can enable it in the bindings by building with `-version=NCURSES_REENTRANT`. In `dub.sdl` this can be done by adding:

```sdlang
versions "NCURSES_REENTRANT"
```

## Building on macOS

The stock ncurses libraries on macOS don't include the wide libraries. Thus the full ncurses version needs to be installed with [Homebrew](https://brew.sh/). Homebrew installs ncurses below ```/usr/local/opt/ncurses```, where the dub configuration will pick it up.

First install Homebrew using the instructions on the web site, then you can add the ncurses package with

````
brew install ncurses
````
