# SNMP::Info::Layer3::Radware
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

package SNMP::Info::Layer3::Radware;

use strict;
use warnings;
use Exporter;
use SNMP::Info::Layer3;

@SNMP::Info::Layer3::Radware::ISA = qw/SNMP::Info::Layer3 Exporter/;
@SNMP::Info::Layer3::Radware::EXPORT_OK = qw//;

our ($VERSION, %GLOBALS, %MIBS, %FUNCS, %MUNGE);

$VERSION = '3.972002';

%MIBS = (
    %SNMP::Info::Layer2::MIBS, %SNMP::Info::Layer3::MIBS,
    'RADWARE-MIB' => 'rndSysId',
);

%GLOBALS = (
    %SNMP::Info::Layer2::GLOBALS, %SNMP::Info::Layer3::GLOBALS,
    'serial1' => '.1.3.6.1.4.1.1872.2.5.1.3.1.18.0',
);

%FUNCS = (%SNMP::Info::Layer2::FUNCS, %SNMP::Info::Layer3::FUNCS,);

%MUNGE = (%SNMP::Info::Layer2::MUNGE, %SNMP::Info::Layer3::MUNGE,);

sub layers {
    return '01001100';
}

sub os {
    my $radware = shift;

    my $ver = $radware->description() || '';

    if ((lc $ver) =~ /Radware/) {
        return 'Radware';
    }
    else {
        return 'Radware';
    }
}

sub model {
    my $radware = shift;

    my $ver = $radware->description() || '';
    my @version = reverse split(/ /, $ver);

    return $version[0];
}

sub vendor {
    my $radware = shift;
    return $radware->os();
}

sub os_ver {
    my $radware = shift;

    my $ver = $radware->sysSoftware() || '';

    my @version = reverse split(/ /, $ver);

    return $version[2];
}

1;
__END__

=head1 NAME

SNMP::Info::Layer3::Radware - SNMP Interface to Vyatta Devices

=head1 SYNOPSIS

 # Let SNMP::Info determine the correct subclass for you.
 my $radware = new SNMP::Info(
                          AutoSpecify => 1,
                          Debug       => 1,
                          DestHost    => 'myrouter',
                          Community   => 'public',
                          Version     => 2
                        )
    or die "Can't connect to DestHost.\n";

 my $class      = $radware->class();
 print "SNMP::Info determined this device to fall under subclass : $class\n";

=head1 DESCRIPTION

Subclass for Radware Devices.

=head2 Inherited Classes

=over

=item SNMP::Info::Layer3

=back

=head2 Inherited Classes' MIBs

See L<SNMP::Info::Layer3/"Required MIBs"> for its own MIB requirements.

=head1 GLOBALS

These are methods that return scalar value from SNMP

=over

=item $radware->layers()

Returns support for 3, 4 and 7.

=item $radware->os()

Returns 'Radware' or 'Vyatta'.

=item $radware->model()

Returns the OS.

=item $radware->vendor()

Returns the OS.

=item $radware->os_ver()

Returns the software version extracted from C<sysDescr>.

=item $radware->serial()

Returns serial number.

=back

=head2 Globals imported from SNMP::Info::Layer3

See documentation in L<SNMP::Info::Layer3/"GLOBALS"> for details.

=head1 TABLE METHODS

=head2 Table Methods imported from SNMP::Info::Layer3

See documentation in L<SNMP::Info::Layer3/"TABLE METHODS"> for details.

=cut
