control 'acl' do
  describe file('/etc/nomad.conf.d/10-test.acl.json') do
    its('content') { should match /{\n  \"acl\": {\n    \"enabled\": false,\n    \"token_ttl\": \"30s\"\n  }\n}/ }
  end
end

control 'client' do
  describe file('/etc/nomad.conf.d/10-test.client.json') do
    its('content') { should match /{\n  \"client\": {\n    \"max_kill_timeout\": \"30s\",\n    \"node_class\": \"test\"\n  }\n}/ }
  end
end

control 'config' do
  describe file('/etc/nomad.conf.d/10-test.json') do
    its('content') { should match /{\n  \"datacenter\": \"vagrant\",\n  \"ports\": {\n    \"http\": 4646,\n    \"rpc\": 4647,\n    \"serf\": 4648\n  }\n}/ }
  end
end

control 'consul' do
  describe file('/etc/nomad.conf.d/10-test.consul.json') do
    its('content') { should match /{\n  \"consul\": {\n    \"address\": \"127.0.0.1:8500\",\n    \"auto_advertise\": false,\n    \"client_auto_join\": false,\n    \"server_auto_join\": false,\n    \"verify_ssl\": false\n  }\n}/ }
  end
end

control 'server' do
  describe file('/etc/nomad.conf.d/10-test.server.json') do
    its('content') { should match /{\n  \"server\": {\n    \"node_gc_threshold\": \"1h\",\n    \"job_gc_threshold\": \"1h\"\n  }\n}/ }
  end
end

control 'telemetry' do
  describe file('/etc/nomad.conf.d/10-test.telemetry.json') do
    its('content') { should match /{\n  \"telemetry\": {\n    \"use_node_name\": true\n  }\n}/ }
  end
end

control 'tls' do
  describe file('/etc/nomad.conf.d/10-test.tls.json') do
    its('content') { should match /{\n  \"tls\": {\n    \"verify_server_hostname\": true\n  }\n}/ }
  end
end

control 'vault' do
  describe file('/etc/nomad.conf.d/10-test.vault.json') do
    its('content') { should match /{\n  \"vault\": {\n    \"enabled\": false\n  }\n}/ }
  end
end

control 'job' do
  describe file('/etc/nomad.jobs.d/cadvisor.hcl') do
    its('content') { should match(/cadvisor/) }
  end

  describe command('/usr/local/sbin/nomad status monitoring') do
    its('stdout') { should match(/running/) }
  end

  describe command('docker ps') do
    its('stdout') { should match(/cadvisor/) }
  end
end
