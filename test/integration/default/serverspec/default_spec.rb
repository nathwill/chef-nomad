require 'spec_helper'

describe 'nomad::default' do
  describe command('curl localhost:4646/v1/allocations') do
    its(:stdout) { should match /cadvisor/ }
  end

  describe port(8080) do
    it { should be_listening }
  end
end
