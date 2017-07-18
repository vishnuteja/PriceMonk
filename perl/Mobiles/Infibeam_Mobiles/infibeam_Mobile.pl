use CGI;
require "infibeam_mobilelink.pl";
use HTML::TokeParser::Simple;
use LWP::Simple qw($ua get);
$ua->proxy('http','http://proxy.iiit.ac.in:8080');

parsing();
sub parsing{
	@links = links();
	$file="infibeam_mobile.xml";
	open(F, ">infibeam_mobile.xml");
	my $j = 0;
	print F "<?xml version='1.0'?>\n<allmobile>\n";
		foreach (@links)
		{
			my $title="";
			my $price='';
			my $shipping_days = "";
			my $page=get($links[$j]);
			$j = $j + 1;
			my $i=0;
			my @text="";
			
			my $parser = HTML::TokeParser::Simple->new(\$page);
			while ( my $tag = $parser->get_tag('div') )
				{
					if($tag->get_attr('id') eq 'colors')
						{
							while ($tag1 = $parser->get_tag('b'))
							{
								$temp=$parser->get_trimmed_text('/b');
								push(@text, $temp);
							}
						}
				}	
			foreach (@text){
				
				if($i == 2)
				{
					print $text[$i]."\n";
					$shipping_days = $text[$i];
				}
				$i = $i + 1;
				
			}
			
			$parser = HTML::TokeParser::Simple->new(\$page);
				while ( my $tag = $parser->get_tag('span') )
				{
					if($tag->get_attr('class') eq 'infiPrice amount price')
					{
						$t= $parser->get_trimmed_text('/span');
						$price=$t;
						$price =~ s/[^a-zA-Z0-9]*//g;
						print "Price:".$price;
					}
				}
				
			$parser = HTML::TokeParser::Simple->new(\$page);
				while ( my $tag = $parser->get_tag('h1') )
				{
					if($tag->get_attr('class') eq 'fn')
					{
						my $tag2 = $parser->get_tag('span');
						$t= $parser->get_trimmed_text('/span');
						$title = $t;
						print "Title:".$title;
					}
				}
			 
			 print "\n++++++++++++++++++++++++++++++++++++++++++\n";
			 if ($price ne "" )
			 {
				print F "<media>\n";
				print F "<Title>$title</Title>\n";
				print F "<url>$_</url>\n";
				print F "<Price>$price</Price>\n";
				print F "<ShippingDays>$shipping_days</ShippingDays>\n";
				print F "</media>\n";
			 }
		}
		print F "</allmedia>\n";
		close F;
		$file;
		
 }
 sub test{
	my $str= "helloworld";
	print "Hello";
	}