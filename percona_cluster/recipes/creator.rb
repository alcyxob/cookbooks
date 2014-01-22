#
# Cookbook Name:: percona_cluster
# Recipe:: creator
#
# Copyright 2013, EPAM
#
# All rights reserved - Do Not Redistribute
#

::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)
::Chef::Recipe.send(:include, Opscode::Mysql::Helpers)

node.set['mysql_root_password']   = secure_password
node.save

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

execute "Initial start" do
  command "/etc/init.d/mysql start --wsrep-cluster-address=\"gcomm://\""
  not_if { ::File.exists?("/var/lib/mysql/mysql.sock")}
end
 
cmd = assign_root_password_cmd
execute 'assign-root-password' do
  command cmd
  action :run
  only_if "/usr/bin/mysql -u root -e 'show databases;'"
end

template '/etc/mysql_grants.sql' do
  source 'grants.sql.erb'
  owner  'root'
  group  'root'
  mode   '0600'
  action :create
end

cmd = install_grants_cmd
execute 'install-grants' do
    not_if { ::File.exists?("/root/mysql_pass")}
    command cmd
end

template '/root/mysql_pass' do
  source 'mysql_pass.erb'
  owner  'root'
  group  'root'
  mode   '0600'
  not_if { ::File.exists?("/root/mysql_pass")}
  action :create
end
                    
service 'mysql' do
  service_name 'mysql'
  supports     :status => true, :restart => true, :reload => true
  action       [:enable, :start]
end
