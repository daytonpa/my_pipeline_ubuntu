#
# Cookbook Name:: my_pipeline_ubuntu
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

#   This recipe is a long run list for my_pipeline_ubuntu

#   The jenkins_ubuntu cookbook is included in the run_list
# of this cookbook's kitchen.yaml.  It will install the
# latest stable version of Jenkins and includes Java 7.


include_recipe 'my_pipeline_ubuntu::chefdk'
include_recipe 'chef-zero'
include_recipe 'my_pipeline_ubuntu::knife'
include_recipe 'my_pipeline_ubuntu::jenkins_cli_and_plugins'

# include_recipe 'my_pipeline_ubuntu::my_jobs'

#
# - recipe[pipeline_test]
# - recipe[pipeline::jenkins]
# - recipe[pipeline::chefdk]
# - recipe[chef-zero]
# - recipe[pipeline::knife]
# - recipe[pipeline::jobs]
