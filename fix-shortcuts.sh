#!/usr/bin/env fish

# The shortcuts are reset for some reason...
sed -i 's/Alt+F1/none/g' $HOME/.config/kglobalshortcutsrc && kquitapp5 kglobalaccel && kglobalaccel5&

