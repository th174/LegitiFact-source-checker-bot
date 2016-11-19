#!/usr/bin/perl

use strict;
use warnings;
use URI;
use Facebook::Graph;
use Data::Dumper;

my $access_token = 'EAASqp8MKvc8BAKszHF8WVxjtOBvmVRrHgJtyjqDQcgLMJSlDtmOsvDs1iDpxmERjJDeMwrXC52BTQ3AC19wtD5A1mFlOsojlmDLAwhOXy5y4APIq8dqLsKpM5PlVWVf4mFJqKSzyZAJb5mE10ZBJfZBy034wKlVm28LY94Q8vdHQiCeDZC8Y';

my $fb = Facebook::Graph->new;

$fb->access_token($access_token);

my $feed = $fb->fetch('/me/feed');

# print Dumper $feed;

foreach (@{${$feed}{data}}){
    my $curr = $fb->query->find(${$_}{id})->select_fields(qw(id name link))->request->as_hashref;
    print ${$_}{id},"\n";
    print Dumper $curr;
    if (${$curr}{link} =~ /^https?:\/\/(www\.)?(.*)\.(com|org|net|\.uk|\.net|\.ca)\// && $2 !~ "facebook"){
        $fb->add_comment(${$_}{id})->set_message("Hiya, I'm Bot-chan, and this is a test post! It looks like you've linked to www.$2.$3. Sorry, I'm not experienced enough yet to know if this is a good source to be linking, but I'm working really really hard on it! Someday, I'll be a real bot, and we'll have lots of fun together! Until then, wish me luck~~<3")->publish;
    }
    print "\n--------------------------------\n\n"
}
