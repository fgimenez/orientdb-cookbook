default['orientdb']['user']['id'] = 'orientdb'

default['orientdb']['version'] = '2.0.2'
default['orientdb']['flavour'] = 'community'

default['orientdb']['base_tarball_url'] = 'http://www.orientechnologies.com/download.php?email=unknown@unknown.com&os=linux&file=orientdb'

default['orientdb']['base_installation_directory'] = "/opt"
default['orientdb']['installation_directory'] = "#{default['orientdb']['base_installation_directory']}/orientdb"

default['orientdb']['default_config_file'] = "#{default['orientdb']['installation_directory']}/config/orientdb-server-config.xml"
default['orientdb']['default_init_script'] = "#{default['orientdb']['installation_directory']}/bin/orientdb.sh"
default['orientdb']['init_script'] = "/etc/init.d/orientdb"

default['orientdb']['db_user'] = 'admin'
default['orientdb']['db_password'] = 'admin'
