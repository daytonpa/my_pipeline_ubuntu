#
# Cookbook Name:: my_pipeline_ubuntu
# Recipe:: git
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Override fingerprint rsa
directory "#{node['jenkins_ubuntu']['home']}/.ssh/" do
    owner node['jenkins_ubuntu']['user']
    group node['jenkins_ubuntu']['group']
    mode '0644'
end

file "#{node['jenkins_ubuntu']['home']}/.ssh/config" do
	content <<-eos
	Host github.com
		StrictHostKeyChecking no
	eos
  	owner node['jenkins_ubuntu']['user']
  	group node['jenkins_ubuntu']['group']
end
