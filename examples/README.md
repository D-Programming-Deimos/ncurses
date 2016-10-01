# D Ncurses Examples

Here are a few examples to get you started.

Most of these examples are part of the [NCURSES Programming HOWTO](http://tldp.org/HOWTO/NCURSES-Programming-HOWTO/). The examples which were not taken from the HOWTO are marked with (N).
These examples need some work, but they should demonstrate that most everything is in working order.

To run the examples, change to the specific directory and build and execute the example with "dub run".

### Requirements:
    - [rdmd](http://github.com/D-Programming-Language/tools)
    - ncursesw

## Examples
### Basics
  - acsvars      - ACS variables example
  - chgat        - chgat() usage example
  - hellounicode - a simple unicode example (N)
  - helloworld   - a simple hello world example
  - keycode      - returns the number code of the key you pressed
  - mousemenu    - A menu accessible by mouse
  - otherborder  - Shows usage of other border functions apart from box()
  - printbold    - Gets a single character and displays it in bold (N)
  - printw       - A very simple printw() example
  - simplecolor  - a simple example that demonstrates color output
  - simplekey    - A menu accessible with keyboard UP, DOWN  arrows
  - simplespectrum  - Sample of 256-colour output (N)
  - templeave    - Demonstrates temporarily leaving curses mode
  - winborder    - Shows Creation of windows and borders
### Forms
  - form_attrib  - Form attributes example
### Menus
  - attribmenu   - Usage of menu attributes
  - scrollmenu   - Demonstrates scrolling capability of menus
  - simplemenu   - A simple menu accessed by arrow keys
### Panels
  - simplepanel  - A simple panel example

### TODO
[ ] review, and fix anything that's broken.
[ ] cosmetic alterations.
[ ] add to travis.
[ ] fix so that examples are compilable on Windows.

Again, please file any bugs that you come across.
Even if you don't know if it is actually a bug, we appreciate the time.
We understand that sometimes it is hard to figure out.
