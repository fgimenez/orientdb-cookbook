[![Build Status](https://travis-ci.org/fgimenez/orientdb-cookbook.png)](https://travis-ci.org/fgimenez/orientdb-cookbook)

OrientDB Cookbook
=================
This cookbook installs OrientDB (right now in single node mode)

Requirements
------------

It has been tested on Ubuntu 12.04, but should work on any platform where Java 1.6 works. 

The java and apt cookbooks are needed, as usual may be handled with Berkshelf. 

For testing the cookbook with Vagrant 1.2+ you need to install the plugins first. This dependencies are managed with Bindler:

    $ vagrant plugin bundle

More on blindler here https://github.com/fgrehm/bindler

Attributes
----------
* node[:orientdb][:user][:id]: User name
* node[:orientdb][:version]: Database version
* node[:orientdb][:flavour]: Flavour to be installed, document or graphed
* node[:orientdb][:base_tarball_url]: Partial location of the tarball url, flavour, version and extension removed
* node[:orientdb][:base_installation_directory]: Base install dir
* node[:orientdb][:installation_directory]: Absolute install dir, dependent on the base install dir
* node[:orientdb][:main_config_file]: Server config file name
* node[:orientdb][:db_user]: Admin DB user
* node[:orientdb][:db_password]: Admin DB password
* node[:orientdb][:binary_port]: Port for binary access
* node[:orientdb][:http_port]: Port for HTTP access

Usage
-----
Just include `orientdb` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[orientdb]"
  ]
}
```

Running the tests
-----------------

This is done thanks to berkshelf and strainer:

    $ bundle
    $ bundle exec berks install
    $ bundle exec strainer test

Vagrant usage
-------------

There is a Vagrantfile included in the repo, you can try the cookbook by just:

    $ vagrant up

The Vagrantfile is configured to open the default ports in your local machine (2424 for binary access, 2480 for web studio), remember to change this if you have cahnged the corresponding attributes.

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

Authors: Federico Gimenez Nieto <federico.gimenez@gmail.com>
