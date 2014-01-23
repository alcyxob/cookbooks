#
# Cookbook Name:: percona_cluster
# Recipe:: default
#
# Copyright 2013, EPAM
#
# All rights reserved - Do Not Redistribute
#
require 'ipaddr'

nodes = search(:node, "role:percona")
ipaddresses = []

if nodes.any?   
  nodes.each do |cur_node|
    ipaddresses.push(IPAddr.new(cur_node["ipaddress"]).to_i)
  end

  if ipaddresses.max == IPAddr.new(node["ipaddress"]).to_i
    node.set['cluster_status'] = "enabled"
    node.save
    include_recipe "percona_cluster::creator"
  else
    include_recipe "percona_cluster::joiner"
  end
end