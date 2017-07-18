#!/usr/bin/perl
use DBI;
use XML::Simple;
use XML::XPath;
use String::Random;

$dbh = DBI->connect('dbi:mysql:pricemonk','root','')or die "Connection Error: $DBI::errstr\n";
print "Connected to DB";
$xml = new XML::Simple; # create object
my $xp = XML::XPath->new(filename => 'flipkart_mobiles.xml'); # reading XML file

$query1=qq{insert into products VALUES (?,?,?,?,?)};
$sth1 = $dbh->prepare($query1);

$query2=qq{insert into mobiles VALUES (?,?,?,?,?,?,?,?,?,?,?)};
$sth2 = $dbh->prepare($query2);

$query3=qq{insert into sellers VALUES (?,?,?,?,?,?,?,?)};
$sth3 = $dbh->prepare($query3);


$count = 1;
foreach my $row ($xp->findnodes('/allmobile/mobile')) 
{
	
	my $product_id = '';
	my $last_id ='';
	
	$P_G = $dbh->prepare('select productID from mobiles');
	$P_G->execute();

	$P_G->bind_columns(undef, \$productID);
	
	if ($P_G->rows == 0)
	{
		$product_id = 'P1'
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
		$product_id = 'P'.$count;
	}
		
	print "ID: ".$product_id."\n";
    my $title = $row->find('Title')->string_value;
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
	
    $sth1->execute($product_id, $title, $rel_date, $category, $image) || die "Error in Insertion to Products";
    $sth2->execute($product_id, $OS, $camera, $screen, $keypad, $color, $bluetooth, $internal, $expandable, $threeG, $warranty) || die "Error in Insertion to Books";
	$sth3->execute($product_id, $seller, $Price, $shipwt, $rank, $shipPrice, $url, $shipDays) || die "Error in Insertion to Sellers";
	
}

$dbh->disconnect(); #disconnect from the database.