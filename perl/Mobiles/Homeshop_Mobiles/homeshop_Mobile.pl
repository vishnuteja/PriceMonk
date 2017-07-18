use CGI;
require "homeshop_mobilelink.pl";
use HTML::TokeParser::Simple;
use LWP::Simple qw($ua get);
$ua->proxy('http','http://proxy.iiit.ac.in:8080');

parsing();
sub parsing{
	@links = links();
	$file="homeshop_mobile.xml";
	my $j=0;
	open(F, ">homeshop_mobile.xml");
	print F "<?xml version='1.0'?>\n<allmobile>\n";

	foreach (@links)
	{	
		my $page=get($links[$j]);
		$j = $j + 1;
		my $i=0;
		my $link='';
		my $shiping='';
		my @text="";
		my $price='';
		my $wrnt='';
		
		my $parser = HTML::TokeParser::Simple->new(\$page);
		while ( my $tag = $parser->get_tag('h1'))
		{
			if($tag->get_attr('id') eq 'productLayoutForm:pbiName')
			{
				$title= $parser->get_trimmed_text('/h1');
			}			
		}
		
		$parser = HTML::TokeParser::Simple->new(\$page);
		while ( my $tag = $parser->get_tag('span') )
		{
			if($tag->get_attr('id') eq 'productLayoutForm:OurPrice')
			{
				$t= $parser->get_trimmed_text('/span');
				my @rmv=split("Rs. ",$t);
				$price=$rmv[1];
			}			
		}
		
		$parser = HTML::TokeParser::Simple->new(\$page);
		while ( my $tag = $parser->get_tag('em') )
		{
			$shiping=$parser->get_trimmed_text('/em');	
			print $shiping;
			last;								
		}
		
		$parser = HTML::TokeParser::Simple->new(\$page);
		while ( my $tag = $parser->get_tag('table') )
		{
			if($tag->get_attr('class') eq 'productShippingInfo')
			{
				while ( my $tag = $parser->get_tag('tr') )
				{
					$t= $parser->get_trimmed_text('/tr');
					push(@text,$t);
				}
			}			
		}
		
		for($i=0;$i<scalar(@text);$i++)
		{
			if($text[$i]=~/Warranty Period/)
			{
				my @rmv=split(": ",$text[$i]);
				$wrnt=$rmv[1];
			}
		}
		print "++++++++++++++++++++++++++++++++++++++++";
		
		if ($price ne "")
		{
			print F "<mobile>\n";
			print F "<Title>$title</Title>\n";
			print F "<url>$_</url>\n";
			print F"<Price>$price</Price>\n";
			print F"<ShippingDays>$shiping</ShippingDays>\n";
			print F "</mobile>\n";
		}		
	}
	print F "</allmobile>\n";
	close F;
	$file;
 }
