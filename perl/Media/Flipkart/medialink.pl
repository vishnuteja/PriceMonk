use HTML::TokeParser::Simple;
use Spreadsheet::ParseExcel;
use LWP::Simple qw($ua get);
$ua->proxy('http','http://proxy.iiit.ac.in:8080');

my @links;
my $images;
print "Links".@links;

links();
images();
sub media_names{
		#1.1 Normal Excel97
		my $oExcel = new Spreadsheet::ParseExcel;
		my $oBook = $oExcel->Parse('multimedia.xls');
		my($iR, $iC, $oWkS, $oWkC);
		#print "FILE  :", $oBook->{File} , "\n";
		#print "COUNT :", $oBook->{SheetCount} , "\n";
		#print "AUTHOR:", $oBook->{Author} , "\n";
		my @media;
		
		for(my $iSheet=0; $iSheet < $oBook->{SheetCount} ; $iSheet++) 
		{
			$oWkS = $oBook->{Worksheet}[$iSheet];
			#my $i = 0;
			for(my $iR = $oWkS->{MinRow} ; 
					defined $oWkS->{MaxRow} && $iR <= $oWkS->{MaxRow} ; $iR++) 
			{
				for(my $iC = $oWkS->{MinCol} ;
								defined $oWkS->{MaxCol} && $iC <= $oWkS->{MaxCol} ; $iC++) 
				{
					$oWkC = $oWkS->{Cells}[$iR][$iC];
					$media[$iR] = $oWkC->Value;
					#print $media[$iR]."\n" if($oWkC);
					
				}
			}
		}
		@media;
	}
sub links{
		my $i=0;
		my @media=media_names();
		#print @media;
		print "Hello";
		foreach(@media)
		{
		my $t;
		$file = get('http://www.flipkart.com/search/a/movies-music?query='.$_);
		my $parser = HTML::TokeParser::Simple->new(\$file);
			while ( my $tag = $parser->get_tag('div') ) 
			{
				 if($tag->get_attr('class') eq 'fk-product-thumb fkp-medium')
				  {
					 my $tag1 = $parser->get_tag('a');
					 # print $tag1->get_attr('href');
					 $t="http://www.flipkart.com/".$tag1->get_attr('href');
					 print $t."\n";
					 push(@links, $t);
				  }
			}
		}
		@links;
	}
	sub images{
		my $i=0;
		my @media=media_names();
		foreach(@media)
		{
			$file = get('http://www.flipkart.com/search/a/movies-music?query='.$_);		#print $_[0];
			my $images="";
			my $parser = HTML::TokeParser::Simple->new(\$file);
				while ( my $tag = $parser->get_tag('div') ) 
				{
					 if($tag->get_attr('class') eq 'fk-product-thumb fkp-medium')
					  {
						  my $tag2 = $parser->get_tag('img');
						  $images = $tag2->get_attr('src');
						  print $images;
					  }
				}
			}
		$images;
	}
	sub test{
	my $str= "helloworld";
	}
	
	print "\n"."Images".images();