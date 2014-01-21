require 'rubygems'
require 'chef/config'
require 'chef/log'
require 'chef/rest'

node_ips = ''
chef_server_url = ''
client_name = ''

signing_key_filename='/etc/chef/client.pem'

File.open("/etc/chef/client.rb") do |f|
  f.each_line do |line|
    if line =~ /chef_server_url/
      chef_server_url = line.split(" ")[1].chomp('"').reverse.chomp('"').reverse
    end
    if line =~ /node_name/
      client_name = line.split(" ")[1].chomp('"').reverse.chomp('"').reverse
    end
  end
end

rest = Chef::REST.new(chef_server_url, client_name, signing_key_filename)
nodes = rest.get_rest("/nodes/")

JSON.create_id = ""
 
nodes.keys.each do |node_name|
    node = rest.get_rest("/nodes/#{node_name}/")
    node_ips = node_ips + node["ipaddress"] + ','
end

default["percona_server_ips"] = node_ips.chomp(',')