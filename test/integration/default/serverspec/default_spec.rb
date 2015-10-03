require 'spec_helper'

describe 'nomad::default' do
  describe service('nomad') do
    it { should be_enabled }
    it { should be_running }
  end
end
