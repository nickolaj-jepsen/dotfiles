#! /bin/sh

# CONFIGS
bspc config border_width         2
bspc config window_gap           10
bspc config top_padding 27
bspc config bottom_padding	0
bspc config left_padding	 0
bspc config right_padding	 0
bspc config split_ratio          0.50
bspc config borderless_monocle   true
bspc config gapless_monocle      true
bspc config click_to_focus       any
bspc config active_border_color "#2f2f2f"
bspc config normal_border_color "#2f2f2f"
bspc config focused_border_color "#cf6a4c"
bspc config focus_follows_pointer false

# RULES
bspc rule -a firefox desktop=web
bspc rule -a Chromium desktop=web
bspc rule -a jetbrains-pycharm desktop=code
bspc rule -a Slack desktop=chat

