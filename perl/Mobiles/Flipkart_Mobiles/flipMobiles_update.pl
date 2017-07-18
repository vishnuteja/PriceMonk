#!/usr/bin/perl
use DBI;
use XML::Simple;
use XML::XPath;
use String::Random;

$dbh = DBI->connect('dbi:mysql:pricemonk','root','')or die "Connection Error: $DBI::errstr\n";
print "Connected to DB";
$xml = new XML::Simple; # create object
my $xp = XML::XPath->new(filename => 'flipkart_mobiles.xml'); # reading XML file

$query1=qq{update products SET title = ?,RelDate = ?,category = ?,imgURL = ? where productID = ?};
$sth = $dbh->prepare($query1);

$query2=qq{update mobiles SET OS = ?,camera = ?,screen_size = ?,keypad_type = ?,color =?,bluetooth = ?,internal_memory = ?,exp_Memory = ?,3G = ?,warranty = ? where productID = ?};
$sth2 = $dbh->prepare($query2);

$query3=qq{update sellers SET price = ?,SWeight = ?,rank = ?,SPrice = ?,url = ?,SDays = ? where productID = ? and seller = ?};
$sth3 = $dbh->prepare($query3);


$count = 1;
foreach my $row ($xp->findnodes('/allmobile/mobile')) 
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
			print "-------------".$product_id."-------------\n";
	}
	
		
	my $camera = $row->find('Camera')->string_value;
    my $rel_date = null;
    my $OS = $row->find('Operating_System')->string_value;
    my $screen = $row->find('Screen_Size')->string_value;
    my $keypad = $row->find('Keypad_Type')->string_value;
    my $color = $row->find('Color')->string_value;
    my $bluetooth = $row->find('Bluetooth')->string_value;
    my $internal = $row->find('Internal_Memory')->string_value;
	my $threeG = $row->find('threeG')->string_value;
	my $warranty = $row->find('Warranty')->string_value;
	my $shipwt = null;
    my $Price = $row->find('Price')->string_value;
    my $expandable = $row->find('Expandable_Memory')->string_value;
	my $image = $row->find('image')->string_value;
    my $rank = null;
    my $category = 'mobile';
	my $shipPrice = 0.0;
	my $seller = 'flipkart';
	my $url = null;
	my $shipDays = null;
	
    $sth->execute($title, $rel_date, $category, $image, $product_id) || die "Error in Insertion to Products";
    $sth2->execute($OS, $camera, $screen, $keypad, $color, $bluetooth, $internal, $expandable, $threeG, $warranty, $product_id) || die "Error in Insertion to Books";
	$sth3->execute($Price, $shipwt, $rank, $shipPrice, $url, $shipDays, $product_id, $seller) || die "Error in Insertion to Sellers";
	
}

$dbh->disconnect(); #disconnect from the database.