#!/usr/bin/perl

my $protocol = "RF";
my $bits = "500";
my $data = $ARGV[0];

my $ir_cmd = "mosquitto_pub -h 192.168.1.3 -t cmnd/sonoff_ir/IRSEND -m '{ \"protocol\": \"$protocol\", \"bits\": $bits, \"data\": $data }'";
system ( $ir_cmd ) ;
#print "$ir_cmd\n";
exit 0
#set rfon="000000000001010100010001"
#set rfoff="000000000001010100010100"
