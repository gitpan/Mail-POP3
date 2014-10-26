#!/usr/bin/perl -w

use strict;
use Net::POP3;

my ($host, $port, $user, $pass) = @ARGV;
die "Usage: $0 host port user password\n" unless $pass;

my $pop3 = Net::POP3->new($host, Port => $port);#, Debug => 1);

my $msgs = $pop3->login($user, $pass);
die "Failed to open mailbox\n" unless defined $msgs;
print "user '$user' has $msgs messages\n";

map {
    print "First 5 lines of message $_:\n";
    my $lines = $pop3->top($_, 5);
    map { print } @$lines;
} (1..$msgs);

