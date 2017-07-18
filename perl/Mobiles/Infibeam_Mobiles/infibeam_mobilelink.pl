use HTML::TokeParser::Simple;
use LWP::Simple qw($ua get);
use Spreadsheet::ParseExcel;

$ua->proxy('http','http://proxy.iiit.ac.in:8080');

links();
sub mobiles{
	my $oExcel = new Spreadsheet::ParseExcel;
	my $oBook = $oExcel->Parse('Mobiles.xls');
	my($iR, $iC, $oWkS, $oWkC);
	#print "FILE  :", $oBook->{File} , "\n";
	#print "COUNT :", $oBook->{SheetCount} , "\n";
	#print "AUTHOR:", $oBook->{Author} , "\n";
	my @mobile;
	
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
				$mobile[$iR] = $oWkC->Value;	
			}
		}
	}
	@mobile;
}
sub links{
		my @mobile=mobiles();
		my $i=0;
		my @links;
		foreach(@mobile){
			$file = get('http://www.infibeam.com/Mobiles/search?q='.$_);
			my $parser = HTML::TokeParser::Simple->new(\$file);
				my $i = 0;
				while ( my $tag = $parser->get_tag('ul') ) 
				{
					 if($i==0 and $tag->get_attr('class') eq 'srch_result portrait')
					 {
					  	my $j = 0;	
					  	while (my $tag3 = $parser->get_tag('li'))
					  	{
							 if($j==0)
			  				 {
								 my $tag1 = $parser->get_tag('a');
								 #print $tag1->get_attr('href');
								 push(@links, "http://www.infibeam.com/".$tag1->get_attr('href'));
								 print "http://www.infibeam.com/".$tag1->get_attr('href')."\n";
					  		 }
					  		$j = $j + 1;
			  			}
						$i = $i + 1;
					 } 
				}
			}
		@links;
	}