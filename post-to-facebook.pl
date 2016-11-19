#!/usr/bin/perl

use strict;
use warnings;
use URI;
use Facebook::Graph;
use Data::Dumper;

my $access_token = 'EAASqp8MKvc8BAIRHDt29GQLJw7S19LEF3eBrA8iUOfuoVgLJD2VHJjtShAELUEu9DyJAdOkmBu5h8K0XZCEOxxzRuZBg1yR9cLWTi9Cdn0ALtZAgSVLvIbbizQZCw7ZAKY1ZBEBf5bbYw4X0giwNZAx456A6L2ohLYZD';

my $fb = Facebook::Graph->new(
    app_id => '1313537415364047',
    secret => '9102f0d32b856d3b0bf520ea6259f631');
    
$fb->access_token($access_token);
$fb->authorize->extend_permissions(qw(publish_stream read_stream));

my $feed = $fb->fetch('/me/home');

# print Dumper $feed;

foreach (@{${$feed}{data}}){
    my $curr = $fb->query->find(${$_}{id})->select_fields(qw(id name link))->request->as_hashref;
    print ${$_}{id},"\n";
    print Dumper $curr;
    if (${$curr}{link} =~ /^https?:\/\/(www\.)?(.*)\.(com|org|net|\.uk|\.net|\.ca)\// && $2 !~ "facebook"){
#         $fb->add_comment(${$_}{id})->set_message("Hiya, I'm Bot-chan, and this is a test post! It looks like you've linked to $1$2.$3. Sorry, I'm not experienced enough yet to know if this is a good source to be linking, but I'm working really really hard on it! Someday, I'll be a real bot, and we'll have lots of fun together! Until then, wish me luck~~<3")->publish;
    }
    print "\n--------------------------------\n\n"
}
