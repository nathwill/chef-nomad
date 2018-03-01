
nomad_job 'example' do
  source 'example.hcl.erb'
  notifies :run, to_s, :delayed
end
