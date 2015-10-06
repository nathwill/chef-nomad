
# Nice lightweight daemon for testing
nomad_job 'redis' do
  source 'redis.hcl.erb'
  notifies :run, 'nomad_job[redis]', :delayed
end

sleep 5 # lets the agent spin up before we try to use it
