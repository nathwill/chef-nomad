control 'install' do
  describe file('/usr/local/sbin/nomad') do
    its('link_path') { should match %r{/usr/local/nomad} }
  end

  describe command('/usr/local/sbin/nomad version') do
    its('stdout') { should match(/Nomad/) }
  end
end

control 'configure' do
  describe file('/etc/nomad.conf.d/00-default.client.json') do
    its('content') { should match /{"client":{"enabled":true}}/ }
  end

  describe file('/etc/nomad.conf.d/00-default.server.json') do
    its('content') { should match /{"server":{"enabled":false}}/ }
  end

  describe file('/etc/nomad.conf.d/00-default.json') do
    its('content') do
      should match %r{{"bind_addr":"0.0.0.0","data_dir":"/var/lib/nomad"}}
    end
  end
end

control 'manage' do
  describe service('nomad') do
    it { should be_enabled }
    it { should be_running }
  end
end
