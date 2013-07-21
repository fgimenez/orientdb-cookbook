directory node[:orientdb][:base_installation_directory] do
  user node[:orientdb][:user][:id]
  group node[:orientdb][:user][:id]
  mode 0755
  action :create
end
