#
# Cookbook Name:: percona_cluster
# Recipe:: default
#
# Copyright 2013, EPAM
#
# All rights reserved - Do Not Redistribute
#

nodes = search(:node, "cluster_status:enabled")

if nodes.any?   
  include_recipe "percona_cluster::joiner"
else
  node.set['cluster_status'] = "enabled"
  node.save  
  include_recipe "percona_cluster::creator"
end
