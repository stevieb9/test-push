use warnings;
use strict;

git_release('1.00');

sub git_release {
    my ($version) = @_;
    die("git_release_commit() requires a version sent in") if ! defined $version;

    print "Committing release candidate...\n";

    my $commit_exit = system("git commit -am 'Release $version candidate'");

    die("Git commit failed... needs intervention...") if $commit_exit != 0;

    print "Pushing release candidate to Github...\n";

    my $push_exit = system("git", "push");

    die("Git push failed... needs intervention...") if $push_exit != 0;

    {
        my $continue = 0;

        local $SIG{INT} = sub { $continue = 1; };

        #my @spinner = qw(-- \ | / | \ / --);



    }
}
my @whirley = map chr, qw/32 176 177 178 219 178 177 176/;
while (1) {
    sleep 1;
    print STDERR "please wait : ".whirley()."\r";
}

my $WHIRLEY_COUNT;
sub whirley {
    $WHIRLEY_COUNT = 0 if ++$WHIRLEY_COUNT == @whirley;
    return $whirley[$WHIRLEY_COUNT];
}
