# Create the .chef directory
directory "#{node['jenkins_ubuntu']['home']}/.chef" do
    owner node['jenkins_ubuntu']['user']
    group node['jenkins_ubuntu']['group']
    mode '0755'
    action :create
end

# Create a knife and pem file for your
node['my_pipeline_ubuntu'].tap do |pipeline|
    template "#{node['jenkins_ubuntu']['home']}/.chef/knife.rb" do
        owner node['jenkins_ubuntu']['user']
        group node['jenkins_ubuntu']['group']
        mode '0644'

        cookbook 'my_pipeline_ubuntu'
        source 'knife.rb.erb'
        variables(
            chef_server_url: node['my_pipeline_ubuntu']['chef_server_url']
            client_node_name: node['my_pipeline_ubuntu']['client_node_name']
        )
    end

    file "#{node['jenkins_ubuntu']['home']}/.chef/#{pipleine['client_node_name']}.pem" do
        owner node['jenkins_ubuntu']['user']
        group node['jenkins_ubuntu']['group']
        mode '0644'

        content jenkins
    end
end
