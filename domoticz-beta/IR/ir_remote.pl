#!/usr/bin/perl

use DBI;
use strict;

my $remote_name=$ARGV[0];
my $key_to_send=$ARGV[1];
my $second_key_to_send=$ARGV[2];

my $protocol = "";
my $display = "";
my $key = "";
my $data = "";
my $bits = "";
my $driver = "SQLite";
my $database = "/srv/http/sqlite/arduino_ir.db";
my $dsn = "DBI:$driver:dbname=$database";
my $userid = "";
my $password = "";
my $dbh = DBI->connect($dsn, $userid, $password, { RaiseError => 1 }) or die $DBI::errstr;
print "Opened database successfully\n";

my $stmt = qq(SELECT key, protocol, data, bits, display  from \"$remote_name\";);
my $sth = $dbh->prepare( $stmt );
my $rv = $sth->execute() or die $DBI::errstr;
if($rv < 0){ print $DBI::errstr; }

while(my @row = $sth->fetchrow_array()) {
      $key = $row[0];
      $protocol =  $row[1];
      $data = $row[2];
      $bits =  $row[3];
      $display =  $row[4];
      if ($key eq $key_to_send){ last; }
}

my $rv = $sth->execute() or die $DBI::errstr;
if($rv < 0){ print $DBI::errstr; }
my $ir_device = "sonoff_ir";
my $cmd1 = 'mosquitto_pub -h 192.168.1.3 -t cmnd/' . $ir_device . '/IRSEND -m "{ "protocol": ' . $protocol . ', "bits": ' . $bits . ', "data": '. $data . ' }"';

#print  "$remote_name $display\n";
while(my @row = $sth->fetchrow_array()) {
      $key = $row[0];
      $protocol =  $row[1];
      $data = $row[2];
      $bits =  $row[3];
      $display =  $row[4];
      if ($key eq $second_key_to_send){ last; }
}

my $ir_device = "sonoff_ir";
my $cmd = 'mosquitto_pub -h 192.168.1.3 -t cmnd/' . $ir_device . '/IRSEND -m "{ "protocol": ' . $protocol . ', "bits": ' . $bits . ', "data": '. $data . ' }"';
my $sleep = 5; 
if($remote_name eq "YES_IL") { $sleep = 0 ;}

#print  "$cmd1\n";
system($cmd1);
if($second_key_to_send ne "") {
#print  "$remote_name $display\n";
#print  "$cmd\n";
 sleep $sleep;
 system($cmd);
}
