source 'https://supermarket.chef.io'

metadata

%w( jenkins_ubuntu rr_install deploy_flix ).each do |my_books|
    cookbook my_books, git: "git://github.com/daytonpa/#{my_books}.git"
end
