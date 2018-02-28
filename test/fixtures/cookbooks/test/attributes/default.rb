
default['nomad'].tap do |nomad|
  nomad['daemon_args'].tap do |da|
    da['dev'] = nil
    da['network-interface'] = node['network']['default_interface']
  end

  nomad['agent']['name'] = 'nomad-test'
end
