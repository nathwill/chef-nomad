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

  describe bash('cat /proc/$(systemctl show -p MainPID nomad|cut -d = -f 2)/environ|tr "\0" "\n"') do
    its('stdout') { should match /FOO\s*=\s*OOF/ }
    its('stdout') { should match /BAR\s*=\s*RAB/ }
  end
end
