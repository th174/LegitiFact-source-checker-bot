#!/usr/bin/perl

use strict;
use warnings;
use URI;
use Facebook::Graph;
use Data::Dumper;

my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) =localtime(time);

printf ("***********************************************************************************\nStarted at %02d:%02d:%02d on %02d/%02d/%04d\n***********************************************************************************\n",$hour,$min,$sec,$mon,$mday,$year+1900);

#Authenticate with Facebook
my $access_token = 'EAASqp8MKvc8BADlwToVekM9NgIhrn08epXTB3LZCwOwRpnb1dcS8QhZB6bVxmnRRZAbTLaV8zsU9apjCQiFoZB5J4lNZBsgx6QzyWpZAcwntjs0KVT0n7QEpDipZBQorhAptU33x6WIidLpJXgNwdMWidGuZCHVZBB2me6FgEqW9ZCxAZDZD';
my $fb = Facebook::Graph->new(
    app_id => '1313537415364047',
    secret => '9102f0d32b856d3b0bf520ea6259f631');
$fb->access_token($access_token);
$fb->authorize->extend_permissions(qw(publish_stream read_stream));
my $page = $fb->fetch('/legitifact');

my %sourcepages; #hash of Facebook page -> feed from last $time min
my $time = $ARGV[1]; #minutes

