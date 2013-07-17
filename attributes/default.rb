default[:orientdb][:user][:id] = 'orientdb'

default[:orientdb][:version] = '1.4.1'
default[:orientdb][:flavour] = 'graphed'

default[:orientdb][:base_tarball_url] = 'https://s3.amazonaws.com/orientdb/releases/orientdb'

default[:orientdb][:installation_directory]= "/opt/orientdb/#{default[:orientdb][:flavour]}"+
  "-#{default[:orientdb][:version]}"


