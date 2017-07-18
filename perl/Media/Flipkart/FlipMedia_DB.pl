#!/usr/bin/perl
use DBI;
use XML::Simple;
use XML::XPath;
use String::Random;

$dbh = DBI->connect('dbi:mysql:pricemonk','root','')or die "Connection Error: $DBI::errstr\n";
print "Connected to DB";
$xml = new XML::Simple; # create object
my $xp = XML::XPath->new(filename => 'flipkart_media.xml'); # reading XML file

$query1=qq{insert into products VALUES (?,?,?,?,?)};
$sth1 = $dbh->prepare($query1);

$query2=qq{insert into media VALUES (?,?,?,?,?,?,?)};
$sth2 = $dbh->prepare($query2);

$query3=qq{insert into sellers VALUES (?,?,?,?,?,?,?,?)};
$sth3 = $dbh->prepare($query3);

$id = new String::Random;
$count = 1;



foreach my $row ($xp->findnodes('/allmedia/media')) 
{
	my $product_id = '';
	my $last_id ='';
	
	$P_G = $dbh->prepare('select productID from media');
	$P_G->execute();

	$P_G->bind_columns(undef, \$productID);
	
	if ($P_G->rows == 0)
	{
		$product_id = 'M1'
	}
	
	else
	{
		while($P_G->fetch())
		{
			print "IN WHILE \n";
			$last_id = $productID;
		}
		my $count = substr($last_id,1);
		print $count."\n";
		$count = $count + 1;
		$product_id = 'M'.$count;
	}
		
	print "ID: ".$product_id."\n";
    my $title = $row->find('Name')->string_value;
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
	
    $sth1->execute($product_id, $title, $rel_date, $category, $image) || die "Error in Insertion to Products";
    $sth2->execute($product_id, $artist, $catgry, $lang, $lable, $genre, $Format) || die "Error in Insertion to Media";
	$sth3->execute($product_id, $seller, $Price, $shipwt, $rank, $shipPrice, $url, $shipDays) || die "Error in Insertion to Sellers";
	
}
$sth1->finish();
$sth2->finish();
$sth3->finish();
$dbh->disconnect(); #disconnect from the database.