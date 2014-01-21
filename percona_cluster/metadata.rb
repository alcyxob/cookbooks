name             'percona_cluster'
maintainer       'EPAM'
maintainer_email 'Oleksandr_vorobiov@epam.com'
license          'All rights reserved'
description      'Installs/Configures percona_cluster'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 	'openssl',         '~> 1.1'

recipe            'slave', 'Setup and run all nodes after first node'

attribute 'mysql/server_root_password',
  :display_name => 'MySQL Server Root Password',
  :description => 'Randomly generated password for the mysqld root user',
  :default => 'randomly generated'

