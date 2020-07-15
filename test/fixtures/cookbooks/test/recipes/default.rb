#
# Prepare node
#
apt_update if platform_family?('debian')

docker_service 'default' do
  action %i(create start)
end

#
# Set up nomad
#
node.run_state['nomad_environment'] = data_bag_item('nomad', 'environment').to_hash

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

# pre-download to avoid race with port check
docker_image 'google/cadvisor'

# runs at the end of the converge, as
# nomad loses jobs after the restart.

# Allow agent settling before running job
settle = ruby_block 'ready' do
  block { wait_for_nomad_port }
end

# wait for cadvisor to start pre-spec
wait = ruby_block 'settle' do
  block { sleep 5 }
  action :nothing
end

# test the job resource
nomad_job 'cadvisor' do
  source 'cadvisor.hcl.erb'
  notifies :run, settle.to_s, :delayed
  notifies :run, to_s, :delayed
  notifies :run, wait.to_s, :delayed
end

package 'curl'
