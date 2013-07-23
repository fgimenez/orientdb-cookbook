[![Build Status](https://travis-ci.org/fgimenez/orientdb-cookbook.png)](https://travis-ci.org/fgimenez/orientdb-cookbook)

orientdb Cookbook
=================
This cookbook installs OrientDB (right now in single node mode)

Requirements
------------

It has been tested on Ubuntu 12.04, but should work on any platform where Java 1.6 works. 

The only dependency is with opscode's java cookbook. For testing the cookbook with Vagrant you need the vagrant-berkshelf and vagrant-omnibus plugins also (hopefully this will be handled by vundler soon...)

Attributes
----------
TODO: List you cookbook attributes here.

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

There is a Vagrantfile included in the repo, you can try the cookbook by:

    $ vagrant plugin install vagrant-berkshelf
    $ vagrant up

Then the server will be listening in its default ports in your local machine (2424 for binary access, 2480 for web studio)

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

License and Authors
-------------------
MIT License

Authors: Federico Gimenez Nieto <federico.gimenez@gmail.com>
