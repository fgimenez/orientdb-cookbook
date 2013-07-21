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
include_recipe 'orientdb::user'
#include_recipe 'orientdb::structure'
include_recipe 'orientdb::dependencies'
include_recipe 'orientdb::resources'
include_recipe 'orientdb::scripts'
include_recipe 'orientdb::configuration'
