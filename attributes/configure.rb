
default['nomad'].tap do |nomad|
  nomad['data_dir'] = '/var/lib/nomad'

  nomad['atlas_join'] = false

  nomad['client_enabled'] = true

  nomad['server_enabled'] = false
  nomad['bootstrap_expect'] = 3
end
