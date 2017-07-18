package myProject;
require "isbnlink.pl";
use HTML::TokeParser::Simple;
use LWP::Simple qw($ua get);
$ua->proxy('http','http://proxy.iiit.ac.in:8080');

sub parsing{
	$file="data.xml";
	my %isbns;
	@links=links();
	@images=images();
	my $j=0;
	open(F, ">data.xml");
	 print F "<allbooks>\n";
		foreach (@links)
		{
			my $page=get($_);
			my $price='';
			my $Sdays='';
			my $i=0;
			my @text;
			my $isbn;
			my $parser = HTML::TokeParser::Simple->new(\$page);
			while ( my $tag = $parser->get_tag('span') )
				{
					 if($tag->get_attr('class') eq 'infiPrice amount price')
							{
										$price= $parser->get_trimmed_text('/span');
							}			
				}
			
			my $parser = HTML::TokeParser::Simple->new(\$page);
			while ( my $tag = $parser->get_tag('div') )
				{
					if($tag->get_attr('id') eq 'ib_details')
						{
							while ($tag1 = $parser->get_tag('b'))
							{
								$temp=$parser->get_trimmed_text('/b');
								push(@text, $temp);
							}
						}
				}	
			foreach (@text){
				
				if($i == 1)
				{
					print $text[$i]."\n";
					$Sdays = $text[$i];
				}
				$i = $i + 1;
				
			}
			my $parser = HTML::TokeParser::Simple->new(\$page);
			while ( my $tag = $parser->get_tag('table'))
				{
					 if($tag->get_attr('style') eq 'color:#333; font:verdana,Arial,sans-serif;')
							{
								while (my $tag1=$parser->get_tag('tr') )
								{
										$t= $parser->get_trimmed_text('/tr');
										#print $t."\n";
										push (@text,$t);
								}
							}			
				}
				for($i=0;$i<scalar(@text);$i++)
				{
					if($text[$i]=~/ISBN:/)
					{
						my @rmv=split(": ",$text[$i]);
						$isbn=$rmv[1];
					}
				}
				
				
				if ($isbn ne "" and $price ne "" )
				{
					if (exists $isbns{$isbn})
					{
						print "Element found \n";
					}
					else
					{
						
							print "IN IF \n";
							print F "<book>\n";
							print F "<ISBN>$isbn</ISBN>\n";
							print F "<url>$_</url>\n";
							print F "<Price>$price</Price>\n";
							print F "<ShippingDays>$Sdays</ShippingDays>\n";
							print F "</book>\n";
					}
				}
						$isbns{$isbn} = 1;
						$j++;
						
				}
				
				 print F "</allbooks>\n";
		close F;
		$file;
 }
 
parsing();
 #print links("index.html");
#die "Couldn't get it!" unless defined $content;