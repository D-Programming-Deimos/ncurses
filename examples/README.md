# D Ncurses Examples

Here are a few examples to get you started.

The main site where these examples were originally found is here [tldp.org](http://tldp.org/HOWTO/NCURSES-Programming-HOWTO/)
These examples need some work, but they should demonstrate that most everything is in working order.

All of the files *should* be executable and set to link with ncursesw by default.
If you have rdmd installed in /usr/bin/rdmd, then ./helloWorld.d should get you going!

if not, then make [filename], and the programs will be in ./bin/

### Requirements:
    - [rdmd](http://github.com/D-Programming-Language/tools)
    - ncursesw

### Files
    - helloWorld.d   - a simple hello world example.
    - helloUnicode.d - a simple unicode example.
    - keyCode.d      - returns the number code of the key you pressed.
    - simpleColor.d  - a simple example that demonstrates color output.

### TODO
[ ] review, and fix anything that's broken.
[ ] cosmetic alterations.
[ ] add to travis.
[ ] fix so that examples are compilable on Windows.

Again, please file any bugs that you come across.
Even if you don't know if it is actually a bug, we appreciate the time.  
We understand that sometimes it is hard to figure out.
