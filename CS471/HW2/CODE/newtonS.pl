#!/usr/apps/bin/perl
#
# perl program to try the convergence for different functions 
# when using Newtoon's method for f(x) = 0
# run with : perl newton.pl
#
#
# Here is the generic file
$cmdFile="./newtonS.f90.Template";
$outFile="./newtonS.f90";
$OutFile="./tmp.txt";
# Stuff to converge over
@array_f = ("x", "x*x", "sin(x)+cos(x*x)");
@array_fp = ("1.d0", "2.d0*x", "cos(x)-2.d0*x*sin(x*x)" );
@array_multiplicity = ("1", "2", "1" );
open my $fh, '>', $OutFile;
for( $m=0; $m < 3; $m = $m+1)
{
    # Open the Template file and the output file. 
    open(FILE,"$cmdFile") || die "cannot open file $cmdFile!" ;
    open(OUTFILE,"> $outFile") || die "cannot open file!" ;
    # Setup the outfile based on the template
    # read one line at a time.
    while( $line = <FILE> )
    {
        # Replace the the stings by using substitution
        # s
        $line =~ s/\bFFFF\b/$array_f[$m]/;
        $line =~ s/\bFPFP\b/$array_fp[$m]/;
        $line =~ s/\bTTTT\b/$array_multiplicity[$m]/;
        print OUTFILE $line;
    }
    # Close the files
    close( OUTFILE );
    close( FILE );
    
    # Run the shell commands to compile and run the program
    system("gfortran $outFile");
    system("./a.out >> " . $OutFile);
}
open(FILE,$OutFile) || die "cannot open file" ;
while( $line = <FILE> )
{
$line =~ s/\s+/ , /g;  # Globally replace chunks of whitespace with a " , "
$line =  $line . "\n"; # Add a newline as the above removes it.
$line =~ s/ , $/ /;    # Remove the last " , "
$line =~ s/ , / /;     # Remove the first " , "
print $line;           # Print to screen
}
close( FILE );
exit

