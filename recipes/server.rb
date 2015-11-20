node.default['nomad']['client_enabled'] = false
node.default['nomad']['server_enabled'] = true
node.default['nomad']['config']['server']=true

%w( install configure manage ).each do |r|
  include_recipe "#{cookbook_name}::#{r}"
end