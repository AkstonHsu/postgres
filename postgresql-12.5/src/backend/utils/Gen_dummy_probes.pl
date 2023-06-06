#! /usr/bin/perl -w
#-------------------------------------------------------------------------
#
# Gen_dummy_probes.pl
#    Perl script that generates probes.h file when dtrace is not available
#
# Portions Copyright (c) 2008-2019, PostgreSQL Global Development Group
#
#
# IDENTIFICATION
#    src/backend/utils/Gen_dummy_probes.pl
#
# This program was generated by running perl's s2p over Gen_dummy_probes.sed
#
#-------------------------------------------------------------------------

# turn off perlcritic for autogenerated code
## no critic

$0 =~ s/^.*?(\w+)[\.\w+]*$/$1/;

use strict;
use Symbol;
use vars qw{ $isEOF $Hold %wFiles @Q $CondReg
  $doAutoPrint $doOpenWrite $doPrint };
$doAutoPrint = 1;
$doOpenWrite = 1;

# prototypes
sub openARGV();
sub getsARGV(;\$);
sub eofARGV();
sub printQ();

# Run: the sed loop reading input and applying the script
#
sub Run()
{
	my ($h, $icnt, $s, $n);

	# hack (not unbreakable :-/) to avoid // matching an empty string
	my $z = "\000";
	$z =~ /$z/;

	# Initialize.
	openARGV();
	$Hold    = '';
	$CondReg = 0;
	$doPrint = $doAutoPrint;
  CYCLE:
	while (getsARGV())
	{
		chomp();
		$CondReg = 0;    # cleared on t
	  BOS:;

		# /^[ 	]*probe /!d
		unless (m /^[ \t]*probe /s)
		{
			$doPrint = 0;
			goto EOS;
		}

		# s/^[ 	]*probe \([^(]*\)\(.*\);/\1\2/
		{
			$s = s /^[ \t]*probe ([^(]*)(.*);/${1}${2}/s;
			$CondReg ||= $s;
		}

		# s/__/_/g
		{
			$s = s /__/_/sg;
			$CondReg ||= $s;
		}

		# y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/
		{ y{abcdefghijklmnopqrstuvwxyz}{ABCDEFGHIJKLMNOPQRSTUVWXYZ}; }

		# s/^/#define TRACE_POSTGRESQL_/
		{
			$s = s /^/#define TRACE_POSTGRESQL_/s;
			$CondReg ||= $s;
		}

		# s/([^,)]\{1,\})/(INT1)/
		{
			$s = s /\([^,)]+\)/(INT1)/s;
			$CondReg ||= $s;
		}

		# s/([^,)]\{1,\}, [^,)]\{1,\})/(INT1, INT2)/
		{
			$s = s /\([^,)]+, [^,)]+\)/(INT1, INT2)/s;
			$CondReg ||= $s;
		}

		# s/([^,)]\{1,\}, [^,)]\{1,\}, [^,)]\{1,\})/(INT1, INT2, INT3)/
		{
			$s = s /\([^,)]+, [^,)]+, [^,)]+\)/(INT1, INT2, INT3)/s;
			$CondReg ||= $s;
		}

		# s/([^,)]\{1,\}, [^,)]\{1,\}, [^,)]\{1,\}, [^,)]\{1,\})/(INT1, INT2, INT3, INT4)/
		{
			$s =
			  s /\([^,)]+, [^,)]+, [^,)]+, [^,)]+\)/(INT1, INT2, INT3, INT4)/s;
			$CondReg ||= $s;
		}

		# s/([^,)]\{1,\}, [^,)]\{1,\}, [^,)]\{1,\}, [^,)]\{1,\}, [^,)]\{1,\})/(INT1, INT2, INT3, INT4, INT5)/
		{
			$s =
			  s /\([^,)]+, [^,)]+, [^,)]+, [^,)]+, [^,)]+\)/(INT1, INT2, INT3, INT4, INT5)/s;
			$CondReg ||= $s;
		}

		# s/([^,)]\{1,\}, [^,)]\{1,\}, [^,)]\{1,\}, [^,)]\{1,\}, [^,)]\{1,\}, [^,)]\{1,\})/(INT1, INT2, INT3, INT4, INT5, INT6)/
		{
			$s =
			  s /\([^,)]+, [^,)]+, [^,)]+, [^,)]+, [^,)]+, [^,)]+\)/(INT1, INT2, INT3, INT4, INT5, INT6)/s;
			$CondReg ||= $s;
		}

		# s/([^,)]\{1,\}, [^,)]\{1,\}, [^,)]\{1,\}, [^,)]\{1,\}, [^,)]\{1,\}, [^,)]\{1,\}, [^,)]\{1,\})/(INT1, INT2, INT3, INT4, INT5, INT6, INT7)/
		{
			$s =
			  s /\([^,)]+, [^,)]+, [^,)]+, [^,)]+, [^,)]+, [^,)]+, [^,)]+\)/(INT1, INT2, INT3, INT4, INT5, INT6, INT7)/s;
			$CondReg ||= $s;
		}

		# s/([^,)]\{1,\}, [^,)]\{1,\}, [^,)]\{1,\}, [^,)]\{1,\}, [^,)]\{1,\}, [^,)]\{1,\}, [^,)]\{1,\}, [^,)]\{1,\})/(INT1, INT2, INT3, INT4, INT5, INT6, INT7, INT8)/
		{
			$s =
			  s /\([^,)]+, [^,)]+, [^,)]+, [^,)]+, [^,)]+, [^,)]+, [^,)]+, [^,)]+\)/(INT1, INT2, INT3, INT4, INT5, INT6, INT7, INT8)/s;
			$CondReg ||= $s;
		}

		# P
		{
			if (/^(.*)/) { print $1, "\n"; }
		}

		# s/(.*$/_ENABLED() (0)/
		{
			$s = s /\(.*$/_ENABLED() (0)/s;
			$CondReg ||= $s;
		}
	  EOS: if ($doPrint)
		{
			print $_, "\n";
		}
		else
		{
			$doPrint = $doAutoPrint;
		}
		printQ() if @Q;
	}

	exit(0);
}
Run();

