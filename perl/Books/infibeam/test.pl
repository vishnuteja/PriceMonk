  #!/usr/bin/perl -w
  use strict;

  my %elements;
  my $element = "foo";

  # Fill up our hash a bit
  foreach ("bla", "blubb", "foo", "bah") {
    $elements{$_} = 1;
  };

  # now check if $element is in our hash :
  print "Found '$element'\n" if (exists $elements{$element});
  print "D'oh - '$element' not found\n" unless (exists $elements{$element});

  # You can still get to all elements in %elements :
  foreach (keys %elements) {
    # but they are in some weird order ...
    print "$_\n";
  };