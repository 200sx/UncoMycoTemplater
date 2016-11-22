#!/usr/bin/perl -w

use Tk;
#use strict;



$mw = MainWindow->new(-title => "Mini Myco");
$currScreen = "NULL";
my $topLevel = $mw->toplevel;
my $menubar = $topLevel->Menu(-type => 'menubar');
$topLevel->configure(-menu => $menubar);
$menubar->cascade(-label => 'Weathershields', -tearoff => 0 ,-postcommand => sub {$currScreen = "Weathershields"});
$menubar->cascade(-label => 'Nudge Bars', -tearoff => 0 ,-postcommand => sub {$currScreen = "Nudge Bars"});

if ($currScreen eq "Weathershields") {
	Weathershields();
} elsif ($currScreen eq "Nudge Bars") {
	N_Bar();
}

sub Weathershields {
	print "hihihi\n";
	return if $currScreen eq "Weathershields";
	$currScreen = "Weathershields";
	my $e1 = $mw->Entry()->pack;
	my $e2 = $mw->Entry()->pack;
	my $e3 = $mw->Entry()->pack;
	$mw->Button(-text => "Hello World!", -command =>sub{display($e1, $e2, $e3)})->pack(-side => "left", -anchor => 'sw');
	$mw->Button(-text => "EXIT!", -command =>sub{exit})->pack(-side => "right", -anchor => 'sw');
}
sub N_Bar {
	print "lololo\n";
	return if $currScreen eq "Nudge Bars";
	$currScreen = "Nudge Bars";
	my $e1 = $mw->Entry()->pack;
	my $e2 = $mw->Entry()->pack;
	my $e3 = $mw->Entry()->pack;
	$mw->Button(-text => "Hello World!", -command =>sub{display($e1, $e2, $e3)})->pack(-side => "left", -anchor => 'sw');
	$mw->Button(-text => "EXIT!", -command =>sub{exit})->pack(-side => "right", -anchor => 'sw');
	$mw->Button(-text => "EXIT!", -command =>sub{exit})->pack(-side => "right", -anchor => 'sw');
}
sub display {
	my ($e1, $e2, $e3) = @_;
	my $message;
	$message .= "This is\n";
	$message .= $e1->get;
	$message .= $e2->get;
	if ($e2->get eq "lolcats") {
		$message .= "JIM BREAM";
	}
	$message .= $e3->get."\n Hold your breath and count to ten";
 my $button = $mw->messageBox(
	-title => 'Message',
    -message => $message);
}

MainLoop;