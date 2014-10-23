psource = File.join(Chef::Config[:file_cache_path], "logster.rpm")

if node[:logster][:package][:source]
  remote_file psource do
    source node[:logster][:package][:source]
    checksum node[:logster][:package][:checksum]
    notifies :install, "package[logster]", :immediately
  end
end


package "logster" do
  if node[:logster][:install_method] == 'source'
    action :remove
  else
    source psource
  end
end
