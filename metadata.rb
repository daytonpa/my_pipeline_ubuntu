name 'my_pipeline_ubuntu'
maintainer 'The Authors'
maintainer_email 'you@example.com'
license 'all_rights'
description 'Installs/Configures my_pipeline_ubuntu'
long_description 'Installs/Configures my_pipeline_ubuntu'
version '0.1.0'

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Issues` link
# issues_url 'https://github.com/<insert_org_here>/my_pipeline_ubuntu/issues' if respond_to?(:issues_url)

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Source` link
# source_url 'https://github.com/<insert_org_here>/my_pipeline_ubuntu' if respond_to?(:source_url)

##  Chef mainained cookbooks  ##
%w{ sysctl chef-dk emacs sudo chef-zero git jenkins pipeline }.each do |cookbook|
	depends cookbook
end

##  My maintained cookbooks  ##
%w( deploy_flix rr_install ).each do |cookbook|
	depends cookbook
end
