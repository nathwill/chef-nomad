docker_service 'default' do
  action %i(create start)
end

include_recipe 'nomad'

# this is needed because of vagrant secondary interface
nomad_config 'demo' do
  advertise http: '192.168.120.201',
            rpc: '192.168.120.201',
            serf: '192.168.120.201'
  notifies :restart, 'service[nomad]', :delayed
end

nomad_server_config 'demo' do
  enabled false
  notifies :restart, 'service[nomad]', :delayed
end

nomad_client_config 'demo' do
  node_class 'vagrant'
  servers ['192.168.120.101'] # if this were prod, this'd be a chef-search-populated list of servers
  notifies :restart, 'service[nomad]', :delayed
end
