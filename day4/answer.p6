use v6;

say +$*IN.lines>>.split(" ", :skip-empty)\
.grep(-> @a { +Set(@a) == +@a  });
