include_recipe 'nomad'

# this is needed because of vagrant secondary interface
nomad_config 'demo' do
  advertise http: '192.168.120.101',
            rpc: '192.168.120.101',
            serf: '192.168.120.101'
  notifies :restart, 'service[nomad]', :delayed
end

nomad_server_config 'demo' do
  bootstrap_expect 1 # This is dumb, don't do this in production
  enabled true
  # start_join [1.2.3.4, 1.2.3.5, 1.2.3.6] (if this were prod, this'd be a chef-search-populated list of servers)
  notifies :restart, 'service[nomad]', :delayed
end

nomad_client_config 'demo' do
  enabled false
  node_class 'vagrant'
  notifies :restart, 'service[nomad]', :delayed
end
