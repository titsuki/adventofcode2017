use v6;

my Int @length-list = $*IN.get.split(",")>>.Int;
my Int @circular-list = @(^256);

my Int $mod = +@circular-list;
my Int $current-pos = 0;
my Int $skip = 0;

while @length-list {
    my $length = @length-list.shift;
    @circular-list = reverse-partially(@circular-list, $current-pos, $length);
    $current-pos = ($current-pos + $length + $skip) % $mod;
    $skip++;
}

say [*] @circular-list[^2];

sub reverse-partially(Int @circular-list, Int $current-pos, Int $length --> List) {
    my Int $mod = +@circular-list;
    my Bool @visited;
    my $last-pos = $current-pos;
    my $first-pos = $current-pos;
    
    my Int @med = do for $current-pos..^($current-pos + $length) {
        $last-pos = $_ % $mod;
        @visited[$last-pos] = True;
        @circular-list[$last-pos]
    }.reverse;

    do for ^@circular-list {
        do if @visited[$_] {
            @med[$_ - $first-pos < 0 ?? (+@circular-list - $first-pos) + $_ !! $_ - $first-pos]
        } else {
            @circular-list[$_]
        }
    }
}
