# # encoding: utf-8

# Inspec test for recipe my_pipeline_ubuntu::default

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html
describe package('omnijack') do
    it { should be_installed }
end

%w( autoconf binutils-doc bison build-essential flex
    gettext ).each do |pkg|
        describe package(pkg) do
            it { should be_installed }
        end
end

describe directory('/var/lib/jenkins/.chef') do
    it { should exist }
    it { should be_directory }
    its('owner') { should cmp 'jenkins' }
    its('group') { should cmp 'jenkins' }
    its('mode') { should cmp '0755' }
end

describe file('/var/lib/jenkins/.chef/knife.rb') do
    it { should exist }
    it { should be_file }
    its('owner') { should cmp 'jenkins' }
    its('group') { should cmp 'jenkins' }
    its('mode') { should cmp '0644' }
end

describe port(8080) do
    it { should be_listening }
    its('addresses') { should include '0.0.0.0' }
    its('processes') { should include 'java'}
    its('protocols') { should include 'tcp'}
end
