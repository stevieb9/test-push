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

        my @spinner = qw(-- \ | / | \ / --);

        while (! $continue) {
            `clear`;
            for (0..$#spinner) {
                print $spinner[$_];
                `clear`;
            }
        }

        print "Done!\n";
    }
}
