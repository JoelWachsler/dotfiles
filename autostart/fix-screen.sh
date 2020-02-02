#!/usr/bin/env fish

set display1Width 1920
set display1Height 1080
set display1Scale 1.2
set display1ScaledWidth (math "$display1Width * $display1Scale")
set display1ScaledHeight (math "$display1Height * $display1Scale")
set display1Refresh 60

set display2Width 2560
set display2Height 1440
set display2Scale 1
set display2ScaledWidth (math "$display2Width * $display2Scale")
set display2ScaledHeight (math "$display2Height * $display2Scale")
set display2Refresh 144

set display3Width 1920
set display3Height 1080
set display3Scale 1.2
set display3ScaledWidth (math "$display3Width * $display3Scale")
set display3ScaledHeight (math "$display3Height * $display3Scale")
set display3Refresh 144

xrandr --dpi 150\
  --output HDMI-1 --mode "$display1Width"x"$display3Height" --pos 0x180 --scale "$display1Scale" --rate "$display1Refresh"\
  --output DP-2 --mode "$display2Width"x"$display2Height" --pos "$display1ScaledWidth"x0 --scale "$display2Scale" --rate "$display2Refresh"\
  --output DP-0 --mode "$display3Width"x"$display3Height" --pos (math "$display1ScaledWidth + $display2ScaledWidth")x180 --scale "$display3Scale" --rate "$display3Refresh"

kquitapp5 plasmashell
kstart5 plasmashell

