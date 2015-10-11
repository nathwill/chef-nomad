require 'spec_helper'

describe 'nomad::default' do
  describe command('curl localhost:4646/v1/allocations') do
    its(:stdout) { should match /redis/ }
  end

  describe port(6379) do
    it { should be_listening }
  end
end
