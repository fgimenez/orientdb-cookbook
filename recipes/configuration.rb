%w(default-distributed-db-config.json  hazelcast.xml  orientdb-server-config.xml).each do |f|
  template ::File.join(node['orientdb']['installation_directory'] + "/config/", f) do
    source "#{f}.erb"
    owner node['orientdb']['user']['id']
    group node['orientdb']['user']['id']
    mode 0644
  end
end
