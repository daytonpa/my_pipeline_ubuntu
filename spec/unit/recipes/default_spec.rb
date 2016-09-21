#
# Cookbook Name:: my_pipeline_ubuntu
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

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

    %w( omnijack autoconf binutils-doc bison build-essential
        flex gettext ncurses-dev ).each do |pkg|
            describe package('omnijack') do
                it { should be_installed.by('gem') }
            end
        end
    end
end
