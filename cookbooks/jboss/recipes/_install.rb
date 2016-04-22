jboss_inst = node['jboss']['install_path']
jboss_home = node['jboss']['install_path'] + node['jboss']['install_dir']

package "unzip" do
  action :install
end

#Unzip jboss archive
execute 'unzip jboss archive' do
  command "unzip  -o /tmp/jboss-as-7.1.1.Final.zip -d #{jboss_inst}"
end


#Create user jboss
user node['jboss']['jboss_user'] do
    action :create
end

# Change owner of jboss directory
directory "node['jboss']['install_path'] + node['jboss']['install_dir']" do
    owner node['jboss']['jboss_user']
    group node['jboss']['jboss_group']
    mode "0755"
end

ruby_block 'set JBOSS_HOME in /etc/environment' do
  block do
    file = Chef::Util::FileEdit.new('/etc/environment')
    file.insert_line_if_no_match(/^JBOSS_HOME=/, "JBOSS_HOME=#{jboss_home}")
    file.search_file_replace_line(/^JBOSS_HOME=/, "JBOSS_HOME=#{jboss_home}")
    file.write_file
  end
end

# Install init script (stolen from jboss-eap)
template "/etc/init.d/jboss" do
  source "jboss-as-standalone-init.sh.erb"
  mode "0755"
  owner "root"
  group "root"
end

directory '/etc//jboss-as' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

template "/etc/jboss-as/jboss-as.conf" do
  source "jboss-as.erb"
  mode "0755"
  owner "root"
  group "root"
end

service "jboss" do
  action [:enable, :start]
end