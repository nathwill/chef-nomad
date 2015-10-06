require 'spec_helper'

describe file('/usr/local/bin/nomad') do
  it { should be_executable }
end

describe command('/usr/local/bin/nomad --version') do
  its(:stdout) { should match /nomad/i }
end
