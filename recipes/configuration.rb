#
template node[:orientdb][:main_config_file] do
  source "server-config-#{node[:orientdb][:version]}.xml.erb"
  user node[:orientdb][:user][:id]
  group node[:orientdb][:user][:id]
  variables({
              db_user: node[:orientdb][:db_user],
              db_password: node[:orientdb][:db_password],
              binary_port: node[:orientdb][:binary_port],
              http_port: node[:orientdb][:http_port]
            })
end
