#
# Cookbook Name:: orientdb
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apt'
include_recipe 'java'
include_recipe 'tar'

#Stop Old OrientDB Service.
# - Only if there is an init script to support a stop command.
service "orientdb_old" do
  service_name "orientdb"
  action [:stop, :disable]
  supports :status => true, :start => true, :stop => true
  only_if { ::File.exist?(node['orientdb']['init_script']) }
end

include_recipe 'orientdb::user'
include_recipe 'orientdb::structure'
include_recipe 'orientdb::resources'
include_recipe 'orientdb::configuration'
include_recipe 'orientdb::scripts'

#Start the new OrientDB Service.
service "orientdb_new" do
  service_name "orientdb"
  supports :status => true, :start => true, :stop => true
  action [:start, :enable]
end
