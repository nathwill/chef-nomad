require 'spec_helper'

describe Nomad::Helpers do
  it '#hash_to_args' do
    expect(
      Nomad::Helpers.hash_to_arg_string({
        'config' => '/etc/nomad-conf.d',
        'dev' => nil
      })
    ).to eq '-config=/etc/nomad-conf.d -dev'
  end
end
