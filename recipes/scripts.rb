execute 'copy init script' do
  command "cp #{node['orientdb']['default_init_script']} #{node['orientdb']['init_script']}"
end

file node['orientdb']['init_script'] do
  mode "0755"
end

execute 'set db path' do
  command "sed -i 's#DB_DIR=\".*\"#DB_DIR=\"#{node['orientdb']['installation_directory']}\"#' #{node['orientdb']['init_script']}"
end

execute 'set db user' do
  command "sed -i 's/DB_USER=\".*\"/DB_USER=\"#{node['orientdb']['user']['id']}\"/' #{node['orientdb']['init_script']}"
end

#fix the stop script to not return until stop complete (by removing & from end). - Prevents restart from working as it issues start while still stopping.
execute 'set service stop as modal' do
  command "sed -i 's|./shutdown.sh 1>>../log/orientdb.log 2>>../log/orientdb.err &|./shutdown.sh 1>>../log/orientdb.log 2>>../log/orientdb.err|' #{node['orientdb']['init_script']}"
end

#fix the exit code of status when service is running.  currently returning PID instead of 0 as per Linux standards. - Prevents start as Chef won't start a service that reports as already started.
execute 'set service status running to correct exit value' do
  command "sed -i 's|server daemon is running with PID: $PID\"|& \\&\\& exit 0|' #{node['orientdb']['init_script']}"
end

#fix the exit code of status when service is NOT running.  currently returning 0 instead of 3 as per Linux standards. - Prevents start as Chef won't start a service that is reports as already running.
execute 'set service status not runnint to correct exit value' do
  command "sed -i 's|server daemon is NOT running\"|& \\&\\& exit 3|' #{node['orientdb']['init_script']}"
end
