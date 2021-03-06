#!/usr/bin/perl
use DBI;
use XML::Simple;
use XML::XPath;

$dbh = DBI->connect('dbi:mysql:pricemonk','root','')or die "Connection Error: $DBI::errstr\n";
print "Connected to DB";

$xml = new XML::Simple; # create object
my $xp = XML::XPath->new(filename => 'infibeam_mobile.xml'); # reading XML file

$query3=qq{update sellers SET price = ?,SWeight = ?,rank = ?,SPrice = ?,url = ?,SDays = ? where productID = ? and seller = ?};
$sth3 = $dbh->prepare($query3);


foreach my $row ($xp->findnodes('/allmobile/media')) 
{
	my $title = $row->find('Title')->string_value;
	print $title."\n";
	$sth1 = $dbh->prepare('select productID from products where title = ?')|| die "$DBI::errstr";
	
	my $product_id ='';
	$sth1->bind_param(1, $productID);
	$sth1->execute($title);
	
	if ($sth1->rows < 0) {
			print "Sorry, no domains found.\n";
	} 
	else {
		printf ">> Found %d domains\n", $sth1->rows;
		# Loop if results found
		while (my $results = $sth1->fetchrow_hashref) 
		{
				$product_id = $results->{productID}; # get the productID
				last;
		}
	}
		my $shipwt = null;
		my $Price = $row->find('Price')->string_value;
		#$Price =~ s/[^a-zA-Z0-9]*//g;
		my $rank = null;
		my $shipPrice = 0.0;
		my $seller = 'infibeam';
		my $url = $row->find('url')->string_value;
		my $shipDay = $row->find('ShippingDays')->string_value;
		if($product_id ne '')
		{
			$sth3->execute($Price, $shipwt, $rank, $shipPrice, $url, $shipDay, $product_id, $seller) || die "Error in Insertion to Sellers";
		}
		$sth1->finish();
    
}

$dbh->disconnect(); #disconnect from the database.