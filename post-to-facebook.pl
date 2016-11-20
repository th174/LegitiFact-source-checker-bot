#!/usr/bin/perl

use strict;
use warnings;
use URI;
use Facebook::Graph;
use Data::Dumper;

my $access_token = 'EAASqp8MKvc8BAFPmhQE3b2jEzLh7AaYB0Ssj2iVE8D7ZC0KZCOV493PqJz5bNkOTGafgFYbRVN7TjtyYNPlxL1HLSZB6hF3T3sDSSMuElb7rZAPXdkvAfP9HaZBEZAdZAP08yWYFbDoDffvDLeltMNKvO6YSG1n9kQhX805woOT9etCpYK1ZCc47';

my $fb = Facebook::Graph->new(
    app_id => '1313537415364047',
    secret => '9102f0d32b856d3b0bf520ea6259f631');

$fb->access_token($access_token);
$fb->authorize->extend_permissions(qw(publish_stream read_stream));

my $page = $fb->fetch('/legitifact');

my %sourcepages;
$sourcepages{"OpposingViews"} = ${$fb->query->find("/${$fb->fetch('/opposingviews')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since('-1 hour')->request->as_hashref}{data};
$sourcepages{"OccupyDemocrats"} = ${$fb->query->find("/${$fb->fetch('/OccupyDemocrats')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since('-1 hour')->request->as_hashref}{data};
$sourcepages{"HuffingtonPost"} = ${$fb->query->find("/${$fb->fetch('/HuffingtonPost')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since('-1 hour')->request->as_hashref}{data};
$sourcepages{"WallStreetJournal"} = ${$fb->query->find("/${$fb->fetch('/wsj/')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since('-1 hour')->request->as_hashref}{data};

foreach (keys %sourcepages){
    print "\n$_\n-----------------------------\n";
    foreach (@{$sourcepages{$_}}) {
        my $curr = ${$_}{link};
        if ($curr =~ /^https?:\/\/(www\.)?(.*)\.(com|org|net|\.uk|\.net|\.ca)\// && $2 !~ /facebook/ && $2 !~ /youtube/){
            $fb->add_page_feed->set_page_id(${$page}{id})->set_message("This links to $2, and was posted by the opposing views facebook page")->set_link_uri("$curr")->publish;
            print Dumper $_;
            print "\n\n"
        }
    }
}





# foreach (@{${$feed}{data}}){
#     my $curr = $fb->query->find(${$_}{id})->select_fields(qw(id name link))->request->as_hashref;
#     print ${$_}{id},"\n";
#     print Dumper $curr;
# #     if (${$curr}{link} =~ /^https?:\/\/(www\.)?(.*)\.(com|org|net|\.uk|\.net|\.ca)\// && $2 !~ "facebook"){
# #         $fb->add_comment(${$_}{id})->set_message("Hiya, I'm Bot-chan, and this is a test post! It looks like you've linked to $1$2.$3. Sorry, I'm not experienced enough yet to know if this is a good source to be linking, but I'm working really really hard on it! Someday, I'll be a real bot, and we'll have lots of fun together! Until then, wish me luck~~<3")->publish;
# #     }
#     print "\n--------------------------------\n\n"
# }
