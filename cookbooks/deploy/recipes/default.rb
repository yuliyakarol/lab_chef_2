if node['jboss']['skip']
  Chef::Log.warn('Skipping install of Jboss!')
else
  include_recipe 'jboss::_download_jboss'
  
  include_recipe 'jboss::_install'
  
  include_recipe 'jboss::_deploy'
end