remote_file '/tmp/jboss-as-7.1.1.Final.zip' do
  source node['jboss']['package_url']
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end