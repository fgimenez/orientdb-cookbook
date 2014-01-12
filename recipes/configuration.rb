execute 'config for db user' do
  command "sed -i 's#<storages>#<storages><storage path=\"memory:temp\" name=\"temp\" userName=\"#{node['orientdb']['db_user']}\" userPassword=\"#{node['orientdb']['db_password']}\" loaded-at-startup=\"true\" \/>#' #{node['orientdb']['default_config_file']}"
end

execute 'config for memory user' do
  command "sed -i 's#<users>#<users><user name=\"#{node['orientdb']['db_user']}\" password=\"#{node['orientdb']['db_password']}\" resources=\"*\"\/>#' #{node['orientdb']['default_config_file']}"
end
