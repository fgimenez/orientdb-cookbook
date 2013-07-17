filename = "#{node[:orientdb][:flavour]}-#{node[:orientdb][:version]}.zip"
destination_path = "#{node[:orientdb][:installation_directory]}/#{filename}"
resource_url = "#{node[:orientdb][:base_tarball_url]}-#{filename}"

remote_file destination_path do
  source resource_url
end

execute "unzip the tarball" do
  command "unzip #{filename}"
  cwd node[:orientdb][:installation_directory]
  user node[:orientdb][:user][:id]
end

file destination_path do
  action :delete
end
