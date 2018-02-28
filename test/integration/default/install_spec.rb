control 'installation' do
  describe file('/usr/local/sbin/nomad') do
    its('link_path') { should match %r{/usr/local/nomad} }
  end

  describe command('/usr/local/sbin/nomad version') do
    its('stdout') { should match(/Nomad/) }
  end
end
