use CGI;
require "eBay_medialink.pl";
use HTML::TokeParser::Simple;
use LWP::Simple qw($ua get);
$ua->proxy('http','http://proxy.iiit.ac.in:8080');

parsing();
sub parsing{
	@links = links();
	$file="eBay_media.xml";
	my $j=0;
	open(F, ">eBay_mobile.xml");
	print F "<?xml version='1.0'?>\n<allmedia>\n";

	foreach (@links)
	{	
		my $page=get($links[$j]);
		$j = $j + 1;
		my $i=0;
		my $title="";
		my $link='';
		my $shipping='';
		my @text="";
		my $price='';
		
		my $parser = HTML::TokeParser::Simple->new(\$page);
		while ( my $tag = $parser->get_tag('b'))
		{
			if($tag->get_attr('id') eq 'mainContent')
			{
				$tag1 = $parser->get_tag('h1');
				$title= $parser->get_trimmed_text('/h1');
				print "Title: ".$title."\n";
			}			
		}
		
		$parser = HTML::TokeParser::Simple->new(\$page);
		while ( my $tag = $parser->get_tag('span') )
		{
			if($tag->get_attr('class') eq 'vi-is1-prcp')
			{
				$t= $parser->get_trimmed_text('/span');
				my @rmv=split("Rs. ",$t);
				$price=$rmv[1];
				print "Price: ".$price."\n";
			}			
		}
		
		$shipping="Two business days";
		
		print "++++++++++++++++++++++++++++++++++++++++\n";
		
		if ($price ne "")
		{
			print F "<media>\n";
			print F "<Title>$title</Title>\n";
			print F "<url>$_</url>\n";
			print F"<Price>$price</Price>\n";
			print F"<ShippingDays>$shipping</ShippingDays>\n";
			print F "</media>\n";
		}		
	}
	print F "</allmedia>\n";
	close F;
	$file;
 }
