#!"C:\xampp2\perl\bin\perl.exe"
print "Content-type : text/html\n\n";
use DBI;
use strict;
use CGI;

my $q = new CGI;

if ($q->param()) {
    # Parameters are defined, therefore the form has been submitted
    display_results($q);
}
my $searchData;
# Displays the results of the form
sub display_results($) {
    my ($q) = @_;

    $searchData = $q->param('search');
}

my $driver   = "SQLite"; 
my $database = "appointment.db";
my $dsn = "DBI:$driver:dbname=$database";
my $userid = "";
my $password = "";
my $dbh = DBI->connect($dsn, $userid, $password, { RaiseError => 1 }) 
                      or die $DBI::errstr;
my $query = "SELECT appdatetime, description from tbl_appointment where description" . " Like '". $searchData . "%'";

my $sth1 = $dbh->prepare($query);
my $rv1 = $sth1->execute() or die $DBI::errstr;

if($rv1 < 0){
   print $DBI::errstr;
}

my $result = "[";
while(my @row = $sth1->fetchrow_array()) {
      $result .= "{" . '"'. "appdatetime" . '"' . " : " . '"'. $row[0] . '"' ." , " . '"'. "description" .'"'. " : ". '"'. $row[1]. '"' . "},";
}
chop($result);
$result = $result ."]";
print $result;

$dbh->disconnect();

