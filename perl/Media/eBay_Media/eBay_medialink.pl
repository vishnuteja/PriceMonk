use HTML::TokeParser::Simple;
use LWP::Simple qw($ua get);
use Spreadsheet::ParseExcel;

$ua->proxy('http','http://proxy.iiit.ac.in:8080');
my $j = 0;

links();
sub media{
	my $oExcel = new Spreadsheet::ParseExcel;
	my $oBook = $oExcel->Parse('media_titles.xls');
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
			}
		}
	}
	@media;
}
sub links{
		my @media=media();
		my $i=0;
		my @links;
		foreach(@media){
			$file = get('http://www.ebay.in/sch/i.html?_from=R40&_trksid=m570&_nkw='.$_);
			my $parser = HTML::TokeParser::Simple->new(\$file);
			my $i = 0;
			while (my $tag3 = $parser->get_tag('table'))
			{
				if($tag3->get_attr('r') eq '1')
				{
					while (my $tag = $parser->get_tag('div') ) 
					{
						 if($i==0 and $tag->get_attr('class') eq 'ttl')
						 {
							 $tag2 = $parser->get_tag('a');
							 $t = $tag2->get_attr('href');
							 push(@links, $t);
							 print $t."\n";
							 $i = $i + 1;
						 } 
					}
				}
			}
		}
	@links;
}