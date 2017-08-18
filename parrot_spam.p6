use v6;

my Str @parrots = @*ARGS.grep({ .chars });
unless @parrots {
    note "Nothing to repeat";
    exit 1;
}

my Int $avail = 4000;

SPAM: loop {
    for @parrots -> $p {
        $avail -= $p.chars;
        last SPAM if $avail < 0;
        print $p;
    }
}

say() if $*IN.t;
