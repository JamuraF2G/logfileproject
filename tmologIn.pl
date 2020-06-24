#!/usr/bin/perl -w
use Term::ANSIColor qw(:constants);
use File::Path;
#$Term::ANSIColor::AUTORESET = 1;
#
# Run log file  
#
# Usage: NA
# 
# Noel Lacson, November 12, 2019
#                                        
#
print BOLD GREEN,"W	 E	L	C	O	M	E	",BOLD BLUE,"T	O",RESET,"	    \n";
print BOLD YELLOW,"::::::'##::::'###::::'##::::'##:'##::::'##:'########:::::'###::::\n";
print BOLD YELLOW,":::::: ##:::'## ##::: ###::'###: ##:::: ##: ##.... ##:::'## ##:::\n";
print BOLD YELLOW,":::::: ##::'##:. ##:: ####'####: ##:::: ##: ##:::: ##::'##:. ##::\n";
print BOLD YELLOW,":::::: ##:'##:::. ##: ## ### ##: ##:::: ##: ########::'##:::. ##:\n";
print BOLD YELLOW,"'##::: ##: #########: ##. #: ##: ##:::: ##: ##.. ##::: #########:\n";
print BOLD YELLOW," ##::: ##: ##.... ##: ##:.:: ##: ##:::: ##: ##::. ##:: ##.... ##:\n";
print BOLD YELLOW,". ######:: ##:::: ##: ##:::: ##:. #######:: ##:::. ##: ##:::: ##:\n";
print BOLD YELLOW,":......:::..:::::..::..:::::..:::.......:::..:::::..::..:::::..::\n",RESET;

use Cwd;
my $host=`cat /proc/sys/kernel/hostname`;
my $gpsval = `cat /home/ran/Desktop/GPS/GPSLOG.csv`;

print BOLD GREEN,"Jamura Device ID:",RESET;print "$host";
print BOLD GREEN,"Coordinates     :",RESET;print "$gpsval\n";
print BOLD GREEN,"Site ID         :",RESET;my $site = <STDIN>;
print BOLD GREEN,"GDC Support	  :",RESET;my $gid = <STDIN>;
print BOLD GREEN,"Field User Email:",RESET;my $tce = <STDIN>;
print BOLD GREEN,"Field User Cell :",RESET;my $tc = <STDIN>;
print BOLD GREEN,"C & I Date	  :",RESET;my $dte = <STDIN>;
chomp $host;
chomp $gpsval;
chomp $site;
chomp $gid;
chomp $tce;
chomp $tc;
chomp $dte;


open( MYFILE, '>>loginInfo.txt' );    #creates file loginInfo.txt
print MYFILE "Jamura Device ID	:$host\n";
print MYFILE "Coordinate      	:$gpsval\n";
print MYFILE "Site ID         	:$site\n";
print MYFILE "GDC Support Email	:$gid\n";
print MYFILE "Field User Email	:$tce\n";
print MYFILE "Field User Cell 	:$tc\n";
print MYFILE "C & I Date	:$dte\n";

system("perl -pi.back -e 's/404: Not Found/ /g;' /var/log/loginInfo.txt");

system("mkdir $site");
my $rclonecmd =system("rclone listremotes");
my $cmd ="rclone copy ";
my $c = "sudo scp ";
system('clear');
print "Please wait....";
my $lista="loglist";
open(FILE,"<$lista") || die "File not found";
chomp(my @script = <FILE>);

foreach my $s (@script){
system("$c$s $site >/dev/null");
}
system("zip -r $site.zip $site >/dev/null");
#sub remove
#{
    #my $dir = "$site";
    #rmtree $dir;

#}
sleep(5);
my $Cdir = system("rclone mkdir googleDrive:tmologs");
my $log = system("sudo rclone copy $site.zip googleDrive:tmologs");
print $Cdir;
sleep(5);
print $rclonecmd;
#system("rclone mkdir googleDrive:tmologs");

sleep(5);
print $log;
#system("$log >/dev/null");
sleep(5);
print "Completed Thank you...";
sleep(5);

#remove();
exit(0);
