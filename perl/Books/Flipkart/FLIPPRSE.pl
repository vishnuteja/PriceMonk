package myProject;
use CGI;
require "Excel extract.pl";
use HTML::TokeParser::Simple;
use LWP::Simple qw($ua get);
$ua->proxy('http','http://proxy.iiit.ac.in:8080');
sub parsing{
	@links=isbns();
	$file="data.xml";
	open(F, ">data.xml");
	print F "<allbooks>\n";
		foreach (@links)
		{
			my $title="";
			my $author="";
			my $publisher="";
			my $edition="";
			my $ed_no="";
			my $language="";
			my $isbn="";
			my $isbn_n="";
			my $binding='';
			my $image='';
			my $pages="";
			my $Weight='';
			my $tagger='';
			my $price='';
			my $release_date="";
			print 'URL: http://www.flipkart.com/books/'.$_."\n";
			my $page=get('http://www.flipkart.com/books/'.$_);
			my $i=0;
			my @text = ();
			my $parser = HTML::TokeParser::Simple->new(\$page);
			while ( my $tag = $parser->get_tag('table') )
				{
					 if($tag->get_attr('class') eq 'fk-specs-type1')
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
					if($text[$i]=~/Book:/)
					{
						my @rmv=split(": ",$text[$i]);
						$title=$rmv[1];
					}
					elsif($text[$i]=~/Author:/)
					{
						my @rmv=split(": ",$text[$i]);
						$author=$rmv[1];
					}
					elsif($text[$i]=~/Edition:/)
					{
						my @rmv=split(": ",$text[$i]);
						$edition=$rmv[1];
					}
					elsif($text[$i]=~/Edition Number:/)
					{
						my @rmv=split(": ",$text[$i]);
						$ed_no=$rmv[1];
					}
					elsif($text[$i]=~/Language:/)
					{
						my @rmv=split(": ",$text[$i]);
						$language=$rmv[1];
					}
					elsif($text[$i]=~/ISBN:/)
					{
						my @rmv=split(": ",$text[$i]);
						$isbn=$rmv[1];
					}
					elsif($text[$i]=~/Weight:/)
					{
						my @rmv=split(": ",$text[$i]);
						@wt=split(' ',$rmv[1]);
						$Weight=$wt[0];
					}
					elsif($text[$i]=~/ISBN-13:/)
					{
						my @rmv=split(": ",$text[$i]);
						$isbn_n=$rmv[1];
					}
					elsif($text[$i]=~/Binding:/)
					{
						my @rmv=split(": ",$text[$i]);
						$binding=$rmv[1];
					}
					elsif($text[$i]=~/Number of Pages:/)
					{
						my @rmv=split(": ",$text[$i]);
						$pages=$rmv[1];
					}
					elsif($text[$i]=~/Publishing Date:/)
					{
						my @rmv=split(": ",$text[$i]);
						$release_date=$rmv[1];
					}
					elsif($text[$i]=~/Publisher:/)
					{
						my @rmv=split(": ",$text[$i]);
						$publisher=$rmv[1];
					}
					
				}
			 #print @text;
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
					if($tag->get_attr('class') eq 'mprodimg' and $tag->get_attr('id') eq "mprodimg-id")
					{
						while ( my $tag1 = $parser->get_tag('img'))
						{
							$image=$tag1->get_attr('src');
							last;
						}
					}
				}
				$stock = '';
				$parser = HTML::TokeParser::Simple->new(\$page);
				while ( my $tag = $parser->get_tag('div') )
				{
					if($tag->get_attr('class') eq 'shipping-details')
					{
						while ( my $tag1 = $parser->get_tag('span'))
						{
							$stock= $parser->get_trimmed_text('/span');
							print "In Stock: ".$stock."\n";
						}
					}
				}
			 print "\n++++++++++++++++++++++++++++++++++++++++++\n";
			 if($isbn ne '' and $stock ne 'Out of Stock'){
					print F "<book>\n";
					print F "<Name>$title</Name>\n";
					print F "<author>$author</author>\n";
					print F "<release_date>$release_date</release_date>\n";
					print F "<Edition>$edition</Edition>\n";
					print F "<pages>$pages</pages>\n";
					print F "<publisher>$publisher</publisher>\n";
					print F "<language>$language</language>\n";
					print F "<ISBN_N>$isbn_n</ISBN_N>\n";
					print F "<ISBN>$isbn</ISBN>\n";
					print F "<shipwt>$Weight</shipwt>\n";
					print F "<Price>$price</Price>\n";
					print F "<Format>$binding</Format>\n";
					print F "<image>$image</image>\n";
					print F "</book>\n";
			 }
		}
		print F "</allbooks>\n";
		close F;
		$file;
		
 }

parsing();