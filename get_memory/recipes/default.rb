#
# Cookbook Name:: get_memory
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
template '/etc/memory.rep' do
  source 'memory.erb'
  owner  'root'
  group  'root'
  mode   '0644'
  action :create
end
