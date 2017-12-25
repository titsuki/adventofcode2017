use v6;

$*IN.lines>>.split("\t",:skip-empty)\
>>.Int\
>>.sort\
.map({.[+$_ - 1] - .[0]})\
.sum\
.say;
