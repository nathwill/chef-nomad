require 'spec_helper'

describe 'nomad::configure' do
  describe file('/etc/nomad-conf.d/00-agent.hcl') do
    its(:content) { should match /data_dir/ }
  end

  describe file('/etc/nomad-conf.d/00-server.hcl') do
    its(:content) { should match /enabled/ }
  end

  describe file('/etc/nomad-conf.d/00-client.hcl') do
    its(:content) { should match /enabled/ }
  end

  describe file('/etc/nomad-conf.d/00-atlas.hcl') do
    its(:content) { should match /join/ }
  end
end
