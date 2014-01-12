group node['orientdb']['user']['id']

user node['orientdb']['user']['id'] do
  #shell '/bin/false'
  #system true
  shell '/bin/bash'
  home node['orientdb']['installation_directory']
  gid node['orientdb']['user']['id']
end
