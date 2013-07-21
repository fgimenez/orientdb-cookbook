default[:orientdb][:user][:id] = 'orientdb'

default[:orientdb][:version] = '1.4.1'
default[:orientdb][:flavour] = 'graphed'

default[:orientdb][:base_tarball_url] = 'https://s3.amazonaws.com/orientdb/releases/orientdb'

default[:orientdb][:base_installation_directory] = "/opt"
default[:orientdb][:installation_directory] = "#{default[:orientdb][:base_installation_directory]}/orientdb"


