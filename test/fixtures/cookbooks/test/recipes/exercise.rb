
# Nice lightweight daemon for testing
nomad_job 'redis' do
  source 'redis.hcl.erb'
end
