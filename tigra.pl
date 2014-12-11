#!/usr/bin/perl -w

use Switch;

my @title = ();
my $index = -1;
my $file = "./tigra.ini";
my ($size) = ();

sub readFile($);
sub writeFile($);
sub incAllVal();
sub setRandom();
sub getTitle();
sub checkVal();

sub readFile($) {
  unless (-e $file) {
    %title = ('abc' => 0, 'def' => 0, 'ghi' => 0, 'jkl' => 0,
	              'mno' => 0, 'pqr' => 0, 'stu' => 0, 'vwx' => 0,
	              'yz0' => 0
               );
  } else {
  
    open my $in, '<', "$_[0]" or die "Can't open existing file: $!\n";
    while( <$in>) {
      %title = split(":", $_);
    }
    close $in;
  }

  $size = keys(%title);
}

sub writeFile($) {
  open my $out, '>', "$_[0]" or die "Can't write new file: $!\n";
  print $out join(":", %title);
  close $out;
}

sub incAllVal() {
  foreach $tmp (sort keys %title) {
    switch ($title{$tmp}) {
      case [1..2] { $title{$tmp}++ }
      case 3      { $title{$tmp} = 0 }
      else        { }
    }
  }
}


sub setRandom() {
  my @keyTitle = keys(%title);
  return $keyTitle[rand(@keyTitle)];
}

sub getTitle() {
  readFile($file);
  do {
    $index = setRandom();
#    print "Schleifendurchlauf...$index\n";
  } until (checkVal() == 1);
  incAllVal();
  $title{$index}++;

  print "Game to Play: ". uc($index) . "\n";
  writeFile($file);
}

sub checkVal() {
  ($title{$index} eq 0 ? return 1 : return 0);
}

getTitle();
