name 'nomad'
maintainer 'Nathan Williams'
maintainer_email 'nath.e.will@gmail.com'
license 'apache2'
description 'Installs/Configures nomad'
long_description 'Installs/Configures nomad'
version '0.1.0'

depends 'ark'
depends 'systemd'

supports 'ubuntu', '>= 12.04'
%w( redhat centos scientific ).each do |p|
  supports p, '>= 7.0'
end

unless defined?(Ridley::Chef::Cookbook::Metadata)
  source_url 'https://github.com/nathwill/chef-nomad'
  issues_url 'https://github.com/nathwill/chef-nomad/issues'
end
