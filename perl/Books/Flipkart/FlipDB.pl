#!/usr/bin/perl
use DBI;
use XML::Simple;
use XML::XPath;
use String::Random;

$dbh = DBI->connect('dbi:mysql:pricemonk','root','')or die "Connection Error: $DBI::errstr\n";
print "Connected to DB";
$xml = new XML::Simple; # create object
my $xp = XML::XPath->new(filename => 'data.xml'); # reading XML file

$query1=qq{insert into products VALUES (?,?,?,?,?)};
$sth1 = $dbh->prepare($query1);

$query2=qq{insert into books VALUES (?,?,?,?,?,?,?,?,?)};
$sth2 = $dbh->prepare($query2);

$query3=qq{insert into sellers VALUES (?,?,?,?,?,?,?,?)};
$sth3 = $dbh->prepare($query3);

$count = 1;
foreach my $row ($xp->findnodes('/allbooks/book')) 
{
	
	my $product_id = '';
	my $last_id ='';
	
	$P_G = $dbh->prepare('select productID from books');
	$P_G->execute();

	$P_G->bind_columns(undef, \$productID);
	
	if ($P_G->rows == 0)
	{
		$product_id = 'B1'
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
		$product_id = 'B'.$count;
	}
		
	print "ID: ".$product_id."\n";
    my $title = $row->find('Name')->string_value;
    my $author = $row->find('author')->string_value;
    my $rel_date = $row->find('release_date')->string_value;
    my $edition = $row->find('Edition')->string_value;
    my $pages = $row->find('pages')->string_value;
    my $publisher = $row->find('publisher')->string_value;
    my $language = $row->find('language')->string_value;
    my $ISBN_N = $row->find('ISBN_N')->string_value;
    my $ISBN = $row->find('ISBN')->string_value;
    my $shipwt = $row->find('shipwt')->string_value;
    my $Price = $row->find('Price')->string_value;
    my $Format = $row->find('Format')->string_value;
	my $image = $row->find('image')->string_value;
    my $rank = null;
    my $category = 'book';
	my $shipPrice = 0.0;
	my $seller = 'flipkart';
	my $url = null;
	my $shipDays = null;
    $sth1->execute($product_id, $title, $rel_date, $category, $image) || die "Error in Insertion to Products";
    $sth2->execute($product_id, $author, $edition, $publisher, $language, $pages, $ISBN, $ISBN_N, $Format) || die "Error in Insertion to Books";
	$sth3->execute($product_id, $seller, $Price, $shipwt, $rank, $shipPrice, $url, $shipDays) || die "Error in Insertion to Sellers";
	
}

$dbh->disconnect(); #disconnect from the database.