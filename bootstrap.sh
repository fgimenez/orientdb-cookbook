#!/bin/bash
vagrant plugin install vagrant-omnibus
vagrant plugin install vagrant-berkshelf
vagrant plugin install vagrant-hostmanager

vagrant destroy
vagrant up --provision

