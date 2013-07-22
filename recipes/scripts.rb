template '/etc/init.d/orientdb' do
  source "orientdb-#{node[:orientdb][:version]}.sh.erb"
  mode "0755"
  variables({db_path: node[:orientdb][:installation_directory],
              db_user: node[:orientdb][:user][:id]})
end

service 'orientdb' do
  action [:enable, :start]
end
