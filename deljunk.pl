#!/usr/bin/perl

## Script to delete extra file created by latex and it's variants

use warnings ;
use strict ;
use File::Basename ;

## Variables
our ($scriptname) ;
$scriptname = basename($0);
my $delbackup = 'FALSE' ;

## Help subroutine
sub helptext(){
    
    my $sname = $0 ;

    print 
    "Deletes the extra file created by latex and it's variants in the\n",
    "current working directory.\n",
    "Usage: $sname [options]\n\n",

    "Options:\n",
    "-h|--help          Show this help and exit.\n",
    "-b                 Delete backup (*.*~ and .*.swp) files.\n",
    "-b-                Don't delete backup (*.*~ and .*.swp) files. Default.\n",
    ;
}

## Parse cli arguments
while ( $_ = $ARGV[0] ){
    if ( (/^-h$/) || (/^--help$/) ) {
        &helptext($scriptname);
        exit 0 ;
    } elsif (/^-b$/){
        $delbackup = 'TRUE' ;
    } elsif (/^-b-$/) {
        $delbackup = 'FALSE' ;
    } else {
        die("$scriptname: Unspecified option. Aborting.\n") ;
    }
    shift ;
}

## List of junk files
my @junk = ("*.aux","*.log","*.dvi","*.blg","*.bbl","*.bbx","*.end",
            "*.out","*.toc","*.los","*.bak","*.hp","*.relyx*","*.over",
            "*.nav","*.snm","*.vrb","*.tmp","*.idx","*.ilg","*.ind",
            "*.lof","*.lot","core","*.gls","*.nlo","*.nls","*.inputs",
            "*.bm","*.fdb_latexmk","*.synctex.gz","*.pdfsync","*.fls",
            "*.brf","*.spl","*.run.xml","*.axo","*.bcf","*.listing",
            "*.auxlock");

## List of backup files
my @backup = (".*.swp","*.*~","*.*.backup") ;

## Remove the junk file
foreach my $file (@junk){
    unlink(glob($file)) and print "Removed $file\n";
}

## Remove backup files
if ( $delbackup eq 'TRUE' ){
    foreach my $file (@backup){
        unlink(glob($file)) and print "Removed $file\n";
    }
}
