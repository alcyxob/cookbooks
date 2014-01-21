#
# Cookbook Name:: percona_cluster
# Recipe:: default
#
# Copyright 2013, EPAM
#
# All rights reserved - Do Not Redistribute
#

::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)

arch = node["kernel"]["machine"]
arch = "i386" unless arch == "x86_64"
  
rpm_file = "percona-release-0.0-1.#{arch}.rpm"
remote_file "/var/tmp/#{rpm_file}" do
  source "http://www.percona.com/downloads/percona-release/#{rpm_file}"
  owner  "root"
  mode   0644
end

package "percona-release" do
  source "/var/tmp/#{rpm_file}"
  options "--nogpgcheck"
end

execute "remove conflicting mysql-libs" do
  command "rpm -e --nodeps mysql-libs"
  only_if "rpm -qa | grep mysql-libs"
end

package "Percona-XtraDB-Cluster-server-56" do 
  action :install  
end

template "/etc/my.cnf" do
  source "my.cnf.erb"
  mode "0644"
end

service 'mysql' do
  service_name 'mysql'
  supports     :status => true, :restart => true, :reload => true
  action       [:enable, :start]
end
