# SNMP::Info::Layer3::Hillstone
#
# Copyright (c) 2025 WENWU YAN
# Email: 968828@gmail.com
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
#     * Redistributions of source code must retain the above copyright notice,
#       this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of the University of California, Santa Cruz nor the
#       names of its contributors may be used to endorse or promote products
#       derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
# LIABLE FOR # ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

package SNMP::Info::Layer3::Hillstone;

use strict;
use warnings;
use Exporter;
use SNMP::Info::Layer3;

@SNMP::Info::Layer3::Hillstone::ISA = qw/SNMP::Info::Layer3 Exporter/;
@SNMP::Info::Layer3::Hillstone::EXPORT_OK = qw//;

our ($VERSION, %GLOBALS, %MIBS, %FUNCS, %MUNGE);

$VERSION = '3.972002';

%MIBS = (
    %SNMP::Info::Layer2::MIBS, %SNMP::Info::Layer3::MIBS,
    'HILLSTONE-SYSTEM-MIB' => 'hillstoneSysMibObjects',
);

%GLOBALS = (
    %SNMP::Info::Layer2::GLOBALS, %SNMP::Info::Layer3::GLOBALS,
    #'serial_id' => '.1.3.6.1.4.1.28557.2.2.1.1.0',
);

%FUNCS = (%SNMP::Info::Layer2::FUNCS, %SNMP::Info::Layer3::FUNCS,);

%MUNGE = (%SNMP::Info::Layer2::MUNGE, %SNMP::Info::Layer3::MUNGE,);

sub layers {
    return '01001100';
}

sub os {
    my $hillstone = shift;

    my $ver = $hillstone->description() || '';

    if ((lc $ver) =~ /Hillstone/) {
        return 'Hillstone';
    }
    else {
        return 'Hillstone';
    }
}

sub model {
    my $hillstone = shift;

    my $ver = $hillstone->description() || '';
    my @myVer = reverse split(/ /, $ver);

    return @myVer[0];
}

sub vendor {
    my $hillstone = shift;
    return $hillstone->os();
}

sub os_ver {
    my $hillstone = shift;

    my $ver = $hillstone->sysSoftware() || '';

    my @myVer = reverse split(/ /, $ver);

    return @myVer[2];
}

sub serial {
    my $hillstone = shift;
    return $hillstone->sysSerialNumber();
}

1;
__END__

=head1 NAME

SNMP::Info::Layer3::Hillstone - SNMP Interface to Vyatta Devices

=head1 SYNOPSIS

 # Let SNMP::Info determine the correct subclass for you.
 my $hillstone = new SNMP::Info(
                          AutoSpecify => 1,
                          Debug       => 1,
                          DestHost    => 'myrouter',
                          Community   => 'public',
                          Version     => 2
                        )
    or die "Can't connect to DestHost.\n";

 my $class      = $hillstone->class();
 print "SNMP::Info determined this device to fall under subclass : $class\n";

=head1 DESCRIPTION

Subclass for Hillstone.

=head2 Inherited Classes

=over

=item SNMP::Info::Layer3

=back

=head2 Inherited Classes' MIBs

See L<SNMP::Info::Layer3/"Required MIBs"> for its own MIB requirements.

=head1 GLOBALS

These are methods that return scalar value from SNMP

=over

=item $hillstone->layers()

Returns support for 3, 4 and 7.

=item $hillstone->os()

Returns 'Hillstone' or 'Vyatta'.

=item $hillstone->model()

Returns the OS.

=item $hillstone->vendor()

Returns the OS.

=item $hillstone->os_ver()

Returns the software version extracted from C<sysDescr>.

=item $hillstone->serial()

Returns serial number.

=back

=head2 Globals imported from SNMP::Info::Layer3

See documentation in L<SNMP::Info::Layer3/"GLOBALS"> for details.

=head1 TABLE METHODS

=head2 Table Methods imported from SNMP::Info::Layer3

See documentation in L<SNMP::Info::Layer3/"TABLE METHODS"> for details.

=cut
