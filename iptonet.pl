#!/usr/bin/perl

my $res=ip_vs_net($ARGV[0],$ARGV[1],$ARGV[2]);

print $res,"\n";

sub aton{
    my $addr=shift;
    (my $a0, my $a1, my $a2, my $a3)=split('\.',$addr);
    return $a3+($a2<<8)+($a1<<16)+($a0<<24);
}

sub ntoa{
    my $ip=shift;
    return sprintf("%d.%d.%d.%d",
    (($ip&0xFF000000)>>24),(($ip&0xFF0000)>>16),(($ip&0xFF00)>>8),($ip&0xFF));
}

sub ip_vs_net{
    my $ip=shift;
    my $network=shift;
    my $mask=shift;
    if((aton($ip)&aton($mask))==aton($network)){
        return 1;
    }else{
        return 0;
    }
}
