#!/usr/bin/perl
use DBI;
use XML::Simple;
use XML::XPath;
use String::Random;

$dbh = DBI->connect('dbi:mysql:pricemonk','root','')or die "Connection Error: $DBI::errstr\n";
print "Connected to DB";
$xml = new XML::Simple; # create object
my $xp = XML::XPath->new(filename => 'data.xml'); # reading XML file

$query1=qq{update products SET title = ?,RelDate = ?,category = ?,imgURL = ? where productID = ?};
$sth = $dbh->prepare($query1);

$query2=qq{update books SET author = ?, edition = ?, publisher = ?,language = ?, pages = ?, ISBN = ?, ISBN_N = ?, Format = ? where productID = ?};
$sth2 = $dbh->prepare($query2);

$query3=qq{update sellers SET price = ?,SWeight = ?,rank = ?,SPrice = ?,url = ?,SDays = ? where productID = ? and seller = ?};
$sth3 = $dbh->prepare($query3);

$count = 1;
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
		print "-------------".$product_id."-------------\n";
	}
    my $title = $row->find('Name')->string_value;
	print $title."--- ";
    my $author = $row->find('author')->string_value;
	print $author."--- ";
    my $rel_date = $row->find('release_date')->string_value;
	print $rel_date."--- ";
    my $edition = $row->find('Edition')->string_value;
	print $edition."--- ";
    my $pages = $row->find('pages')->string_value;
	print $pages."--- ";
    my $publisher = $row->find('publisher')->string_value;
	print $publisher."--- ";
    my $language = $row->find('language')->string_value;
	print $language."--- ";
    my $ISBN_N = $row->find('ISBN_N')->string_value;
	print $ISBN_N."--- ";
    my $shipwt = $row->find('shipwt')->string_value;
	print $shipwt."--- ";
    my $Price = $row->find('Price')->string_value;
	print $Price."--- ";
	my $Format = $row->find('Format')->string_value;
	print $Format."--- ";
	my $image = $row->find('image')->string_value;
	print $image."--- \n";
    my $rank = null;
    my $category = 'book';
	my $shipPrice = 0.0;
	my $seller = 'flipkart';
	my $url = null;
	my $shipDays = null;
	if($product_id ne '')
	{
		print "IN IF\n";
		$sth->execute($title, $rel_date, $category, $image, $product_id);
		$sth2->execute($author, $edition, $publisher, $language, $pages, $isbn, $ISBN_N, $Format, $product_id) || die "Error in Insertion to Books";
		$sth3->execute($Price, $shipwt, $rank, $shipPrice, $url, $shipDays , $product_id, $seller) || die "Error in Insertion to Sellers";
	}
}

$dbh->disconnect(); #disconnect from the database.