require 'spec_helper'

describe 'nomad::default' do
  describe service('nomad') do
    # ServerSpec has trouble with Upstart on EL6
    unless os[:family] == 'redhat' && os[:release].match(/^6\.\d/)
      it { should be_enabled }
    end
    it { should be_running }
  end
end
