#!/usr/bin/perl

use strict;
use warnings;
use URI;
use Facebook::Graph;
use Data::Dumper;
use Cwd 'abs_path';
use File::Basename;

my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) =localtime(time);

printf ("***********************************************************************************\nStarted at %02d:%02d:%02d on %02d/%02d/%04d\n***********************************************************************************\n",$hour,$min,$sec,$mon,$mday,$year+1900);

#Authenticate with Facebook
my $access_token = 'EAAPvBQ5tbjMBAFDcZBq8Vv47JY0ZB7OjsxAcZBThXKr9YQzxoupQ6qmkFOW5M5M6ZC9ry5RyLQC2ttdyhRjEpt37J9eJhuNVKjzTaQfKoqib3bQ1Uvs0cV0hUsrEoIK1T6XOiAZCXbA0f89Hia6ssjgYC3Y8RHzgZD';
my $fb = Facebook::Graph->new;
$fb->access_token($access_token);
$fb->authorize->extend_permissions(qw(publish_stream read_stream));
my $page = $fb->fetch('/legitifact');

print Dumper $fb->query->find("/legitifact")->request;

my %sourcepages; #perlhash of Facebook page -> feed from last $time min
my $time = $ARGV[0]; #minutes

if (!$time){
    $time = 5;
}
printf "Querying souces from the past $time minutes....\n";
$sourcepages{"Opposing Views"} = ${$fb->query->find("/${$fb->fetch('/opposingviews')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"Occupy Democrats"} = ${$fb->query->find("/${$fb->fetch('/OccupyDemocrats')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"The Huffington Post"} = ${$fb->query->find("/${$fb->fetch('/HuffingtonPost')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"HuffPost Politics"} = ${$fb->query->find("/${$fb->fetch('/HuffPostPolitics')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"HuffPost Women"} = ${$fb->query->find("/${$fb->fetch('/HuffPostWomen')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"HuffPost Good News"} = ${$fb->query->find("/${$fb->fetch('/HuffPostGoodNews')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"The Wall Street Journal"} = ${$fb->query->find("/${$fb->fetch('/wsj')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"Upworthy"} = ${$fb->query->find("/${$fb->fetch('/Upworthy')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"The Young Turks"} = ${$fb->query->find("/${$fb->fetch('/TheYoungTurks')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"Daily Kos"} = ${$fb->query->find("/${$fb->fetch('/dailykos')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"The Atlantic"} = ${$fb->query->find("/${$fb->fetch('/TheAtlantic')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"TIME"} = ${$fb->query->find("/${$fb->fetch('/time')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"BuzzFeed"} = ${$fb->query->find("/${$fb->fetch('/BuzzFeedVideo')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"The New York Times"} = ${$fb->query->find("/${$fb->fetch('/nytimes')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"Mic"} = ${$fb->query->find("/${$fb->fetch('/MicMedia')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"CNN"} = ${$fb->query->find("/${$fb->fetch('/CNN')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"CNNMoney"} = ${$fb->query->find("/${$fb->fetch('/CNNMoney')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"CNN International"} = ${$fb->query->find("/${$fb->fetch('/CNNInternational')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"CNN Politics"} = ${$fb->query->find("/${$fb->fetch('/CNNPolitics')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"New York Magazine"} = ${$fb->query->find("/${$fb->fetch('/NewYorkMag')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"ATTN:"} = ${$fb->query->find("/${$fb->fetch('/attn')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"The Other 98%"} = ${$fb->query->find("/${$fb->fetch('/TheOther98')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"CBS News"} = ${$fb->query->find("/${$fb->fetch('/CBSNews')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"BBC News"} = ${$fb->query->find("/${$fb->fetch('/bbcnews')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"Washington Post"} = ${$fb->query->find("/${$fb->fetch('/washingtonpost')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"The Independent"} = ${$fb->query->find("/${$fb->fetch('/TheIndependentOnline')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"the Today Show"} = ${$fb->query->find("/${$fb->fetch('/today')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"The Daily Show"} = ${$fb->query->find("/${$fb->fetch('/thedailyshow')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"AJ+"} = ${$fb->query->find("/${$fb->fetch('/ajplusenglish')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"NBC News"} = ${$fb->query->find("/${$fb->fetch('/NBCNews')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"NowThis"} = ${$fb->query->find("/${$fb->fetch('/NowThisNews')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"The Guardian"} = ${$fb->query->find("/${$fb->fetch('/theguardian')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"VICE"} = ${$fb->query->find("/${$fb->fetch('/VICE')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"VICE News"} = ${$fb->query->find("/${$fb->fetch('/VICEnews')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"Daily Caller"} = ${$fb->query->find("/${$fb->fetch('/DailyCaller')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"POLITICO"} = ${$fb->query->find("/${$fb->fetch('/politico')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"the American Center for Law and Justice"} = ${$fb->query->find("/${$fb->fetch('/theACLJ')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"Right Wing News"} = ${$fb->query->find("/${$fb->fetch('/OfficialRightWingNews')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"American News"} = ${$fb->query->find("/${$fb->fetch('/ThePatriotReview')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"Fox News"} = ${$fb->query->find("/${$fb->fetch('/FoxNews')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"MSN"} = ${$fb->query->find("/${$fb->fetch('/msn')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"MSNBC"} = ${$fb->query->find("/${$fb->fetch('/msnbc')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"the Drudge Report"} = ${$fb->query->find("/${$fb->fetch('/mattdrudge')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"The Economist"} = ${$fb->query->find("/${$fb->fetch('/TheEconomist')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"TheBlaze"} = ${$fb->query->find("/${$fb->fetch('/theblaze')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"Yahoo News"} = ${$fb->query->find("/${$fb->fetch('/yahoonews')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"The Verge"} = ${$fb->query->find("/${$fb->fetch('/verge')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"Slate.com"} = ${$fb->query->find("/${$fb->fetch('/Slate')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"Glenn Beck"} = ${$fb->query->find("/${$fb->fetch('/GlennBeck')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"Sean Hannity"} = ${$fb->query->find("/${$fb->fetch('/SeanHannity')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"USA TODAY"} = ${$fb->query->find("/${$fb->fetch('/usatoday')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"ABC News"} = ${$fb->query->find("/${$fb->fetch('/ABCNews')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"ABC News Politics"} = ${$fb->query->find("/${$fb->fetch('/ABCNewsPolitics')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"Rush Limbaugh"} = ${$fb->query->find("/${$fb->fetch('/RushLimbaugh')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"PBS"} = ${$fb->query->find("/${$fb->fetch('/pbs')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"PBS News Hour"} = ${$fb->query->find("/${$fb->fetch('/newshour')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"Bloomberg"} = ${$fb->query->find("/${$fb->fetch('/bloombergbusiness')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"Bloomberg Politics"} = ${$fb->query->find("/${$fb->fetch('/BloombergPolitics')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"Mother Jones"} = ${$fb->query->find("/${$fb->fetch('/motherjones')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"The Ed Schultz Show"} = ${$fb->query->find("/${$fb->fetch('/edschultzshow')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"ThinkProgress"} = ${$fb->query->find("/${$fb->fetch('/thinkprogress')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"the Business Insider"} = ${$fb->query->find("/${$fb->fetch('/businessinsider')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"Newsweek"} = ${$fb->query->find("/${$fb->fetch('/newsweek')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"Breaking News"} = ${$fb->query->find("/${$fb->fetch('/BreakingNews')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"the AP"} = ${$fb->query->find("/${$fb->fetch('/APNews')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"Reuters"} = ${$fb->query->find("/${$fb->fetch('/Reuters')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"CNBC"} = ${$fb->query->find("/${$fb->fetch('/cnbc')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"NPR"} = ${$fb->query->find("/${$fb->fetch('/npr')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"NPR Politics"} = ${$fb->query->find("/${$fb->fetch('/nprpolitics')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"CBC News"} = ${$fb->query->find("/${$fb->fetch('/cbcnews')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"The Onion"} = ${$fb->query->find("/${$fb->fetch('/theonion')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"Wikileaks"} = ${$fb->query->find("/${$fb->fetch('/wikileaks')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"Al Jazeera"} = ${$fb->query->find("/${$fb->fetch('/aljazeera')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"The New Yorker"} = ${$fb->query->find("/${$fb->fetch('/newyorker')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};
$sourcepages{"Kotaku"} = ${$fb->query->find("/${$fb->fetch('/kotaku')}{id}/posts")->select_fields(qw(id name link message created_time caption))->where_since("-$time minutes")->request->as_hashref}{data};



#load info froms tsv file
my $path = dirname(abs_path($0));
open(my $research, "< $path/news-sites-research.tsv") or die("could not open datafile $path/../news-sites-research.tsv");
my %websites;

while(<$research>){
    if($_ =~ /^(Known)?\t(.+)\t(http(s)?:\/\/)?(www\.)?(.+?)(\/.*)?\t(Left|Right|Unbiased|Far Left|Far Right)\t(more distrusted than trusted|more trusted than distrusted|about equally trusted and distrusted)\t([0-9]+)\t([0-9]+)\t([0-9]+)\t([0-9]+)$/){
        #         print $_,"\n";
        $websites{$6} = {
            url => $6,
            popularity => $1,
            source_name => $2,
            bias => $8,
            credibility => $9,
            trusted => $10,
            distrusted => $11,
            neither => $12,
            unheard => $13,
        };
    }
}
close ($research);

foreach my $source (keys %sourcepages){
    print "\n$source\n-----------------------------\n";
    foreach (@{$sourcepages{$source}}) {
        my $url = ${$_}{link};
        my $caption = ${$_}{caption};
        print Dumper $_;
        if ($caption && $caption =~ /^(http(s)?:\/\/)?(www\.)?(.*\.)?(.+\..+)$/){
            my $domain = $5;
            print "\nDomain: $domain\n";
            if ($domain =~ /politi.co/ || $domain =~ /politico/){
                $domain = "politico.com";
                print "\nAlias: $domain\n";
            }
            if ($websites{$domain}){
                my $message = "The Facebook page of $source originally shared this article. According to data gathered by the Pew Research Center, $websites{$domain}{source_name} is $websites{$domain}{credibility} by survey respondents who have heard of the source. ";
                if ($websites{$domain}{popularity}){
                    $message = $message."(Over 40% of respondents) ";
                }
                if ($websites{$domain}{bias} =~ /Unbiased/){
                    $message = $message."\nAdditionally, the research indicates that left-leaning readers and right-leaning readers were about equally as likely to find this source credible. ";
                } elsif($websites{$domain}{bias}=~/Left/){
                    $message = $message."\nAdditionally, the research indicates that left-leaning readers were more likely to find this source credible than other readers. ";
                } elsif($websites{$domain}{bias}=~/Right/){
                    $message = $message."\nAdditionally, the research indicates that right-leaning readers were more likely to find this source credible than other readers. ";
                }
                my $temp = 100-$websites{$domain}{unheard};
                $message = $message."\n\nOut of the $temp% of respondents who have heard of $websites{$domain}{source_name},\n$websites{$domain}{trusted}%\ttrusted the news source,\n$websites{$domain}{distrusted}%\tdistrusted the news source, and\n$websites{$domain}{neither}%\tneither trusted nor distrusted the news source.";
                $message = $message."\n\nTo learn more about Pew Research Center's study on Political Polarization & Media Habits, follow this link to visit their report. https://goo.gl/xwVtjv";
                print Dumper $fb->add_page_feed->set_page_id(${$page}{id})->set_message("$message")->set_link_uri("$url")->publish;
            }
        }
    }
}

print "\n\n\n\n\n"
