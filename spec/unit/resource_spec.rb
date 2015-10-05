require 'spec_helper'

describe Chef::Resource::NomadConfig do
  let(:config) do
    Chef::Resource::NomadConfig.new('agent').tap do |c|
      c.region 'US'
      c.datacenter 'IAD'
      c.enable_syslog true
    end
  end

  let(:json_str) do
    "{\"region\":\"US\",\"datacenter\":\"IAD\",\"enable_syslog\":true}"
  end

  it 'generates proper json' do
    expect(config.to_json).to eq json_str
  end
end

describe Chef::Resource::NomadServerConfig do
  let(:server_config) do
    Chef::Resource::NomadServerConfig.new('server').tap do |c|
      c.enabled true
      c.data_dir '/var/lib/nomad'
    end
  end

  let(:json_str) do
    "{\"server\":{\"enabled\":true,\"data_dir\":\"/var/lib/nomad\"}}"
  end

  it 'generates proper json' do
    expect(server_config.to_json).to eq json_str
  end
end

describe Chef::Resource::NomadClientConfig do
  let(:client_config) do
    Chef::Resource::NomadClientConfig.new('client').tap do |c|
      c.enabled true
      c.node_id 'nomad01.prod'
      c.node_class 'SSD'
    end
  end

  let(:json_str) do
    "{\"client\":{\"enabled\":true,\"node_id\":\"nomad01.prod\",\"node_class\":\"SSD\"}}"
  end

  it 'generates proper json' do
    expect(client_config.to_json).to eq json_str
  end
end

describe Chef::Resource::NomadAtlasConfig do
  let(:atlas_config) do
    Chef::Resource::NomadAtlasConfig.new('atlas').tap do |c|
      c.infrastructure 'org/infra'
      c.token 'A3WCiMO9Ccv9mXdpY9dn9W'
      c.join true
    end
  end

  let(:json_str) do
    "{\"atlas\":{\"infrastructure\":\"org/infra\",\"token\":\"A3WCiMO9Ccv9mXdpY9dn9W\",\"join\":true}}"
  end

  it 'generates proper json' do
    expect(atlas_config.to_json).to eq json_str
  end
end
