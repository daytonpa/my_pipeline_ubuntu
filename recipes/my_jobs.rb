#
# Cookbook Name:: my_pipeline_ubuntu
# Recipe:: my_jobs
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

file_cache_path = Chef::Config[:file_cache_path]

node['my_pipeline_ubuntu'].tap do |pipeline|

    pipeline['git']['cookbooks'].each do |cookbook_name|
        config_path = ::File.join file_cache_path, "#{cookbook_name}-config.xml"

        # Create a config file for the jenkins job
        template config_path do
            source 'job-config.xml.erb'
    	    variables git_url: "#{pipeline['git']['url']}/#{cookbook_name}/tree/#{pipeline['git']['branch']}",
			    build_command: '_knife_commands.sh.erb',
			    cookbook: 'my_pipeline_ubuntu'
	    end

        jenkins_job cookbook_name do
    	    config config_path
            url "http://#{node['jenkins_ubuntu']['listen_address']}:#{node['jenkins_ubuntu']['listen_port']}"
	    end
    end
end
