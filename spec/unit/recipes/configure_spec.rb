#
# Cookbook Name:: nomad
# Spec:: configure
#
# Copyright 2015 The Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'spec_helper'

describe 'nomad::configure' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'configures nomad' do
      expect(chef_run).to create_nomad_config('00-default').with(
        data_dir: '/var/lib/nomad'
      )

      expect(chef_run).to create_nomad_server_config('00-default').with(
        enabled: false
      )

      expect(chef_run).to create_nomad_client_config('00-default').with(
        enabled: true
      )
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
