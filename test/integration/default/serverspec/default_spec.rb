require 'spec_helper'

describe 'nomad::default' do
  describe service('nomad') do
    unless os[:family] == 'redhat' && os[:release].match(/^6\.\d/)
      it { should be_enabled }
    end
    it { should be_running }
  end
end
