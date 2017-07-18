#!/usr/bin/perl
use DBI;
use XML::Simple;
use XML::XPath;
use HTML::TokeParser::Simple;
use LWP::Simple qw($ua get);

$dbh = DBI->connect('dbi:mysql:pricemonk','root','')or die "Connection Error: $DBI::errstr\n";
print "Connected to DB";

$xml = new XML::Simple; # create object
my $xp = XML::XPath->new(filename => 'amazon_books.xml'); # reading XML file

$query3=qq{insert into sellers VALUES (?,?,?,?,?,?,?,?)};
$sth3 = $dbh->prepare($query3);


use HTML::TokeParser::Simple;
use LWP::Simple qw($ua get);
$ua->proxy('http','http://proxy.iiit.ac.in:8080');


	my @text;
		$page1 = "http://www.currency.me.uk/convert/usd/inr";
		$page = get('http://www.currency.me.uk/convert/usd/inr');

		$parser = HTML::TokeParser::Simple->new(\$page);
		while ( my $tag = $parser->get_tag('div') )
		{
			if($tag->get_attr('id') eq 'tofrom4a')
			{
				while ( my $tag1 = $parser->get_tag('input') )
				{
					if($tag1->get_attr('id') eq 'answer')
					{
						$t= $tag1->get_attr('value');
						print $t."\n";
						push(@text,$t);
					}
				}
			}			
		}
	print @text;

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
		my $P = $row->find('Price')->string_value;
		my $Price = substr($P,1);
		$Price = $Price * $text[0];
		print $Price."\n";
		my $rank = null;
		my $shipPrice = 0.0;
		my $seller = 'amazon';
		my $url = $row->find('url')->string_value;
		my $shipDay = $row->find('ShippingDays')->string_value;
		if($product_id ne '')
		{
			$sth3->execute($product_id, $seller, $Price, $shipwt, $rank, $shipPrice, $url, $shipDay) || die "Error in Insertion to Sellers";
		}
    }
}
$sth1->finish();
$dbh->disconnect(); #disconnect from the database.