$sourcepages{"Opposing Views"} = ${$fb->query->find("/${$fb->fetch('/opposingviews')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"Occupy Democrats"} = ${$fb->query->find("/${$fb->fetch('/OccupyDemocrats')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"The Huffington Post"} = ${$fb->query->find("/${$fb->fetch('/HuffingtonPost')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"The Wall Street Journal"} = ${$fb->query->find("/${$fb->fetch('/wsj')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"Upworthy"} = ${$fb->query->find("/${$fb->fetch('/Upworthy')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"The Young Turks"} = ${$fb->query->find("/${$fb->fetch('/TheYoungTurks')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"Daily Kos"} = ${$fb->query->find("/${$fb->fetch('/dailykos')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"The Atlantic"} = ${$fb->query->find("/${$fb->fetch('/TheAtlantic')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"TIME"} = ${$fb->query->find("/${$fb->fetch('/time')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"BuzzFeed"} = ${$fb->query->find("/${$fb->fetch('/BuzzFeedVideo')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"The New York Times"} = ${$fb->query->find("/${$fb->fetch('/nytimes')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"Mic"} = ${$fb->query->find("/${$fb->fetch('/MicMedia')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"CNN"} = ${$fb->query->find("/${$fb->fetch('/CNN')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"New York Magazine"} = ${$fb->query->find("/${$fb->fetch('/NewYorkMag')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"ATTN:"} = ${$fb->query->find("/${$fb->fetch('/attn')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"The Other 98%"} = ${$fb->query->find("/${$fb->fetch('/TheOther98')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"CBS News"} = ${$fb->query->find("/${$fb->fetch('/CBSNews')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"BBC News"} = ${$fb->query->find("/${$fb->fetch('/bbcnews')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"Washington Post"} = ${$fb->query->find("/${$fb->fetch('/washingtonpost')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"The Independent"} = ${$fb->query->find("/${$fb->fetch('/TheIndependentOnline')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"the Today Show"} = ${$fb->query->find("/${$fb->fetch('/today')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"The Daily Show"} = ${$fb->query->find("/${$fb->fetch('/thedailyshow')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"AJ+"} = ${$fb->query->find("/${$fb->fetch('/ajplusenglish')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"NBC News"} = ${$fb->query->find("/${$fb->fetch('/NBCNews')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"NowThis"} = ${$fb->query->find("/${$fb->fetch('/NowThisNews')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"The Guardian"} = ${$fb->query->find("/${$fb->fetch('/theguardian')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"VICE"} = ${$fb->query->find("/${$fb->fetch('/VICE')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"Daily Caller"} = ${$fb->query->find("/${$fb->fetch('/DailyCaller')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"POLITICO"} = ${$fb->query->find("/${$fb->fetch('/politico')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"the American Center for Law and Justice"} = ${$fb->query->find("/${$fb->fetch('/theACLJ')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"Right Wing News"} = ${$fb->query->find("/${$fb->fetch('/OfficialRightWingNews')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"American News"} = ${$fb->query->find("/${$fb->fetch('/ThePatriotReview')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"Fox News"} = ${$fb->query->find("/${$fb->fetch('/FoxNews')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"MSN"} = ${$fb->query->find("/${$fb->fetch('/msn')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"MSNBC"} = ${$fb->query->find("/${$fb->fetch('/msnbc')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"the Drudge Report"} = ${$fb->query->find("/${$fb->fetch('/mattdrudge')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"The Economist"} = ${$fb->query->find("/${$fb->fetch('/TheEconomist')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"TheBlaze"} = ${$fb->query->find("/${$fb->fetch('/theblaze')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"Yahoo News"} = ${$fb->query->find("/${$fb->fetch('/yahoonews')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"The Verge"} = ${$fb->query->find("/${$fb->fetch('/verge')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"Slate.com"} = ${$fb->query->find("/${$fb->fetch('/Slate')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"Glenn Beck"} = ${$fb->query->find("/${$fb->fetch('/GlennBeck')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"Sean Hannity"} = ${$fb->query->find("/${$fb->fetch('/SeanHannity')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"USA TODAY"} = ${$fb->query->find("/${$fb->fetch('/usatoday')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"ABC News"} = ${$fb->query->find("/${$fb->fetch('/ABCNews')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"Rush Limbaugh"} = ${$fb->query->find("/${$fb->fetch('/RushLimbaugh')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"PBS"} = ${$fb->query->find("/${$fb->fetch('/pbs')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"Bloomberg"} = ${$fb->query->find("/${$fb->fetch('/bloombergbusiness')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"Mother Jones"} = ${$fb->query->find("/${$fb->fetch('/motherjones')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"The Ed Schultz Show"} = ${$fb->query->find("/${$fb->fetch('/edschultzshow')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"ThinkProgress"} = ${$fb->query->find("/${$fb->fetch('/thinkprogress')}{id}/feed")->select_fields(qw(id name link message created_time))->where_since("-$time minutes")->request->as_hashref}{data};

#load info froms tsv file
open(my $research, "< news-sites-research.txt") or die("could not open txt");
my %websites;

while(<$research>){
    if($_ =~ /^(Known)?\t(.+)\t(http(s)?:\/\/)?(www\.)?(.*\.(com|org|co.uk).+?)\t(Left|Right|Unbiased|Far Left|Far Right)\t(more distrusted than trusted|more trusted than distrusted|about equally trusted and distrusted)/){
#         print $_,"\n";
        $websites{$6} = {
            url => $6,
            popularity => $1,
            source_name => $2,
            bias => $8,
            credibility => $9,
            };
    }
}
close ($research);

foreach my $source (keys %sourcepages){
    print "\n$source\n-----------------------------\n";
    foreach (@{$sourcepages{$source}}) {
        my $url = ${$_}{link};
#         print Dumper $_;
        if ($url =~ /^(http(s)?:\/\/)?(www\.)?(.*\.(com|org|co.uk).+?)/ && $websites{$4}){
            print "Domain: $4\n";
            print Dumper $websites{$4};
            my $message = "The Facebook page of $source originally shared this article. According to data gathered by the Pew Research Center, $websites{$4}{source_name} is $websites{$4}{credibility} by survey respondents who have heard of the source. ";
            if ($websites{$4}{popularity}){
                $message = $message."(Over 40% of respondents) ";
            }
            if ($websites{$4}{bias} =~ /Left|Right/){
                $message = $message."\nAdditionally, the research indicates that evaluations of this source's credibility varies among readers with different political views. ";
            } elsif($websites{$4}{bias}=~/Far Left/){
                $message = $message."\nAdditionally, the research indicates that left-leaning readers were much more likely to find this source credible than other readers. ";
            } elsif($websites{$4}{bias}=~/Far Right/){
                $message = $message."\nAdditionally, the research indicates that right-leaning readers were much more likely to find this source credible than other readers. ";
            }
            $message = $message."\n\nTo learn more about Pew Research Center's study on Political Polarization & Media Habits, follow this link to visit their report. https://goo.gl/xwVtjv";
            $fb->add_page_feed->set_page_id(${$page}{id})->set_message($message)->set_link_uri("$url")->publish;
        }
    }
}

print "\n\n\n\n\n"
