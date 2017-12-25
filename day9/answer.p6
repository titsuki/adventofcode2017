use v6;

my Bool $garbage = False;
my Bool $skip = False;
my Int $score = 0;
my Int $depth = 1;

for $*IN.get.comb -> $char {
    if $skip {
        $skip = False;
        next;
    }
    given $char {
        when '!' { $skip = True }
        when '{' { $score += $depth++ unless $garbage }
        when '}' { $depth-- unless $garbage }
        when '>' { $garbage = False if $garbage }
        when '<' { $garbage = True unless $garbage }
    }
}

$score.say;
