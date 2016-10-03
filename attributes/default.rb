# chef_dk setup
default['chef_dk'].tap do |cdk|

    ### ChefDK options ###
    cdk['version'] = 'latest'

end

default['my_pipeline_ubuntu'].tap do |pipeline|

    ### Pipeline options ###
    pipeline['chef_server_url'] = 'http://0.0.0.0:80'
    pipeline['client_node_name'] = 'my_pipeline_ubuntu'
    pipeline['chef-client_cmd'] = '/usr/bin/chef-client'

    ### Glorious plugins ###

    # Plugin directory
    pipeline['plugin_home'] = "#{node['jenkins_ubuntu']['home']}/plugins/"
    # Default plugins
    pipeline['default_plugins'] = %w( chef-identity git github github-api git-client scm-api )
    # Extra plugins
    pipeline['extra_plugins'] = %w(  role-strategy chucknorris )

    ### GitHub options ###

    # GitHub account address
    pipeline['git']['url'] = 'https://github.com/daytonpa'
    # GitHub branch
    pipeline['git']['branch'] = 'master'
    # Polling
    pipeline['git']['polling'] = '* * * * *'
    # The cookbook repositories Jenkins is listening
    pipeline['git']['cookbooks'] = %w( deploy_flix rr_install )
end
