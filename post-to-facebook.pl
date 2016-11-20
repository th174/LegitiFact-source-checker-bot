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
$sourcepages{"Wall Street Journal"} = ${$fb->query->find("/${$fb->fetch('/wsj')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time hour")->request->as_hashref}{data};
$sourcepages{"Upworthy"} = ${$fb->query->find("/${$fb->fetch('/Upworthy')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time hour")->request->as_hashref}{data};
$sourcepages{"TYT"} = ${$fb->query->find("/${$fb->fetch('/TheYoungTurks')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time hour")->request->as_hashref}{data};
$sourcepages{"Daily Kos"} = ${$fb->query->find("/${$fb->fetch('/dailykos')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time hour")->request->as_hashref}{data};
$sourcepages{"The Atlantic"} = ${$fb->query->find("/${$fb->fetch('/TheAtlantic')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time hour")->request->as_hashref}{data};
$sourcepages{"TIME"} = ${$fb->query->find("/${$fb->fetch('/time')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time hour")->request->as_hashref}{data};
$sourcepages{"BuzzFeed"} = ${$fb->query->find("/${$fb->fetch('/BuzzFeedVideo')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time hour")->request->as_hashref}{data};
$sourcepages{"NY Times"} = ${$fb->query->find("/${$fb->fetch('/nytimes')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time hour")->request->as_hashref}{data};
$sourcepages{"mic"} = ${$fb->query->find("/${$fb->fetch('/MicMedia')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time hour")->request->as_hashref}{data};
$sourcepages{"CNN"} = ${$fb->query->find("/${$fb->fetch('/CNN')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time hour")->request->as_hashref}{data};
$sourcepages{"New York Magazine"} = ${$fb->query->find("/${$fb->fetch('/NewYorkMag')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time hour")->request->as_hashref}{data};
$sourcepages{"ATTN:"} = ${$fb->query->find("/${$fb->fetch('/attn')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time hour")->request->as_hashref}{data};
$sourcepages{"The Other 98%"} = ${$fb->query->find("/${$fb->fetch('/TheOther98')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time hour")->request->as_hashref}{data};
$sourcepages{"CBS"} = ${$fb->query->find("/${$fb->fetch('/CBSNews')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time hour")->request->as_hashref}{data};
$sourcepages{"BBC"} = ${$fb->query->find("/${$fb->fetch('/bbcnews')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time hour")->request->as_hashref}{data};
$sourcepages{"Washington Post"} = ${$fb->query->find("/${$fb->fetch('/washingtonpost')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time hour")->request->as_hashref}{data};
$sourcepages{"The Independent"} = ${$fb->query->find("/${$fb->fetch('/TheIndependentOnline')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time hour")->request->as_hashref}{data};
$sourcepages{"Today Show"} = ${$fb->query->find("/${$fb->fetch('/today')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time hour")->request->as_hashref}{data};
$sourcepages{"Daily Show"} = ${$fb->query->find("/${$fb->fetch('/thedailyshow')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time hour")->request->as_hashref}{data};
$sourcepages{"AJ+"} = ${$fb->query->find("/${$fb->fetch('/ajplusenglish')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time hour")->request->as_hashref}{data};
$sourcepages{"NBC"} = ${$fb->query->find("/${$fb->fetch('/NBCNews')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time hour")->request->as_hashref}{data};
$sourcepages{"NowThis"} = ${$fb->query->find("/${$fb->fetch('/NowThisNews')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time hour")->request->as_hashref}{data};
$sourcepages{"Guardian"} = ${$fb->query->find("/${$fb->fetch('/theguardian')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time hour")->request->as_hashref}{data};
$sourcepages{"VICE"} = ${$fb->query->find("/${$fb->fetch('/VICE')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time hour")->request->as_hashref}{data};
$sourcepages{"Daily Caller"} = ${$fb->query->find("/${$fb->fetch('/DailyCaller')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time hour")->request->as_hashref}{data};
$sourcepages{"politico"} = ${$fb->query->find("/${$fb->fetch('/politico')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time hour")->request->as_hashref}{data};
$sourcepages{"ACLJ"} = ${$fb->query->find("/${$fb->fetch('/theACLJ')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time hour")->request->as_hashref}{data};
$sourcepages{"Right Wing News"} = ${$fb->query->find("/${$fb->fetch('/OfficialRightWingNews')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time hour")->request->as_hashref}{data};
$sourcepages{"American News"} = ${$fb->query->find("/${$fb->fetch('/ThePatriotReview')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time hour")->request->as_hashref}{data};
$sourcepages{"Conservative Daily"} = ${$fb->query->find("/${$fb->fetch('/Conservative-Daily-189885532970')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time hour")->request->as_hashref}{data};




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
