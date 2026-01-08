# Licensed Materials - Property of IBM
# IBM Sterling Selling and Fulfillment Suite
# (C) Copyright IBM Corp. 2001, 2013 All Rights Reserved.
# US Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
#
#                     LIMITATION OF LIABILITY
# THIS SOFTWARE SAMPLE IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED 
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF 
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. 
# IN NO EVENT SHALL STERLING COMMERCE, Inc. BE LIABLE UNDER ANY THEORY OF 
# LIABILITY (INCLUDING, BUT NOT LIMITED TO, BREACH OF CONTRACT, BREACH 
# OF WARRANTY, TORT, NEGLIGENCE, STRICT LIABILITY, OR ANY OTHER THEORY 
# OF LIABILITY) FOR (i) DIRECT DAMAGES OR INDIRECT, SPECIAL, INCIDENTAL, 
# OR CONSEQUENTIAL DAMAGES SUCH AS, BUT NOT LIMITED TO, EXEMPLARY OR 
# PUNITIVE DAMAGES, OR ANY OTHER SIMILAR DAMAGES, WHETHER OR NOT 
# FORESEEABLE AND WHETHER OR NOT STERLING OR ITS REPRESENTATIVES HAVE 
# BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES, OR (ii) ANY OTHER 
# CLAIM, DEMAND OR DAMAGES WHATSOEVER RESULTING FROM OR ARISING OUT OF
# OR IN CONNECTION THE DELIVERY OR USE OF THIS INFORMATION.

use strict;
use Getopt::Long;
use LWP::UserAgent;
use HTTP::Request::Common;
use File::Find;

# Modify the following to be a valid user/password combination.
my $userid='consoleadmin';
my $password='password';
my $url='http://localhost:28001/platformdemo/interop/SafeHttpServlet';

my $tokenid;


die "Usage: $0  -t apiName -m fileName  " unless @ARGV;

my $adapterName;
my $systemName;
my $apiName;
my $xmlFile;

our $opt_s;
our $opt_p;
our $opt_t;
our $opt_m;
our $opt_d;

GetOptions('s=s', 'p=s', 't=s', 'm=s', 'd=s');


die &Usage  unless  $opt_t ;

die &Usage1 unless $opt_m || $opt_d;

sub Usage1 () {
    print "Please specify at least the -m option for the filename \n";
    print "Or the -d directory option for the directory containing the xmls \n";
}

sub Usage () {
    print "Usage: $0 -t apiName";
    print " -m <xmlFileName> \n";
}

my $xmlData;
my $xmlFile = $opt_m;
my $ua = new LWP::UserAgent;

$ua->agent("AgentName/0.1 " . $ua->agent);

sub getSingleXml () {

die "Could not open file $opt_m" unless open (XML, $opt_m);

while (<XML>) {
    $xmlData .= $_;
}
close(XML);
}

&login();

if ($opt_m) {
    &getSingleXml();
    &postXML();
}

if ($opt_d) {
    find (\&postMultiXML, $opt_d);
}

&logout();

sub postMultiXML () {
    $xmlFile = $_;
    print "XML File is $xmlFile \n";
    $xmlData = undef;
    if ( $xmlFile =~ /xml/) {
	print "Sending XML $xmlFile \n";
	die "Could not open file $xmlFile" unless open(XML1, $xmlFile);
	while(<XML1>) {
	    $xmlData .= $_;
	}

	close(XML1);
	postXML();
    }
}


sub login () {
my $my_hash = {
    'YFSEnvironment.adapterName' => "DefaultAdapter",
    'YFSEnvironment.systemName'  => "DefaultSystem",
    'YFSEnvironment.userId' => $userid,
    'YFSEnvironment.password' => $password,
    'YFSEnvironment.progId' => "PerlHttpTest",
    InteropApiName => "login",
    InteropApiData  => "<Login LoginID='${userid}' Password='${password}' />"
    };
    my $res = $ua->request(POST  $url, $my_hash);
    if ($res->is_success) {
    	# print $res->content . "\n";
    	# Normally would parse the output as XML...
    	if($res->content =~ /\sUserToken="(.*?)"/) {
    		$tokenid = $1;
    		print $tokenid  ."\n";
    	} else {
    		die "Unable to find UserToken";
    	}
    } else {
    	print $res->content;
        die "Login failed";
    }
}

sub logout () {
    $opt_t="registerLogout";
    $xmlData="<registerLogout UserId='${userid}' SessionId='${tokenid}' UserToken='${tokenid}' />";
    postXML();
}

sub postXML () {
my $my_hash = {
    'YFSEnvironment.adapterName' => "DefaultAdapter",
    'YFSEnvironment.systemName'  => "DefaultSystem",
    'YFSEnvironment.userId' => $userid,
    'YFSEnvironment.userToken' => $tokenid,
    'YFSEnvironment.progId' => "PerlHttpTest",
    InteropApiName => $opt_t,
    InteropApiData  => $xmlData
    };


print "XML data is : $xmlData";

# Create a request
my $res = $ua->request(POST  $url, $my_hash);



  # Check the outcome of the response

if ($res->is_success) {

    print $res->content;
    print "\n";

  } else {
      print "Bad luck this time\n";

  }

}
