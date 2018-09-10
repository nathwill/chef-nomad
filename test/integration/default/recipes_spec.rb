control 'install' do
  describe file('/usr/local/sbin/nomad') do
    its('link_path') { should match %r{/usr/local/nomad} }
  end

  describe command('/usr/local/sbin/nomad version') do
    its('stdout') { should match(/Nomad/) }
  end
end

control 'configure' do
  describe file('/etc/nomad.env') do
    its('content') { should match /FOO=foo/ }
    its('content') { should match /BAR=bar/ }
  end

  describe file('/etc/nomad.conf.d/00-default.client.json') do
    its('content') { should match /{\n  \"client\": {\n    \"enabled\": true\n  }\n}/ }
  end

  describe file('/etc/nomad.conf.d/00-default.server.json') do
    its('content') { should match /{\n  \"server\": {\n    \"enabled\": false\n  }\n}/ }
  end

  describe file('/etc/nomad.conf.d/00-default.json') do
    its('content') { should match %r{{\n  \"bind_addr\": \"0.0.0.0\",\n  \"data_dir\": \"/var/lib/nomad\"\n}} }
  end
end

control 'manage' do
  describe service('nomad') do
    it { should be_enabled }
    it { should be_running }
  end
end
