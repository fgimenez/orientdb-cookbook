name             'orientdb'
maintainer       'Federico Gimenez Nieto'
maintainer_email 'fgimenez@coit.es'
license          'Apache-2.0'
description      'Installs/Configures OrientDB'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.4.0'

%w[ubuntu debian].each do |os|
  supports os
end

depends 'java'
depends 'apt'
depends 'tar'
