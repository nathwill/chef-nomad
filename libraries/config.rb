#
# Cookbook Name:: nomad
# Library:: Chef::Resource::NomadConfig
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
#

require 'chef/resource/lwrp_base'
require_relative 'helpers'

class Chef::Resource
  class NomadBase < Chef::Resource::LWRPBase
    self.resource_name = :nomad_base
    provides :nomad_base

    actions :create, :delete
    default_action :create

    def self.option_attributes(options = {})
      options.each_pair { |name, opts| attribute name, opts }
    end
  end
end

class Chef::Resource
  class NomadConfig < Chef::Resource::NomadBase
    self.resource_name = :nomad_config
    provides :nomad_config

    option_attributes Nomad::Config::OPTIONS
    attribute :agent_name, kind_of: String

    def to_json
      config = {}

      config['name'] = agent_name unless agent_name.nil?

      Nomad::Config::OPTIONS.reject { |k, _| send(k).nil? }.each_pair do |k, _|
        config[k] = send(k)
      end

      config.to_json
    end
  end
end

class Chef::Resource
  class NomadServerConfig < Chef::Resource::NomadBase
    self.resource_name = :nomad_server_config
    provides :nomad_server_config

    option_attributes Nomad::ServerConfig::OPTIONS

    def to_json
      config = { 'server' => {} }

      Nomad::ServerConfig::OPTIONS.reject { |k, _| send(k).nil? }.each_pair do |k, _| # rubocop: disable LineLength
        config['server'][k] = send(k)
      end

      config.to_json
    end
  end
end

class Chef::Resource
  class NomadClientConfig < Chef::Resource::NomadBase
    self.resource_name = :nomad_client_config
    provides :nomad_client_config

    option_attributes Nomad::ClientConfig::OPTIONS

    def to_json
      config = { 'client' => {} }

      Nomad::ClientConfig::OPTIONS.reject { |k, _| send(k).nil? }.each_pair do |k, _| # rubocop: disable LineLength
        config['client'][k] = send(k)
      end

      config.to_json
    end
  end
end

class Chef::Resource
  class NomadAtlasConfig < Chef::Resource::NomadBase
    self.resource_name = :nomad_atlas_config
    provides :nomad_atlas_config

    option_attributes Nomad::AtlasConfig::OPTIONS

    def to_json
      config = { 'atlas' => {} }

      Nomad::AtlasConfig::OPTIONS.reject { |k, _| send(k).nil? }.each_pair do |k, _| # rubocop: disable LineLength
        config['atlas'][k] = send(k)
      end

      config.to_json
    end
  end
end

class Chef::Provider
  class NomadConfig < Chef::Provider::LWRPBase
    use_inline_resources

    def whyrun_supported?
      true
    end

    provides :nomad_config
    %w( server client atlas ).each do |sec|
      provides "nomad_#{sec}_config".to_sym
    end 

    %i( create delete ).each do |a|
      action a do
        r = new_resource

        f = file ::File.join(Nomad::Helpers::CONFIG_ROOT, "#{r.name}.hcl") do
          content r.to_json
          action a
        end

        new_resource.updated_by_last_action(f.updated_by_last_action?)
      end
    end
  end
end
