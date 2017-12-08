name             'nomad'
maintainer       'Nathan Williams'
maintainer_email 'nath.e.will@gmail.com'
license          'apache2'
description      'installs/configures nomad'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.13.0'

depends 'ark'

supports 'fedora'
supports 'debian', '>= 8.0'
supports 'ubuntu', '>= 12.04'
%w[redhat centos scientific].each do |p|
  supports p, '>= 6.0'
end

gem 'nomad', '~> 0.1'

unless defined?(Ridley::Chef::Cookbook::Metadata)
  source_url 'https://github.com/nathwill/chef-nomad'
  issues_url 'https://github.com/nathwill/chef-nomad/issues'
end
