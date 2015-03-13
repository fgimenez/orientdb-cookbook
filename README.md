[![Build Status](https://travis-ci.org/fgimenez/orientdb-cookbook.png)](https://travis-ci.org/fgimenez/orientdb-cookbook)

OrientDB Cookbook
=================
This cookbook installs OrientDB

Requirements
------------

It has been tested on Ubuntu 12.04, but should work on any platform where Java 1.6 works. 

The java and apt cookbooks are needed, as usual may be handled with Berkshelf. 


General Attributes:

|Attribute|Description|Default value|
|---------|-----------|-------------|
|`node['orientdb']['user']['id']`|User name|`orientdb`|
|`node['orientdb']['version']`|Database version|`2.0.3`|
|`node['orientdb']['flavour']`|Flavour to be installed, now only community|`community`|
|`node['orientdb']['base_tarball_url']`|Partial location of the tarball url, flavour, version and extension removed|`http://www.orientechnologies.com/download.php?email=unknown@unknown.com&os=linux&file=orientdb`|
|`node['orientdb']['installation_directory']`|Absolute install dir, dependent on the base install dir|`/opt/orientdb`|
|`node['orientdb']['default_init_script']`|Full path to tarball's init script|`/opt/orientdb/bin/orientdb.sh`|
|`node['orientdb']['init_script']`|Full path to actual init script|`/etc/init.d/orientdb`|
|`node['orientdb']['db_user']`|Admin DB user|`admin`|
|`node['orientdb']['db_password']`|Admin DB password|`admin`|

Distributed Attributes:

|Attribute|Description|Default value|
|---------|-----------|-------------|
|`node['orientdb']['hazelcast']['nodeName']`|Node Name|`{node.name}`|
|`node['orientdb']['hazelcast']['enabled']`|Enable Hazelcast plugin|`true`|
|`node['orientdb']['hazelcast']['group']['name']`|Hazelcast group name|`orientdb`|
|`node['orientdb']['hazelcast']['group']['password']`|Hazelcast group password|`orientdb`|
|`node['orientdb']['hazelcast']['network']['join']['multicast']['enabled']`|Enable Hazelcast multicast|`orientdb`|
|`node['orientdb']['hazelcast']['network']['join']['multicast']['group']`|Hazelcast multicast host|`orientdb`|
|`node['orientdb']['hazelcast']['network']['join']['multicast']['port']`|Hazelcast multicast port|`orientdb`|
|`node['orientdb']['node_search_criteria']`|Chef Search criteria for locating peers.|Match on hazelcast group name & password (from above)|
|`node['orientdb']['hazelcast']['network']['join']['tcp-ip']['members']`|Array of hostname:port of peer hazelcast members to populate hazelcast.xml file.|hostname:port list from node_search_criteria (above)|
|`node['orientdb']['distributed']['clusters']['servers']`|Array of hostnames to populate default-distributed-db-config.json file.|hostname list from node_search_criteria (above)|



Running the tests
-----------------

Just execute the default rake task:

    $ bundle install
    $ bundle exec rake

Vagrant usage
-------------

For testing the cookbook with Vagrant 1.2+ you just have to execute bootstrap.sh:

    $ bootstrap.sh

It installs the required Vagrant plugins and launchs the machine. After the process you have a orientdb instance running in ```orientdb.local``` host, ip 33.33.33.33 (you may need to provide root privileges to allow vagrant-hostmanager do its duty).

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

License and Authors
-------------------
MIT License

Authors: Federico Gimenez Nieto <fgimenez@coit.es>

