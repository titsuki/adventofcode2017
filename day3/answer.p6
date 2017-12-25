use v6;

sub right(Int \n --> Int) {
    4 * n ** 2 - 3 * n + 1
}

sub top(Int \n --> Int) {
    4 * n ** 2 - 9 * n + 6
}

sub left(Int \n --> Int) {
    4 * n ** 2 - 7 * n + 4
}

sub bottom(Int \n --> Int) {
    4 * n ** 2 + 3 * n + 1
}

my $target = 277678;
say $_ + abs($target - right($_)) if right($_) - $_ <= $target <= right($_) + $_ for 2..2000;
say $_ + abs($target - top($_)) - 1 if top($_) - $_ - 1 <= $target <= top($_) + $_ - 1 for 2..2000;
say $_ + abs($target - left($_)) - 1 if left($_) - $_ - 1 <= $target <= left($_) + $_ - 1 for 2..2000;
say $_ + abs($target - bottom($_)) if bottom($_) - $_ <= $target <= bottom($_) + $_ for 2..2000;
