directory node[:orientdb][:installation_directory] do
  user node[:orientdb][:user][:id]
  mode 0644
  action :create
end
