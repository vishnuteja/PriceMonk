use HTML::TokeParser::Simple;
use LWP::Simple qw($ua get);
use Spreadsheet::ParseExcel;

$ua->proxy('http','http://proxy.iiit.ac.in:8080');
links();

sub isbns{
		my $oExcel = new Spreadsheet::ParseExcel;
		#1.1 Normal Excel97
		my $oBook = $oExcel->Parse('isbn.xls');
		my($iR, $iC, $oWkS, $oWkC);
		#print "FILE  :", $oBook->{File} , "\n";
		#print "COUNT :", $oBook->{SheetCount} , "\n";
		#print "AUTHOR:", $oBook->{Author} , "\n";
		my @isbn;
		
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
					$isbn[$iR] = $oWkC->Value;
					#print $isbn[$iR]."\n" if($oWkC);
					
				}
			}
		}
		@isbn;
	}

sub links{
		my @isbns=isbns();
		my $i=0;
		my @links;
		foreach(@isbns)
		{
			
			$file = get('http://www.amazon.com/s/ref=nb_sb_noss?url=search-alias%3Dstripbooks&field-keywords='.$_);
			
			my $parser = HTML::TokeParser::Simple->new(\$file);
			
			while ( my $tag = $parser->get_tag('div') ) 
			{
				 if($tag->get_attr('id') eq 'result_0')
				  {
				  	#print 'helo';
					 my $tag1 = $parser->get_tag('a');
					 #print $tag1->get_attr('href');
					 push(@links, $tag1->get_attr('href'));
					 print $tag1->get_attr('href')."\n";
				  }
				  
			}
		}
		@links;	
	}
