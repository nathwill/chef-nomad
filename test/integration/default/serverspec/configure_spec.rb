require 'spec_helper'

describe 'nomad::configure' do
  describe file('/etc/nomad-conf.d/agent_00-default.hcl') do
    its(:content) { should match /data_dir/ }
  end

  describe file('/etc/nomad-conf.d/server_00-default.hcl') do
    its(:content) { should match /enabled/ }
  end

  describe file('/etc/nomad-conf.d/client_00-default.hcl') do
    its(:content) { should match /enabled/ }
  end

  describe file('/etc/nomad-conf.d/atlas_00-default.hcl') do
    its(:content) { should match /join/ }
  end

  describe file('/etc/nomad-conf.d/consul_test.hcl') do
    its(:content) { should match /false/ }
  end

  describe file('/etc/nomad-conf.d/vault_test.hcl') do
    its(:content) { should match /false/ }
  end
end
