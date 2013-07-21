user node[:orientdb][:user][:id] do
  shell '/bin/false'
  system true
  home node[:orientdb][:installation_directory]
end