# openARGV: open 1st input file
#
sub openARGV()
{
	unshift(@ARGV, '-') unless @ARGV;
	my $file = shift(@ARGV);
	open(ARG, "<$file")
	  || die("$0: can't open $file for reading ($!)\n");
	$isEOF = 0;
}

# getsARGV: Read another input line into argument (default: $_).
#           Move on to next input file, and reset EOF flag $isEOF.
sub getsARGV(;\$)
{
	my $argref = @_ ? shift() : \$_;
	while ($isEOF || !defined($$argref = <ARG>))
	{
		close(ARG);
		return 0 unless @ARGV;
		my $file = shift(@ARGV);
		open(ARG, "<$file")
		  || die("$0: can't open $file for reading ($!)\n");
		$isEOF = 0;
	}
	1;
}

# eofARGV: end-of-file test
#
sub eofARGV()
{
	return @ARGV == 0 && ($isEOF = eof(ARG));
}

# makeHandle: Generates another file handle for some file (given by its path)
#             to be written due to a w command or an s command's w flag.
sub makeHandle($)
{
	my ($path) = @_;
	my $handle;
	if (!exists($wFiles{$path}) || $wFiles{$path} eq '')
	{
		$handle = $wFiles{$path} = gensym();
		if ($doOpenWrite)
		{
			if (!open($handle, ">$path"))
			{
				die("$0: can't open $path for writing: ($!)\n");
			}
		}
	}
	else
	{
		$handle = $wFiles{$path};
	}
	return $handle;
}

# printQ: Print queued output which is either a string or a reference
#         to a pathname.
sub printQ()
{
	for my $q (@Q)
	{
		if (ref($q))
		{

			# flush open w files so that reading this file gets it all
			if (exists($wFiles{$$q}) && $wFiles{$$q} ne '')
			{
				open($wFiles{$$q}, ">>$$q");
			}

			# copy file to stdout: slow, but safe
			if (open(RF, "<$$q"))
			{
				while (defined(my $line = <RF>))
				{
					print $line;
				}
				close(RF);
			}
		}
		else
		{
			print $q;
		}
	}
	undef(@Q);
}
