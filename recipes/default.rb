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
include_recipe 'git'

%w( knife github ssl_verify jenkins_cli_and_plugins my_jobs ).each do |recipe|
    include_recipe "my_pipeline_ubuntu::#{recipe}"
end
