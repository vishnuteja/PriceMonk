use CGI;
require "medialink.pl";
use HTML::TokeParser::Simple;
use LWP::Simple qw($ua get);
$ua->proxy('http','http://proxy.iiit.ac.in:8080');

parsing();
#print "Hi";
sub parsing{
	#print "Hi111";
	@links = links();
	$images = images();
	print "Images:".$images;
	print "Links: ".@links;
	$file="flipkart_media.xml";
	open(F, ">flipkart_media.xml");
	my $j = 0;
	print F "<?xml version='1.0'?>\n<allmedia>\n";
		foreach (@links)
		{
			#print "Hi1233444";
			my $title="";
			my $artist="";
			my $genre="";
			my $language="";
			my $category="";
			my $lable="";
			my $format='';
			my $price='';
			my $page=get($links[$j]);
			$j = $j + 1;
			my $i=0;
			my @text="";
			#print "Page: ".$page."\n";
			#print "Count: ".$j."\n";
			my $parser = HTML::TokeParser::Simple->new(\$page);
			while ( my $tag = $parser->get_tag('li') )
				{
					#print "IN WHILE \n";
					 if($tag->get_attr('class') eq 'fk_list_darkgreybackground fks_list_darkgreybackground' or $tag->get_attr('class') eq 'fk_list_greybackground fks_list_greybackground')
							{
									#print "IN IF \n";
									$t= $parser->get_trimmed_text('/li');
									push(@text,$t);
									#print $t."\n";
							}			
				}
				
			for($i=0;$i<scalar(@text);$i++)
				{
					if($text[$i]=~/Artist:/)
					{
						my @rmv=split(":",$text[$i]);
						my @rmv1=split(//,$rmv[1]);
						delete $rmv1[0];
						delete $rmv1[1];
						$artist=join('',@rmv1);
					}
					elsif($text[$i]=~/Title:/)
					{
						my @rmv=split(":",$text[$i]);
						my @rmv1=split(//,$rmv[1]);
						delete $rmv1[0];
						delete $rmv1[1];
						$title=join('',@rmv1);
					}
					elsif($text[$i]=~/Category:/)
					{
						my @rmv=split(":",$text[$i]);
						my @rmv1=split(//,$rmv[1]);
						delete $rmv1[0];
						delete $rmv1[1];
						$category=join('',@rmv1);
					}
					elsif($text[$i]=~/Label:/)
					{
						my @rmv=split(":",$text[$i]);
						my @rmv1=split(//,$rmv[1]);
						delete $rmv1[0];
						delete $rmv1[1];
						$lable=join('',@rmv1);;
					}
					elsif($text[$i]=~/Language:/)
					{
						my @rmv=split(":",$text[$i]);
						my @rmv1=split(//,$rmv[1]);
						delete $rmv1[0];
						delete $rmv1[1];
						$language=join('',@rmv1);
					}
					elsif($text[$i]=~/Genre:/)
					{
						my @rmv=split(":",$text[$i]);
						my @rmv1=split(//,$rmv[1]);
						delete $rmv1[0];
						delete $rmv1[1];
						$genre=join('',@rmv1);
					}
					elsif($text[$i]=~/Format:/)
					{
						my @rmv=split(":",$text[$i]);
						my @rmv1=split(//,$rmv[1]);
						delete $rmv1[0];
						delete $rmv1[1];
						$format=join('',@rmv1);
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
				
				my $images;
				$parser = HTML::TokeParser::Simple->new(\$page);
				while ( my $tag = $parser->get_tag('div') )
				{
					if($tag->get_attr('class') eq 'mprodimg')
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
					print F "<media>\n";
					print F "<Name>$title</Name>\n";
					print F "<artist>$artist</artist>\n";
					print F "<category>$category</category>\n";
					print F "<language>$language</language>\n";
					print F "<lable>$lable</lable>\n";
					print F "<Price>$price</Price>\n";
					print F "<genre>$genre</genre>\n";
					print F "<Format>$format</Format>\n";
					print F "<image>$images</image>\n";
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