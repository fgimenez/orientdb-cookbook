#!/bin/bash
vagrant plugin install vagrant-omnibus
vagrant plugin install vagrant-hostmanager

bundle install --path=.bundle
rm -rf ./berks-cookbooks && bundle exec berks vendor

vagrant destroy --force
vagrant up --provision

