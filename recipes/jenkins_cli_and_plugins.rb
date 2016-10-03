node['my_pipeline_ubuntu'].tap do |pipeline|

    # Create the plugins directory
    directory "#{pipeline['plugin_home']}" do
        user node['jenkins_ubuntu']['user']
        group node['jenkins_ubuntu']['group']
        mode '0644'
        recursive true
    end

    sudo 'jenkins' do
        user node['jenkins_ubuntu']['user']
        nopasswd true
        commands [node['my_pipeline_ubuntu']['chef-client_cmd']]
    end

    # Download and install the default plugins for the pipeline.
    pipeline['default_plugins'].each do |plugin|
        remote_file "#{node['jenkins_ubuntu']['home']}/plugins/#{plugin}" do
            user node['jenkins_ubuntu']['user']
            group node['jenkins_ubuntu']['group']
            mode '0755'

            source "http://updates.jenkins-ci.org/latest/#{plugin}.hpi"

            notifies :restart, 'service[jenkins]', :delayed
        end
    end

    # Install any extra plugins you desire.
    pipeline['extra_plugins'].each do |plugin|
        remote_file "#{node['jenkins_ubuntu']['home']}/plugins/#{plugin}" do
            user node['jenkins_ubuntu']['user']
            group node['jenkins_ubuntu']['group']
            mode '0755'

            source "http://updates.jenkins-ci.org/latest/#{plugin}.hpi"
            ignore_failure true

            notifies :restart, 'service[jenkins]', :delayed
        end
    end

    # Lastly, download the Jenkins CLI
    remote_file "#{node['jenkins_ubuntu']['home']}/plugins/jenkins-cli.jar" do
        user node['jenkins_ubuntu']['user']
        group node['jenkins_ubuntu']['group']
        mode '0755'

        source "http://#{node['jenkins_ubuntu']['listen_address']}:#{node['jenkins_ubuntu']['listen_port']}/jnlpJars/jenkins-cli.jar"
        notifies :restart, 'service[jenkins]', :immediately
    end
end
