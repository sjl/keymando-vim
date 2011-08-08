keymando-vim
============

This Keymando plugin adds a Vim-like editing mode everywhere (with a few apps
excluded).  To try it out, open TextEdit and play with it.

It's still pretty rough at the moment -- most edge cases aren't handled properly.
Pasting in particular is not properly working yet.

Current Features
----------------

Keymando-vim has several modes, each with their own bindings (just like Vim).

**Note:** until keymando-vim hits 1.0.0 everything is subject to change in lots of
backwards-incompatible ways.  Use it at your own risk.

### Any Mode

    <M-Esc> - Toggle keymando-vim off and on.  Requires `growlnotify` for alerts.

### Insert Mode

    <Esc> - Switch to normal mode.
    <C-[> - Switch to normal mode.

### Normal Mode

    h/j/k/l - Left/down/up/right.

    w - Move one word forward.
    b - Move one word back.
    e - Move to the next "end of word".
    0 - Move to the beginning of the line.

    i - Enter insert mode here.
    a - Enter insert mode after the character to the right of the cursor.
    A - Move to the end of the line and enter insert mode.
    I - Move to the beginning of the line and enter insert mode.
    o - Add a new line below this one and enter insert mode in it.
    O - Add a new line above this one and enter insert mode in it.

    d<text object> - Delete the given text object.
    c<text object> - Delete the given text object.

    dd - Delete the current line.
    cc - Remove all text on the current line and enter insert mode in it.

    p - Paste the cut line after the current one.
    P - Paste the cut line before the current one.

    u     - Undo.
    <C-r> - Redo.

    x - Delete the character to the right of the cursor.
    s - Delete the character to the right of the cursor and enter insert mode.

### Text Objects

    w - From the cursor to next "word beginning".
    b - From the cursor backwards to the previous "word beginning".
