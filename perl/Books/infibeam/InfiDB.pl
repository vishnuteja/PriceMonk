#!/usr/bin/perl
use DBI;
use XML::Simple;
use XML::XPath;

$dbh = DBI->connect('dbi:mysql:pricemonk','root','')or die "Connection Error: $DBI::errstr\n";
print "Connected to DB";

$xml = new XML::Simple; # create object
my $xp = XML::XPath->new(filename => 'data.xml'); # reading XML file




$query3=qq{insert into sellers VALUES (?,?,?,?,?,?,?,?)};
$sth3 = $dbh->prepare($query3);


foreach my $row ($xp->findnodes('/allbooks/book')) 
{
	my $isbn = $row->find('ISBN')->string_value;
	print $isbn."\n";
	$sth1 = $dbh->prepare('select productID from books where isbn = ?')|| die "$DBI::errstr";
	
	my $product_id ='';
	$sth1->bind_param(1, $productID);
	$sth1->execute($isbn);
	
	if ($sth1->rows < 0) {
			print "Sorry, no domains found.\n";
	} 
	else {
		printf ">> Found %d domains\n", $sth1->rows;
		# Loop if results found
		while (my $results = $sth1->fetchrow_hashref) 
		{
				$product_id = $results->{productID}; # get the productID
		}
		my $shipwt = null;
		my $Price = $row->find('Price')->string_value;
		$Price =~ s/[^a-zA-Z0-9]*//g;
		my $rank = null;
		my $shipPrice = 0.0;
		my $seller = 'infibeam';
		my $url = $row->find('url')->string_value;
		my $shipDay = $row->find('ShippingDays')->string_value;
		$sth3->execute($product_id, $seller, $Price, $shipwt, $rank, $shipPrice, $url, $shipDay) || die "Error in Insertion to Sellers";
    }
}
$sth1->finish();
$dbh->disconnect(); #disconnect from the database.