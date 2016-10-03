
chef_directory = "#{node['jenkins_ubuntu']['home']}/.chef"

# Create the .chef directory
directory chef_directory do
    owner node['jenkins_ubuntu']['user']
    group node['jenkins_ubuntu']['group']
    mode '0755'
    action :create
end

# Create a knife and pem file for your
node['my_pipeline_ubuntu'].tap do |pipeline|
    template "#{chef_directory}/knife.rb" do
        owner node['jenkins_ubuntu']['user']
        group node['jenkins_ubuntu']['group']
        mode '0644'

        cookbook 'my_pipeline_ubuntu'
        source 'knife.rb.erb'
        # variables(
        # chef_server_url: node['my_pipeline_ubuntu']['chef_server_url'],
        # client_node_name: node['my_pipeline_ubuntu']['client_node_name']
        # )
    end

    file "#{chef_directory}/deploy_flix.pem" do
        owner node['jenkins_ubuntu']['user']
        group node['jenkins_ubuntu']['group']
        mode '0644'

        # content pipeline['pem_file']
    end
end
