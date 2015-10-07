
# Nice lightweight daemon for testing
nomad_job 'redis' do
  source 'redis.hcl.erb'
  notifies :run, 'nomad_job[redis]', :delayed
end

package 'curl'

ruby_block 'let-nomad-service-settle' do
  block do
    sleep 5
  end
end
