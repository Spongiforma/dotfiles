~/.fehbg
xrdb -merge ~/.Xresources
xmodmap ~/.xmodmap
xset +fp ~/.fonts/tamzen-font/bdf
xset fp rehash
xbindkeys
xbindkeys --poll-rc
Tamzen-14
exec bspwm
