# Install the latest chef-dk
chef_dk 'my_pipeline_chefdk' do
    version node['chef_dk']['version']
    global_shell_init true
    action :install
end
