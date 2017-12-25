use v6;

grammar Grammar {
    token TOP {
        [
            <name> <.ws> '('<weight>')' [ <.ws> '->' <.ws> <namelist> ]?
        ]
    }
    token namelist {
        <name>+ % ', '
    }
    token name {
        \w+
    }
    token weight {
        \d+
    }
}


my %is-root;
for $*IN.lines -> $line {
    my $m = Grammar.parse($line);
    %is-root{~$m<name>} = True unless %is-root{~$m<name>}:exists;
    
    if $m<namelist>:exists {
        for $m<namelist><name> {
            %is-root{~$_} = False;
        }
    }
}

do for %is-root -> (:key($name), :value($)) {
    $name if %is-root{$name};
}.head.say;
