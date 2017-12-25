use v6;
use MONKEY-SEE-NO-EVAL;

grammar Grammar {
    rule TOP {
        <register-name> <command> <value> <condition>
    }
    token register-name {
        \w+
    }
    proto token command {*}
    token command:sym<inc> {
        <sym>
    }
    token command:sym<dec> {
        <sym>
    }
    token value {
        \-? \d+
    }
    rule condition {
        'if' <register-name> <comparator> <value>
    }
    proto token comparator {*}
    token comparator:sym<eq> {
        '=='
    }
    token comparator:sym<ne> {
        '!='
    }
    token comparator:sym<lt> {
        '<'
    }
    token comparator:sym<gt> {
        '>'
    }
    token comparator:sym<gteq> {
        '>='
    }
    token comparator:sym<lteq> {
        '<='
    }
}

my %register;

class Actions {
    method TOP($/) {
        return unless $<condition>.made;
        given ~$<command> {
            when 'inc' {
                %register{~$<register-name>} += $<value>;
            }
            when 'dec' {
                %register{~$<register-name>} -= $<value>;
            }
        }
    }
    method condition($/) {
        my $name = $<register-name>;
        %register{~$name} = 0 unless %register{~$name}:exists;
        make EVAL("so " ~ ('%register<'~$name~'>',
                           ~$<comparator>,
                           +$<value>).join(" "));
    }
}

Grammar.parse($_, actions => Actions) for $*IN.lines;
%register.sort(*.value).tail.say;
