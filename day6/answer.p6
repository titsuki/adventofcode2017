use v6;

my Int @banks = $*IN.get.split("\t")>>.Int;

my %visited;

do until %visited{~@banks}:exists {
    %visited{~@banks} = True;

    my $max = @banks.max;
    my $target-bank-idx = 0;
    my $num-redistribution-blocks = 0;
    for @banks.pairs -> Pair $p (Int :key($idx), Int :value($v)){
        if $v == $max {
            $target-bank-idx = $idx;
            $num-redistribution-blocks = $v;
            last;
        }
    }
    @banks[$target-bank-idx] = 0;
    my $pos = ($target-bank-idx + 1) % +@banks;
    while $num-redistribution-blocks-- > 0 {
        @banks[$pos]++;
        $pos++;
        $pos %= +@banks;
    }
    1
}.sum.say;

