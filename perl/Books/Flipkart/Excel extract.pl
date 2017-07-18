use strict;
use Spreadsheet::ParseExcel;
my $oExcel = new Spreadsheet::ParseExcel;

sub isbns{
		#1.1 Normal Excel97
		my $oBook = $oExcel->Parse('flipkart_isbn.xls');
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