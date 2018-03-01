wait = ruby_block 'wait' do
  block { sleep 60 }
  action :nothing
end

nomad_job 'database' do
  source 'database.hcl.erb'
  notifies :run, wait.to_s, :delayed # let nomad restart settle
  notifies :run, to_s, :delayed
end
