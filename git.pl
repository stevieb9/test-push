use warnings;
use strict;

my $spinner_total = 20;
my $spinner_count = 0;

#while (1) {
#    spinner("Performing 'git push'");
#}

sub spinner {
    my ($msg) = @_;

    die("spinner() needs a message sent in") if ! $msg;

    my $num = $spinner_total - $spinner_count;
    my $spinner = '.' x $spinner_count . ' ' x $num;
    $spinner_count++;
    $spinner_count = 0 if $spinner_count == $spinner_total;
    print STDERR "$msg: $spinner\r";
    select(undef, undef, undef, 0.1);
}

git_release('1.00');

sub git_release {
    my ($version) = @_;
    die("git_release_commit() requires a version sent in") if ! defined $version;

    print "\nCommitting release candidate...\n";

    my $commit_exit = system("git commit -am 'Release $version candidate'");

    print "commit: $commit_exit\n";

    if ($commit_exit != 0) {
        if ($commit_exit == 256) {
            print "\nNothing to commit, proceeding...\n";
        }
        else {
            die("Git commit failed... needs intervention...") if $commit_exit != 0;
        }
    }

    print "\nPushing release candidate to Github...\n";

    my $push_exit = system("git", "push");

    print "push: $push_exit\n";

    die("Git push failed... needs intervention...") if $push_exit != 0;

#    {
#        my $continue = 0;
#
#        local $SIG{INT} = sub { $continue = 1; };
#
#        #my @spinner = qw(-- \ | / | \ / --);
#
#
#
#    }
}
