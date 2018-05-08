name             'nomad'
maintainer       'Nathan Williams'
maintainer_email 'nath.e.will@gmail.com'
license          'Apache-2.0'
description      'installs/configures nomad'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.1.0'
chef_version	'>= 12.7' if respond_to?(:chef_version)

gem	'nomad', '~> 0.1'

depends	'ark'

supports 	'fedora'
supports 	'debian', '>= 8.0'
supports 	'ubuntu', '>= 12.04'
%w(redhat centos scientific).each do |p|
  supports p, '>= 6.0'
end

unless defined?(Ridley::Chef::Cookbook::Metadata)
  source_url 'https://github.com/nathwill/chef-nomad'
  issues_url 'https://github.com/nathwill/chef-nomad/issues'
end
