puppet module for pnp4nagios
============================

PNP is an addon for Nagios that analyzes performance data provided by plugins and stores them automatically into Round Robin Databases (RRD)
This module will help you to setup and configure pnp4nagios. 

Basic usage
-----------

To install and configure pnp4nagios:

<pre>
	class {'pnp4nagios':
		backend_name => 'foobar'
	}
</pre>

To setup npcd:

<pre>
	include pnp4nagios::npcd
</pre>

or 

<pre>
	class {'pnp4nagios::npcd':}
</pre>

To setup the processing of performance data:

<pre>
	class {'pnp4nagios::process_perfdata':
		rrd_daemon_opts => 'unix:/var/run/rrdcached.sock',
	}
</pre>


For all options of these classes, please see manifests/init.pp and/or manifests/process_perfdata and manifests/npcd

Caveats
-------

None so far.

TODOs
-----

None so far.

Copyright and License
---------------------

Copyright (C) 2012 Patrick Ringl <patrick_@freenet.de>

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.


