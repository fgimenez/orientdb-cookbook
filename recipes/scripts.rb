execute 'copy init script' do
  command "cp #{node[:orientdb][:default_init_script]} #{node[:orientdb][:init_script]}"
end

execute 'set db path' do
  command "sed -i 's#DB_DIR=\".*\"#DB_DIR=\"#{node[:orientdb][:installation_directory]}\"#' #{node[:orientdb][:init_script]}"
end

execute 'set db user' do
  command "sed -i 's/DB_USER=\".*\"/DB_USER=\"#{node[:orientdb][:user][:id]}\"/' #{node[:orientdb][:init_script]}"
end

file node[:orientdb][:init_script] do
  mode "0755"
end

service 'orientdb' do
  action [:enable, :start]
end
