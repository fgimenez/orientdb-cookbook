directory node['orientdb']['installation_directory'] do
  user node['orientdb']['user']['id']
  group node['orientdb']['user']['id']
  mode 0755
  action :create
end
