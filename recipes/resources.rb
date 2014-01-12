flavour_version = "#{node['orientdb']['flavour']}-#{node['orientdb']['version']}"
filename = "#{flavour_version}.tar.gz"
destination_path = "#{node['orientdb']['base_installation_directory']}/#{filename}"
resource_url = "#{node['orientdb']['base_tarball_url']}-#{filename}"

remote_file destination_path do
  source resource_url
end

directory "#{node['orientdb']['base_installation_directory']}/orientdb-#{flavour_version}" do
  action :delete
  recursive true
end

execute "untar the tarball" do
  command "tar -xzvf #{filename}"
  cwd node['orientdb']['base_installation_directory']
end

execute "symlink" do
  command "ln -s orientdb-#{flavour_version} orientdb"
  cwd node['orientdb']['base_installation_directory']
end

execute 'make the bin directory executable' do
  command "chmod -R 0775 bin"
  cwd node['orientdb']['installation_directory']
end

execute 'change ownership' do
  command "chown -R #{node['orientdb']['user']['id']}:#{node['orientdb']['user']['id']} ."
  cwd node['orientdb']['installation_directory']
end

file destination_path do
  action :delete
end
