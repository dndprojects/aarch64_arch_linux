#!/usr/bin/perl

my $protocol = $ARGV[0];
my $bits = $ARGV[1];
my $data = $ARGV[2];
my $ir_cmd = "mosquitto_pub -h 192.168.1.3 -t cmnd/sonoff_pow/IRSEND -m '{ \"protocol\": \"$protocol\", \"bits\": $bits, \"data\": $data }'";

system ( $ir_cmd ) ;
print "$ir_cmd \n";
exit 0

 
 
 
