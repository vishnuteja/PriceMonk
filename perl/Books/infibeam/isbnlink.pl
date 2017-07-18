package myProject;
use HTML::TokeParser::Simple;
use LWP::Simple qw($ua get);
use Spreadsheet::ParseExcel;

$ua->proxy('http','http://proxy.iiit.ac.in:8080');
print 'IN ISBNLINK'.'\n';
sub isbns{
		print 'In ISBNS'.'\n';
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
		print 'In links'.'\n';
		my @isbns=isbns();
		my $i=0;
		my @links;
		foreach(@isbns)
		{
		
		$file = get('http://www.infibeam.com/Books/search?q='.$_);
		my $parser = HTML::TokeParser::Simple->new(\$file);
			while ( my $tag = $parser->get_tag('div') ) 
			{
				 if($tag->get_attr('class') eq 'img')
				  {
					 my $tag1 = $parser->get_tag('a');
					 #print $tag1->get_attr('href');
					 push(@links, "http://www.infibeam.com/".$tag1->get_attr('href'));
					 print "http://www.infibeam.com/".$tag1->get_attr('href')."\n";
				  }
				  
			}
				
		}
		@links;
	}
	
sub images{
		print 'images'.'\n';
		my $i=0;
		my @images="";
		foreach(@isbns)
		{
			$file = get('http://www.infibeam.com/Books/search?q='.$_);
			my $parser = HTML::TokeParser::Simple->new(\$file);
				while ( my $tag = $parser->get_tag('div') ) 
				{
					 if($tag->get_attr('class') eq 'img')
					  {
						  my $tag2 = $parser->get_tag('img');
						  $t=$tag2->get_attr('src');
						 # print $t."\n";
						 push(@images,$t );
							 
					  }
				}
		}
		
		@images;
	}
	