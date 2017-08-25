#
# Cookbook:: task4_nginx
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
package ["nginx"]

template "/etc/nginx/conf.d/lb.conf" do  
	source "lb.conf.erb"
end

template "/etc/nginx/nginx.conf" do  
	source "nginx.conf.erb"
end

service 'nginx' do  
	action [:enable, :start]  
	supports :restart => true, :reload => true
end

nginx_lb 'change_lb' do
  role 'apache_server'
  action :attach
  notifies :restart, 'service[nginx]'
end

nginx_lb 'change_lb' do
  role 'jboss_server'
  action :attach
  notifies :restart, 'service[nginx]'
end