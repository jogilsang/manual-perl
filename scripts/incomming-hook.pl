#!perl


# soure of link : https://github.com/tinyspeck/services-examples/blob/master/subversion.pl
# modifyed source of link : https://blog.hkwon.me/slack-subversion-intergration/

# Copyright 2013 Tiny Speck, Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


#
# An SVN post-commit handler for posting to Slack. Setup the channel and get the token
# from your team's services page. Change the options below to reflect your team's settings.
#
# Requires these perl modules:
# HTTP::Request
# LWP::UserAgent
# JSON


# Submits the following post to the slack servers

# POST https: //foo.slack.com/services/hooks/subversion?token=xxxxxx
# Content-Type: application/x-www-form-urlencoded
# Host: foo.slack.com
# Content-Length: 101

#
# I am not a perl programmer. Beware.
#

use warnings;
use strict;

use HTTP::Request::Common qw(POST);
use HTTP::Status qw(is_client_error);
use LWP::UserAgent;
use JSON;

# use Encode qw( decode );
# use Encode qw( decode encode );
# �ѱ� ����� ���� �߰�
use Encode;
# use Encode qw(decode_utf8);

# use utf8;
# use Encode;
use Encode::Guess;

my $ua = LWP::UserAgent->new;
$ua->timeout(15);

# slack
my $url = "URL";
my $message = "Hello, World!";

my $payload = {
    'text'  => $message
};

my $req = POST( "https://${url}", ['payload' => encode_json($payload)] );

my $s = $req->as_string;
print STDERR "Request:\n$s\n";

my $resp = $ua->request($req);
$s = $resp->as_string;
print STDERR "Response:\n$s\n";

