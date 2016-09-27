node['jenkins_ubuntu'].tap do |jenkins|

    my_berkshelf = jenkins['home'] + '/.berkshelf'

    # Create the local Berkshelf directory
    directory my_berkshelf do
        owner jenkins['user']
        group jenkins['group']
        mode '0755'
    end

    # Pull the custom berksfile from GitHub
    git 'install_Berksfile_from_GitHub' do
        user jenkins['user']
        group jenkins['group']

        destination my_berkshelf
        repository 'https://github.com/daytonpa/pipeline_berksfile.git'

        action :sync
        retries 5
    end

    # Create config files
    file "#{my_berkshelf}/config.json" do
        owner jenkins['user']
        owner jenkins['group']
        content '{"ssl":{"verify"}: false }}'
    end
    file "#{jenkins['home']}/.gitconfig" do
        owner jenkins['user']
        group jenkins['group']
        content <<-EOD
        [http]
            sslVerify = false
        EOD
    end
end
