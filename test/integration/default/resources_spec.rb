control 'acl' do
  describe file('/etc/nomad.conf.d/10-test.acl.json') do
    its('content') { should match %r{{"acl":{"enabled":false,"token_ttl":"30s"}}} }
  end
end

control 'client' do
  describe file('/etc/nomad.conf.d/10-test.client.json') do
    its('content') { should match %r{{"client":{"max_kill_timeout":"30s","node_class":"test"}}} }
  end
end

control 'config' do
  describe file('/etc/nomad.conf.d/10-test.json') do
    its('content') { should match %r{{"datacenter":"vagrant","name":"10-test","ports":{"http":4646,"rpc":4647,"serf":4648}}} }
  end
end

control 'consul' do
  describe file('/etc/nomad.conf.d/10-test.consul.json') do
    its('content') { should match %r{{"consul":{"address":"127.0.0.1:8500","auto_advertise":false,"client_auto_join":false,"server_auto_join":false,"verify_ssl":false}}} }
  end
end

control 'server' do
  describe file('/etc/nomad.conf.d/10-test.server.json') do
    its('content') { should match %r{{"server":{"node_gc_threshold":"1h","job_gc_threshold":"1h"}}} }
  end
end

control 'telemetry' do
  describe file('/etc/nomad.conf.d/10-test.telemetry.json') do
    its('content') { should match %r{{"telemetry":{"use_node_name":true}}} }
  end
end

control 'tls' do
  describe file('/etc/nomad.conf.d/10-test.tls.json') do
    its('content') { should match %r{{"tls":{"verify_server_hostname":true}}} }
  end
end

control 'vault' do
  describe file('/etc/nomad.conf.d/10-test.vault.json') do
    its('content') { should match %r{{"vault":{"enabled":false}}} }
  end
end

control 'job' do
  describe file('/etc/nomad.jobs.d/cadvisor.hcl') do
    its('content') { should match(/cadvisor/) }
  end

  describe command('/usr/local/sbin/nomad status cadvisor') do
    its('stdout') { should match(/running/) }
  end

  describe command('docker ps') do
    its('stdout') { should match(/cadvisor/) }
  end
end
