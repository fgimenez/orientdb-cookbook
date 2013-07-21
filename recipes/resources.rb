flavour_version = "#{node[:orientdb][:flavour]}-#{node[:orientdb][:version]}"
filename = "#{flavour_version}.zip"
destination_path = "#{node[:orientdb][:base_installation_directory]}/#{filename}"
resource_url = "#{node[:orientdb][:base_tarball_url]}-#{filename}"

remote_file destination_path do
  source resource_url
end

execute "unzip the tarball" do
  command "unzip #{filename}"
  cwd node[:orientdb][:base_installation_directory]
  user node[:orientdb][:user][:id]
end

execute "symlink" do
  command "ln -s orientdb-#{flavour_version} orientdb"
  cwd node[:orientdb][:base_installation_directory]
  user node[:orientdb][:user][:id]
end

execute 'make the bin directory executable' do
  command "chmod -R 0775 bin"
  cwd node[:orientdb][:installation_directory]
end

file destination_path do
  action :delete
end
