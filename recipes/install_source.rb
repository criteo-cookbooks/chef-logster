package "git"

if platform_family?("rhel")
    package "logcheck"
else
    package "logtail"
end

tempdir = node[:logster][:git][:tempdir]

git 'logster' do
    repository node[:logster][:repository]
    destination tempdir
    reference node[:logster][:version]
    notifies :run, 'execute[create logster]'
end

directory "/usr/share/logster" do
    owner "root"
    group "root"
    mode "0755"
end

directory "/var/log/logster" do
    owner "root"
    group "root"
    mode "0755"
end

execute "create logster" do
    command "python #{tempdir}/setup.py install"
end
