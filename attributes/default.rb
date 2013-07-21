default[:orientdb][:user][:id] = 'orientdb'

default[:orientdb][:version] = '1.4.1'
default[:orientdb][:flavour] = 'graphed'

default[:orientdb][:base_tarball_url] = 'https://s3.amazonaws.com/orientdb/releases/orientdb'

default[:orientdb][:base_installation_directory] = "/opt"
default[:orientdb][:installation_directory] = "#{default[:orientdb][:base_installation_directory]}/orientdb"

default[:orientdb][:main_config_file] = "#{default[:orientdb][:installation_directory]}/config/orientdb-server-config.xml"

default[:orientdb][:db_user] = 'admin'
default[:orientdb][:db_password] = 'admin'
