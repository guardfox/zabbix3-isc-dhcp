#!/usr/bin/perl

my $mask = aton($ARGV[0]);
my $x=0;

for($i=0; $i<32; $i++){
        $x=$x+($mask & 1);
        $mask = $mask >> 1;
}

print $x,"\n";

sub aton{
    my $addr=shift;
    (my $a0, my $a1, my $a2, my $a3)=split('\.',$addr);
    return $a3+($a2<<8)+($a1<<16)+($a0<<24);
}
