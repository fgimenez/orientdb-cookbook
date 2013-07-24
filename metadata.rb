name             'orientdb'
maintainer       'Federico Gimenez Nieto'
maintainer_email 'federico.gimenez@gmail.com'
license          'Apache-2.0'
description      'Installs/Configures OrientDB'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.1'

%w[ubuntu debian].each do |os|
  supports os
end

depends 'java'
depends 'apt'
