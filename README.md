# my_pipeline_ubuntu

(This cookbook is still in development)

This cookbook will create a chef delivery pipeline with Jenkins
on Ubuntu 16.04.

### Dependencies

This cookbook needs the cookbook 'jenkins_ubuntu', which is located at 'https://github.com/daytonpa/jenkins_ubuntu/tree/master' in order to work.  For more information regarding the Jenkins installation, please visit the repo's README.md for more information.

Please refer to the metadata.rb for more chef-managed cookbook dependencies.

### Using This Cookbook  :thumbsup:

The default.rb recipe acts as a run_list for setting up the delivery pipeline.  
You can add additional plugins in the attributes/default.rb file under the node attribute ```default['my_pipeline_ubuntu']['extra_plugins']```.  I recommend you leave the default plugins alone, because they are currently set to the **necessary plugins** for this pipeline to function properly.

You will want to add your cookbooks to the pipeline under the node attribute ```default['my_pipeline_ubuntu']['git']['cookbooks']```, the branch under the node attribute.  This cookbook will automatically build a Jenkins job configuration file for each cookbook in this list.  The github branch is located in the attribute ```default['my_pipeline_ubuntu']['git']['branch']```, and your base github account location under ```default['my_pipeline_ubuntu']['git']['url']```.  

### TODO List:
[ ] Write a script in Java that will automatically grab the hidden start-up password and grant your user permissions to the Jenkins CLI.
[ ] Update tests for pipeline.

### Credits
Patrick Hugh Dayton
