#!/usr/bin/perl

use strict;
use warnings;
use URI;
use Facebook::Graph;
use Data::Dumper;

my $access_token = 'EAASqp8MKvc8BADlwToVekM9NgIhrn08epXTB3LZCwOwRpnb1dcS8QhZB6bVxmnRRZAbTLaV8zsU9apjCQiFoZB5J4lNZBsgx6QzyWpZAcwntjs0KVT0n7QEpDipZBQorhAptU33x6WIidLpJXgNwdMWidGuZCHVZBB2me6FgEqW9ZCxAZDZD';
my $fb = Facebook::Graph->new(
    app_id => '1313537415364047',
    secret => '9102f0d32b856d3b0bf520ea6259f631');
$fb->access_token($access_token);
$fb->authorize->extend_permissions(qw(publish_stream read_stream));
my $page = $fb->fetch('/legitifact');
# $fb->add_page_feed->set_page_id("${$page}{id}")->set_message("test123")->set_link_uri('youtube.com')->publish;
# print "${$page}{id}\n";

my $time = 1;

my %sourcepages;
$sourcepages{"Opposing Views"} = ${$fb->query->find("/${$fb->fetch('/opposingviews')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time hour")->request->as_hashref}{data};
$sourcepages{"Occupy Democrats"} = ${$fb->query->find("/${$fb->fetch('/OccupyDemocrats')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time hour")->request->as_hashref}{data};
$sourcepages{"Huffington Post"} = ${$fb->query->find("/${$fb->fetch('/HuffingtonPost')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time hour")->request->as_hashref}{data};
$sourcepages{"Wall Street Journal"} = ${$fb->query->find("/${$fb->fetch('/wsj/')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time hour")->request->as_hashref}{data};
$sourcepages{"The Independent"} = ${$fb->query->find("/${$fb->fetch('/TheIndependentOnline')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time hour")->request->as_hashref}{data};


foreach my $source (keys %sourcepages){
    print "\n$source\n-----------------------------\n";
    foreach (@{$sourcepages{$source}}) {
        my $curr = ${$_}{link};
        if ($curr =~ /^https?:\/\/(www\.)?(.*)\.(com|org|net|\.uk|\.net|\.ca)\// && $2 !~ /facebook/ && $2 !~ /youtube/){
            $fb->add_page_feed->set_page_id(${$page}{id})->set_message("This links to $2, and was posted by the $source facebook page")->set_link_uri("$curr")->publish;
            print Dumper $_;
            print "\n\n"
        }
    }
}
