use CGI;
require "mobilelink.pl";
use HTML::TokeParser::Simple;
use LWP::Simple qw($ua get);
$ua->proxy('http','http://proxy.iiit.ac.in:8080');

parsing();
#print "Hi";
sub parsing{
	#print "Hi111";
	@links = links();
	print "Links: ".@links;
	$file="flipkart_mobiles.xml";
	open(F, ">flipkart_mobiles.xml");
	my $j = 0;
	print F "<?xml version='1.0'?>\n<allmobile>\n";
		foreach (@links)
		{
			#print "Hi1233444";
			my $title="";
			my $OS="";
			my $camera="";
			my $screen_size="";
			my $keypad_type="";
			my $price="";
			my $color='';
			my $bluetooth='';
			my $internal_memory="";
			my $expandable_memory="";
			my $threeG="";
			my $warranty="";
			my $shipping_days='';
			
			my $page=get($links[$j]);
			$j = $j + 1;
			my $i=0;
			my @text="";

			my $parser = HTML::TokeParser::Simple->new(\$page);
			while ( my $tag = $parser->get_tag('table') )
				{
					 if($tag->get_attr('class') eq 'fk-specs-type2')
							{
								while ($parser->get_tag('tr') )
								{
									$t= $parser->get_trimmed_text('/tr');
									#print $t."\n";
									push (@text,$t);
								}
							}			
				}
			for($i=0;$i<scalar(@text);$i++)
				{
					if($text[$i]=~/Keypad:/)
					{
						my @rmv=split(":",$text[$i]);
						my @rmv1=split(//,$rmv[1]);
						delete $rmv1[0];
						$keypad_type=join('',@rmv1);
					}
					elsif($text[$i]=~/OS:/)
					{
						my @rmv=split(":",$text[$i]);
						my @rmv1=split(//,$rmv[1]);
						delete $rmv1[0];
						$OS=join('',@rmv1);
					}
					elsif($text[$i]=~/Primary Camera:/)
					{
						my @rmv=split(":",$text[$i]);
						my @rmv1=split(//,$rmv[1]);
						delete $rmv1[0];
						$camera=join('',@rmv1);
					}
					elsif($text[$i]=~/Size:/)
					{
						my @rmv=split(":",$text[$i]);
						my @rmv1=split(//,$rmv[1]);
						delete $rmv1[0];
						$screen_size=join('',@rmv1);;
					}
					elsif($text[$i]=~/Handset Color:/)
					{
						my @rmv=split(":",$text[$i]);
						my @rmv1=split(//,$rmv[1]);
						delete $rmv1[0];
						$color=join('',@rmv1);
					}
					elsif($text[$i]=~/Bluetooth:/)
					{
						my @rmv=split(":",$text[$i]);
						my @rmv1=split(//,$rmv[1]);
						delete $rmv1[0];
						$bluetooth=join('',@rmv1);
					}
					elsif($text[$i]=~/Internal:/)
					{
						my @rmv=split(":",$text[$i]);
						my @rmv1=split(//,$rmv[1]);
						delete $rmv1[0];
						$internal_memory=join('',@rmv1);
					}
					elsif($text[$i]=~/Expandable Memory Slot:/)
					{
						my @rmv=split(":",$text[$i]);
						my @rmv1=split(//,$rmv[1]);
						delete $rmv1[0];
						$expandable_memory=join('',@rmv1);
					}
					elsif($text[$i]=~/3G:/)
					{
						my @rmv=split(":",$text[$i]);
						my @rmv1=split(//,$rmv[1]);
						delete $rmv1[0];
						$threeG=join('',@rmv1);
					}
				}	
			
			$parser = HTML::TokeParser::Simple->new(\$page);
				while ( my $tag = $parser->get_tag('meta') )
				{
					if($tag->get_attr('itemprop') eq 'price')
					{
						$t=$tag->get_attr('content');
						@rmv=split('. ',$t);
						$price=$rmv[1];
					}
				}
				
			$parser = HTML::TokeParser::Simple->new(\$page);
				while ( my $tag = $parser->get_tag('div') )
				{
					if($tag->get_attr('class') eq 'mprod-warrenty')
					{
						$warranty= $parser->get_trimmed_text('/div');
					}
				}
				
			$parser = HTML::TokeParser::Simple->new(\$page);
				while ( my $tag = $parser->get_tag('h1') )
				{
					if($tag->get_attr('itemprop') eq 'name')
					{
						$t=$tag->get_attr('title');
						$title=$t;
					}
				}
				
				my $images;
				$parser = HTML::TokeParser::Simple->new(\$page);
				while ( my $tag = $parser->get_tag('div') )
				{
					if($tag->get_attr('class') eq 'image-wrapper')
					{
						while ( my $tag1 = $parser->get_tag('img'))
						{
							$images = $tag1->get_attr('src');
							last;
						}
					}
				}
				
				#print @text;
			 print "\n++++++++++++++++++++++++++++++++++++++++++\n";
			 if($price ne ''){
					print F "<mobile>\n";
					print F "<Title>$title</Title>\n";
					print F "<Operating_System>$OS</Operating_System>\n";
					print F "<Camera>$camera</Camera>\n";
					print F "<Screen_Size>$screen_size</Screen_Size>\n";
					print F "<Keypad_Type>$keypad_type</Keypad_Type>\n";
					print F "<Price>$price</Price>\n";
					print F "<Color>$color</Color>\n";
					print F "<Bluetooth>$bluetooth</Bluetooth>\n";
					print F "<Internal_Memory>$internal_memory</Internal_Memory>\n";
					print F "<Expandable_Memory>$expandable_memory</Expandable_Memory>\n";
					print F "<3G>$threeG</3G>\n";
					print F "<Warranty>$warranty</Warranty>\n";
					print F "<image>$images</image>\n";
					print F "</mobile>\n";
			 }
		}
		print F "</allmobile>\n";
		close F;
		$file;
		
 }
 sub test{
	my $str= "helloworld";
	print "Hello";
	}