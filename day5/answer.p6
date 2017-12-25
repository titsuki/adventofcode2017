use v6;
my Int @maze = $*IN.lines>>.Int;
my Int $pos = 0;
do while $pos != +@maze {
    $pos += @maze[$pos]++;
    1
}.sum.say;

