
# Nice lightweight daemon for testing
nomad_job 'cadvisor' do
  source 'cadvisor.hcl.erb'
  notifies :run, 'nomad_job[cadvisor]', :delayed
end

package 'curl'

ruby_block 'let-nomad-service-settle' do
  block do
    sleep 10
  end
end
