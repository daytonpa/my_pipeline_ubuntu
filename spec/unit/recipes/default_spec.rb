#
# Cookbook Name:: my_pipeline_ubuntu
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Serverspec tests

require 'spec_helper'

describe 'chef-dk::default::package' do
    describe package('chefdk') do
        it { should be_installed }
    end
end

describe 'my_pipeline_ubuntu::default' do
    describe file('/var/lib/jenkins/.chef') do
        it { should exist }
        it { should be_directory }
        it { should be_owned_by 'jenkins' }
        it { should belong_to_group 'jenkins' }
        it { should be_mode '0755' }
    end

    describe file('/var/lib/jenkins/.chef/knife.rb') do
        it { should exist }
        it { should be_file }
        it { should be_owned_by 'jenkins' }
        it { should be_grouped_into 'jenkins' }
        it { should be_mode '0644'}
    end

    describe file('/var/lib/jenkins/plugins/jenkins-cli.jar') do
        it { should exist }
        it { should be_file }
        it { should be_mode '0755' }
        it { should be_executable }
    end

    # Default Jenkins plugins for the pipeline
    %w( chef-identity git github github-api git-client scm-api ).each do |plugin|
        describe file("/var/lib/jenkins/plugins/#{plugin}") do
            it { should exist }
            it { should be_file }
            it { should be_executable }
            it { should be_mode '0755' }
        end
    end

    # Extra Jenkins plugins
    %w( chucknorris ).each do |misc|
        describe file("/var/lib/jenkins/plugins/#{misc}") do
            it { should exist }
            it { should be_file }
            it { should be_executable }
            it { should be_mode '0755' }
        end
    end

    %w( autoconf binutils-doc bison build-essential
        flex gettext ).each do |pkg|
        describe file("/var/lib/jenkins/plugins/#{pkg}.hpi") do
            it { should exist }
            it { should be_file }
            it { should be_mode '0755' }
        end
    end
end
