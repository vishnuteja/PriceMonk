use CGI;
require "amazon_booklink.pl";
use HTML::TokeParser::Simple;
use LWP::Simple qw($ua get);
$ua->proxy('http','http://proxy.iiit.ac.in:8080');

parsing();

sub parsing
{
	@links= links();
	$file="amazon_books.xml";
	open(F, ">amazon_books.xml");
	print F "<?xml version='1.0'?>\n<allbooks>\n";
	
	my $j = 0;
	foreach (@links)
	{
		my $isbn="";
		my $price='';
		my $shipping_days = "";
		my $page=get($links[$j]);
		$j = $j + 1;
		
		my @text="";
		
		my $parser = HTML::TokeParser::Simple->new(\$page);
		while ( my $tag = $parser->get_tag('div') ) 
		{	 	
			if(($tag->get_attr('class') eq 'buying'))
			{
				my $k = 0;
				while(my $tag1 = $parser->get_tag('span'))
				{
					if($k==1 and $tag1->get_attr('style') eq 'font-weight: bold;')
					{print "Hello";
						$t = $parser->get_trimmed_text('/span');
						$isbn = $t;
						print "ISBN:".$isbn;
					}
					$k = $k + 1;
				}
			}
		}
		
		my @is = split("/",$_);
		$isbn = $is[5];
		print "ISBN:".$isbn;
		
		my $k = 0;
		$parser = HTML::TokeParser::Simple->new(\$page);
		while ( my $tag = $parser->get_tag('span') ) 
		{	 	
			if($k==0 and ($tag->get_attr('class') eq 'price'))
			{
				print "Hello";
				$t = $parser->get_trimmed_text('/span');
				$price = $t;
				print "Price:".$price;
				$k = $k + 1;
			}
		}
		
		$parser = HTML::TokeParser::Simple->new(\$page);
		while ( my $tag = $parser->get_tag('td') )
		{
			if($tag->get_attr('style') eq 'font-size: 11px;')
			{
				$t= $parser->get_trimmed_text('/td');
				my @split = split(" ", $t);
				$shipping_days = $split[3]."s";
				print "Shipping Days:".$shipping_days;
			}
		}
			 
			if ($shipping_days eq "" )
			{
				$shipping_days = "Two-days";
			}
				
			 print "\n++++++++++++++++++++++++++++++++++++++++++\n";
			 if ($price ne "" )
			 {
				print F "<book>\n";
				print F "<ISBN>$isbn</ISBN>\n";
				print F "<url>$_</url>\n";
				print F "<Price>$price</Price>\n";
				print F "<ShippingDays>$shipping_days</ShippingDays>\n";
				print F "</book>\n";
			 }
		}
		print F "</allbooks>\n";
		close F;
		$file;
	}