# # encoding: utf-8

# Inspec test for recipe my_pipeline_ubuntu::default

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

# build-essential packages
%w( autoconf binutils-doc bison build-essential flex
    gettext ).each do |pkg|
        describe package(pkg) do
            it { should be_installed }

        end
end

# Plugins directory for Jenkins pipeline
describe file('/var/lib/jenkins/plugins/') do
    it { should exist }
    its('owner') { should cmp 'jenkins' }
    its('group') { should cmp 'jenkins' }
    its('mode') { should cmp '0644' }
end

# Jenkins CLI
describe file('/var/lib/jenkins/plugins/jenkins-cli.jar') do
    it { should exist }
    it { should be_file }
    it { should be_executable }
    its('owner') { should cmp 'jenkins' }
    its('group') { should cmp 'jenkins' }
    its('mode') { should cmp '0755' }
end

# Default Jenkins plugins for the pipeline
%w( chef-identity git github github-api git-client scm-api ).each do |plugin|
    describe file("/var/lib/jenkins/plugins/#{plugin}") do
        it { should exist }
        it { should be_file }
        it { should be_executable }
        its('mode') { should cmp '0755' }
    end
end

# Extra Jenkins plugins
%w( chucknorris ).each do |misc|
    describe file("/var/lib/jenkins/plugins/#{misc}") do
        it { should exist }
        it { should be_file }
        it { should be_executable }
        its('mode') { should cmp '0755' }
    end
end

# .chef directory for pipeline
describe directory('/var/lib/jenkins/.chef') do
    it { should exist }
    it { should be_directory }
    its('owner') { should cmp 'jenkins' }
    its('group') { should cmp 'jenkins' }
    its('mode') { should cmp '0755' }
end

# knife.rb file for pipeline
describe file('/var/lib/jenkins/.chef/knife.rb') do
    it { should exist }
    it { should be_file }
    its('owner') { should cmp 'jenkins' }
    its('group') { should cmp 'jenkins' }
    its('mode') { should cmp '0644' }
end

describe file('/var/lib/jenkins/.chef/my_pipeline_ubuntu.pem') do
    it { should exist }
    it { should be_file }
    its('owner') { should cmp 'jenkins' }
    its('group') { should cmp 'jenkins' }
    its('mode') { should cmp '0644' }
end

# Listening address and port for pipeline
describe port(8080) do
    it { should be_listening }
    its('addresses') { should include '0.0.0.0' }
    its('processes') { should include 'java' }
    its('protocols') { should include 'tcp' }
    its('protocols') { should_not include 'tcp6' }
end
