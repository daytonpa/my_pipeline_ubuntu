#
# Cookbook Name:: my_pipeline_ubuntu
# Recipe:: my_jobs
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

file_cache_path = Chef::Config[:file_cache_path]

%w( deploy_flix rr_install ).each do |cookbook_name|

	config_path = ::File.join file_cache_path, "#{cookbook_name}-config.xml"

	template config_path do
    	source 'job-config.xml.erb'
    	variables git_url: "https://github.com/daytonpa/#{cookbook_name}.git",
			build_command: '_knife_commands.sh.erb',
			cookbook: 'my_pipeline_ubuntu'
	end
	jenkins_job cookbook_name do
    	config config_path
	end
end
