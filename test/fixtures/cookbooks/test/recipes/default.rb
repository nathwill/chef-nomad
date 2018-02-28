#
# Prepare node
#
execute 'apt-get update' do
  only_if { platform_family?('debian') }
end

docker_service 'default' do
  action %i(create start)
end

#
# Set up nomad
#
include_recipe 'nomad::default'

nomad_acl_config '10-test' do
  enabled false
  token_ttl '30s'
end

nomad_client_config '10-test' do
  max_kill_timeout '30s'
  node_class 'test'
end

nomad_config '10-test' do
  datacenter 'vagrant'
  ports 'http' => 4646, 'rpc' => 4647, 'serf' => 4648
end

nomad_consul_config '10-test' do
  address '127.0.0.1:8500'
  auto_advertise false
  client_auto_join false
  server_auto_join false
  verify_ssl false
end

nomad_server_config '10-test' do
  node_gc_threshold '1h'
  job_gc_threshold '1h'
end

nomad_telemetry_config '10-test' do
  use_node_name true
end

nomad_tls_config '10-test' do
  verify_server_hostname true
end

nomad_vault_config '10-test' do
  enabled false
end

# Allow agent settling before running job
settle = ruby_block 'settle' do
  block { sleep 5 }
  action :nothing
end

wait = ruby_block 'wait' do
  block { sleep 5 }
  action :nothing
end
# pre-download to avoid race with port check
docker_image 'google/cadvisor'

# Nice lightweight daemon for testing
nomad_job 'cadvisor' do
  source 'cadvisor.hcl.erb'
  notifies :run, settle.to_s, :delayed
  notifies :run, to_s, :delayed
  notifies :run, wait.to_s, :delayed
end

package 'curl'
