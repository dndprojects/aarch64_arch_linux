#!/usr/bin/perl

use bytes;

my $protocol = $ARGV[0];
my $bits = $ARGV[1];
my $data = $ARGV[2];
$mqq_host = "192.168.1.3";
$mqtt_device = "sonoff_ir";
$mqq_cmd = "IRSEND";

my $len = bytes::length($data);

print "$len\n";
if ($protocol eq "RF" && $len < 7) {
$data = sprintf "%024b", hex( $data );
}

my $ir_cmd = "mosquitto_pub -h $mqq_host -t cmnd/$mqtt_device/$mqq_cmd -m '{ \"protocol\": \"$protocol\", \"bits\": $bits, \"data\": $data }'";
system ( $ir_cmd ) ;
print "$ir_cmd\n";
exit 0
