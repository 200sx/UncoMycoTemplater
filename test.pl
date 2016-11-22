#!/usr/bin/perl -w

use Tk;
use Tk::BrowseEntry;
use Tk::Font;
use warnings;
#use strict;

#Setting some variables and calling starting functions
$filename = "brands.txt";
carList();
my $mw = MainWindow->new(-title => "Mini Myco");
my $font = $mw->Font(-family=> 'Helvetica', 
          -size  => 10);
my $frame1 = $mw->Frame->pack;
rebuild();

#This chunk generates a list for the model/make any any other notes
my $make = "Universal";
my $model = "(all models)";
my $vehicleSelect = $mw->Frame(-bd => '3', -relief => "raised")->pack;
	
$vehicleSelect->Label(-text => "Vehicle specifications (make and model)")->pack;
my $makeList = $vehicleSelect->BrowseEntry(-label => "Make:",
	                                       -variable => \$make,
	                                       -choices => \@brands,
	                                       -browsecmd => sub {modelGenerator()})->pack;

my $modelList = $vehicleSelect->BrowseEntry(-label => "Model:",
	                                        -variable => \$model)->pack;
	$vehicleSelect->Label(-text => "Year from")->pack;
	my $year_from = $vehicleSelect->Entry()->pack;
	$vehicleSelect->Label(-text => "to")->pack;
	my $year_to = $vehicleSelect->Entry()->pack;
	$vehicleSelect->Label(-text => "Notes on make/model (maybe requires different brackets e.g. NP300 N-Sport)")->pack;
	my $text = $vehicleSelect->Scrolled('Text', -font => $font, -wrap => 'word', -scrollbars => 'e', -height => '2', -width => '50')->pack;

#This chunk pertains to the menu only
my $topLevel = $mw->toplevel;
my $menubar = $topLevel->Menu(-type => 'menubar');
$topLevel->configure(-menu => $menubar);
$menubar->cascade(-label => 'Weathershields', 
	              -tearoff => 0 ,
	              -postcommand => sub {return Weathershields()});
$menubar->cascade(-label => 'Nudge Bars',
	              -tearoff => 0 ,
	              -postcommand => sub {return N_Bar()});


sub Weathershields {
	clear();
	print "hihihi\n";
	my $chromeStrip, $PC, $pieces, $hooks, $clips;
	$frame1 = $mw->Frame->pack;
	$frame1->Label(-text => "Weathershields options")->pack;
	my $barCode = $frame1->Entry()->pack;
	$frame1->Label(-text => "Shipping(leave empty for postcode based, type number for australia wide or type FREIGHT for freight based shipping")->pack;
	my $freight = $frame1->Entry()->pack;
	$frame1->Label(-text => "Special features")->pack;
    my $b1 = $frame1->Checkbutton(-text => 'Is it PC?',
    	                       -variable => \$PC,
    	                       -relief   => 'flat')->pack;
    my $b2 = $frame1->Checkbutton(-text => 'Does it have a chrome strip?',
    	                       -variable => \$chromeStrip,
    	                       -relief   => 'flat')->pack;
	$frame1->Label(-text => "Specifications")->pack;
	foreach my $p (2, 4) {
		$frame1->Radiobutton(
	            -text     => "$p pieces",
	            -variable => \$pieces,
	            -relief   => 'flat',
	            -value    => $p)->pack;
	}
	my $b3 = $frame1->Checkbutton(-text => 'Hooks?',
    	                       -variable => \$hooks,
    	                       -relief   => 'flat')->pack;
    my $b4 = $frame1->Checkbutton(-text => 'Clips?',
    	                       -variable => \$clips,
    	                       -relief   => 'flat')->pack;
	$frame1->Label(-text => "Any specific notes to make?")->pack;
	my $specialText = $frame1->Scrolled('Text', -font => $font, -wrap => 'word', -scrollbars => 'e', -height => '2', -width => '50')->pack;
	$frame1->Button(-text => "Generate code", -command =>sub{display($e1, $e2, $e3)})->pack(-side => "left", -anchor => 'sw');
}
sub N_Bar {
	clear();
	print "lololo\n";
	$frame1 = $mw->Frame->pack;
	$frame1->Label(-text => "Nudge Bars")->pack;
	my $e1 = $frame1->Entry()->pack;
	my $e2 = $frame1->Entry()->pack;
	my $e3 = $frame1->Entry()->pack;
	$frame1->Button(-text => "Hello World!", -command =>sub{display($e1, $e2, $e3)})->pack(-side => "left", -anchor => 'sw');
}
sub display {
	my ($e1, $e2, $e3) = @_;
	my $message;
	$message .= "This is\n";
	$message .= $e1->get;
	$message .= $e2->get;
	if ($e2->get eq "lolcats") {
		$message .= "JIM BREAM\n";
	}
	$message .= $e3->get." Hold your breath and count to ten\n";
	$message .= $make."is selected MARLON BRANDO\n";
 	my $button = $mw->messageBox(
	    -title => 'Message',
        -message => $message);
}

sub carList {
	open(my $fh, '<', $filename) or die "Could not open file '$filename' $!";
	foreach my $line (<$fh>) {
		chomp $line;
		if ($line =~ /(\w*)\:([\w\s]*)/) {
			push(@brands, $1);
			$models{$1} = $2;
			print "$1 has following makes: ".$models{$1}."\n"; 
		}
	}
	close $fh;
}

sub modelGenerator {
	$modelList->delete('0', '10000');
	print "seleced $make and models are: ".$models{$make}."\n";
	my @models = split / /, $models{$make};
	foreach $model (@models) {
		print "model:$model\n";
		$modelList->insert('end', "$model");
	}
}
# below two functions are gractiously borrowed from;
# http://www.perlmonks.org/?node_id=931375
sub rebuild {
	$frame1 = $mw->Label(-text=>"Please select one of the options from above to start generating a table for the selected type of product")->pack();
}

sub clear {
    $frame1->packForget;
}

MainLoop;