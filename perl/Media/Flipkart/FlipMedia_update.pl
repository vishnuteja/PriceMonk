#!/usr/bin/perl
use DBI;
use XML::Simple;
use XML::XPath;
use String::Random;

$dbh = DBI->connect('dbi:mysql:pricemonk','root','')or die "Connection Error: $DBI::errstr\n";
print "Connected to DB";
$xml = new XML::Simple; # create object
my $xp = XML::XPath->new(filename => 'flipkart_media.xml'); # reading XML file

$query1=qq{update products SET title = ?,RelDate = ?,category = ?,imgURL = ? where productID = ?};
$sth = $dbh->prepare($query1);

$query2=qq{update media SET artist = ?,category = ?,language =?,lable = ?,genre = ?,format = ? where productID = ?};
$sth2 = $dbh->prepare($query2);

$query3=qq{update sellers SET price = ?,SWeight = ?,rank = ?,SPrice = ?,url = ?,SDays = ? where productID = ? and seller = ?};
$sth3 = $dbh->prepare($query3);

$count = 1;



foreach my $row ($xp->findnodes('/allmedia/media')) 
{
	my $title = $row->find('Name')->string_value;
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
		}
			print "-------------".$product_id."-------------\n";
	}
	
    my $artist = $row->find('artist')->string_value;
    my $catgry = $row->find('category')->string_value;
    my $lang = $row->find('language')->string_value;
    my $lable = $row->find('lable')->string_value;
    my $shipwt = null;
    my $Price = $row->find('Price')->string_value;
    my $Format = $row->find('Format')->string_value;
	my $genre = $row->find('genre')->string_value;
	my $image = $row->find('image')->string_value;
    my $rank = null;
    my $category = 'media';
	my $shipPrice = 0.0;
	my $seller = 'flipkart';
	my $rel_date = null;
	my $url = null;
	my $shipDays = null;
	
	if($product_id ne '')
	{
		$sth->execute($title, $rel_date, $category, $image, $product_id) || die "Error in Insertion to Products";
		$sth2->execute($artist, $catgry, $lang, $lable, $genre, $Format, $product_id) || die "Error in Insertion to Media";
		$sth3->execute($Price, $shipwt, $rank, $shipPrice, $url, $shipDays, $proclduct_id, $seller) || die "Error in Insertion to Sellers";
	}
}
$sth->finish();
$sth2->finish();
$sth3->finish();
$dbh->disconnect(); #disconnect from the database.