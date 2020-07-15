name             'nomad'
maintainer       'Nathan Williams'
maintainer_email 'nath.e.will@gmail.com'
license          'Apache-2.0'
description      'installs/configures nomad'
version          '2.3.0'
chef_version '>= 12.7'

gem 'nomad', '~> 0.1'

depends 'ark'

supports   'fedora'
supports   'debian', '>= 8.0'
supports   'ubuntu', '>= 12.04'
%w(redhat centos scientific).each do |p|
  supports p, '>= 6.0'
end

source_url 'https://github.com/nathwill/chef-nomad'
issues_url 'https://github.com/nathwill/chef-nomad/issues'
