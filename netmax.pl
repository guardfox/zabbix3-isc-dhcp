#!/usr/bin/perl

my $mask = $ARGV[0];
my $mhost = 4294967293-aton($mask);

print $mhost,"\n";

sub aton{
    my $addr=shift;
    (my $a0, my $a1, my $a2, my $a3)=split('\.',$addr);
    return $a3+($a2<<8)+($a1<<16)+($a0<<24);
}
