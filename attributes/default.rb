default['orientdb']['user']['id'] = 'orientdb'

default['orientdb']['version'] = '2.0.3'
default['orientdb']['flavour'] = 'community'

default['orientdb']['base_tarball_url'] = 'http://www.orientechnologies.com/download.php?email=unknown@unknown.com&os=linux&file=orientdb'

default['orientdb']['installation_directory'] = "/opt/orientdb"

default['orientdb']['default_init_script'] = "#{default['orientdb']['installation_directory']}/bin/orientdb.sh"
default['orientdb']['init_script'] = "/etc/init.d/orientdb"

default['orientdb']['db_user'] = 'admin'
default['orientdb']['db_password'] = 'admin'

default['orientdb']['hazelcast']['nodeName'] = node.name
default['orientdb']['hazelcast']['enabled'] = true
default['orientdb']['hazelcast']['group']['name'] = 'orientdb'
default['orientdb']['hazelcast']['group']['password'] = 'orientdb'
default['orientdb']['hazelcast']['network']['port'] = '2434'

default['orientbd']['hazelcast']['network']['join']['mode'] = 'multicast'
default['orientdb']['hazelcast']['network']['join']['multicast']['group'] = '235.1.1.1'
default['orientdb']['hazelcast']['network']['join']['multicast']['port'] = '2434'

default['orientdb']['hazelcast']['network']['join']['aws']['access-key'] = 'my-access-key'
default['orientdb']['hazelcast']['network']['join']['aws']['secret-key'] = 'my-secret-key'
default['orientdb']['hazelcast']['network']['join']['aws']['region'] = 'us-west-1'
default['orientdb']['hazelcast']['network']['join']['aws']['host-header'] = 'ec2.amazonaws.com'
default['orientdb']['hazelcast']['network']['join']['aws']['security-group-name'] = 'hazelcast-sg'
default['orientdb']['hazelcast']['network']['join']['aws']['tag-key'] = 'type'
default['orientdb']['hazelcast']['network']['join']['aws']['tag-value'] = 'hz-nodes'


default['orientdb']['node_search_criteria'] = "orientdb_hazelcast_group_name:#{node['orientdb']['hazelcast']['group']['name']} AND orientdb_hazelcast_group_password:#{node['orientdb']['hazelcast']['group']['password']}"

if Chef::Config[:solo]
  default['orientdb']['node_list'] = [node['hostname']]
else
  default['orientdb']['node_list'] = ([node] + (Chef::Search::Query.new.search(:node, node['orientdb']['node_search_criteria'])[0]))
    .map do |n|
      {
      'hostname' => n['hostname'],
      'port' => n['orientdb']['hazelcast']['network']['port']
      }
    end
end

default['orientdb']['hazelcast']['network']['join']['tcp-ip']['members'] = node['orientdb']['node_list']
  .map do |n|
    "#{n['hostname']}:#{n['port']}"
  end.uniq.sort

default['orientdb']['distributed']['clusters']['servers'] = node['orientdb']['node_list']
  .map do |n|
    n['hostname']
  end.uniq.sort
