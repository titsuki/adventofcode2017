use v6;

my @a = $*IN.slurp.trim.comb;
say (|@a.tail(+@a - 1),@a[0] Z @a)\
.map(-> ($a, $b) { $a == $b ?? $a !! 0 })\
.sum;
