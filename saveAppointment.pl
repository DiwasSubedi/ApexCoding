#!"C:\xampp2\perl\bin\perl.exe"
print "Content-type : text/html\n\n";
use DBI;
use strict;
use CGI;

# Displays the results of the form


my $driver   = "SQLite"; 
my $database = "appointment.db";
my $dsn = "DBI:$driver:dbname=$database";
my $userid = "";
my $password = "";
my $dbh = DBI->connect($dsn, $userid, $password, { RaiseError => 1 }) 
                      or die $DBI::errstr;

my $q = new CGI;
my $date;
my $time;
my $desc;

if ($q->param()) {
    # Parameters are defined, therefore the form has been submitted
    display_results($q);
}else{
   print "No data has been passed";
   return;
}

# Displays the results of the form
sub display_results($) {
    my ($q) = @_;

    $date = $q->param('newDate');
	$time = $q->param('newTime');
	$desc = $q->param('newDescription');
}
my $datetime = $date . " " . $time;
my $query = qq(INSERT INTO tbl_appointment (appdatetime , description) VALUES ('$datetime','$desc'));
print $query;

my $sth = $dbh->prepare($query);
my $rv = $sth->execute()  or die $DBI::errstr;
if($rv < 0){
    print $DBI::errstr;
}

$dbh->disconnect();
