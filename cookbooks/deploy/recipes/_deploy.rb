package "unzip" do
  action :install
end

user node['jboss']['jboss_user'] do
  comment 'jboss user'
  home node['jboss']['jboss_home']
  system true
  shell '/bin/bash'
  password '$1$vbM1Ln9u$xQ1f1RdFUyJsuXp4sKpZs.'
end


remote_file "#{ node['jboss']['tmp_dir'] }/testweb.zip" do
  source node['jboss']['app_url']
  owner node['jboss']['jboss_user']
  group node['jboss']['jboss_group']
  mode '0755'
  action :create
  not_if { ::File.exists?("#{ node['jboss']['tmp_dir'] }/testweb.zip")}
end

execute 'extract_testweb_zipfile' do
  command "unzip testweb.zip -d #{ node['jboss']['deploy_path'] }"
  cwd node['jboss']['tmp_dir']
  not_if { File.directory?( "#{ node['jboss']['deploy_path']}/testweb" ) }
end
