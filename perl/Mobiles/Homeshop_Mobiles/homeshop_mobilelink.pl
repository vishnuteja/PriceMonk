use HTML::TokeParser::Simple;
use LWP::Simple qw($ua get);
use Spreadsheet::ParseExcel;

$ua->proxy('http','http://proxy.iiit.ac.in:8080');
my $j = 0;

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
		my @links1;
		foreach(@mobile){
			$file = get('http://www.homeshop18.com/'.$mobile[$j].'/search:'.$mobile[$j].'/categoryid:3024');
			$j = $j + 1;
			my $parser = HTML::TokeParser::Simple->new(\$file);
			my $i = 0;
			while (my $tag = $parser->get_tag('div') ) 
			{
				 if($tag->get_attr('id') eq 'prod_1')
				 {
				 	my $k = 0;
				  	while (my $tag3 = $parser->get_tag('p'))
				  	{
						 if($tag3->get_attr('class') eq 'product_image')
		  				 {
							 $tag2 = $parser->get_tag('a');
							 push(@links, $tag2->get_attr('href'));
							 $t = $tag2->get_attr('href');
							 my @split = split("/",$t);
							 if($split[5] eq 'mobiles')
							 {
							 	push(@links1, $t);
							 	print $t."\n";
							 }
							 $k = $k + 1;
						 }
		  			}
				 } 
				 $i = $i + 1;
			}
		}
	@links1;
}