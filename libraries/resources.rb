#
# Cookbook Name:: nomad
# Library:: Chef::Resource::Nomad{Base,Config,ClientConfig,ServerConfig,Job}
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
require 'chef/provider/lwrp_base'

require_relative 'helpers'

class Chef::Resource
  class NomadBase < Chef::Resource::LWRPBase
    resource_name :nomad_base
    provides :nomad_base

    actions :create, :delete
    default_action :create

    attribute :path, kind_of: String, default: Nomad::Helpers::CONFIG_ROOT

    def self.option_attributes(options = {})
      options.each_pair { |name, opts| attribute name, opts }
    end
  end

  class NomadConfig < Chef::Resource::NomadBase
    resource_name :nomad_config
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

  class NomadServerConfig < Chef::Resource::NomadBase
    resource_name :nomad_server_config
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

  class NomadClientConfig < Chef::Resource::NomadBase
    resource_name :nomad_client_config
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

  class NomadAtlasConfig < Chef::Resource::NomadBase
    resource_name :nomad_atlas_config
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

  class NomadJob < Chef::Resource::LWRPBase
    resource_name :nomad_job
    provides :nomad_job

    actions :create, :delete, :run, :stop
    default_action :create

    attribute :cookbook, kind_of: String
    attribute :path, kind_of: String, default: Nomad::Helpers::JOB_ROOT
    attribute :source, kind_of: String, required: true
    attribute :variables, kind_of: Hash
  end
end

class Chef::Provider
  class NomadBase < Chef::Provider::LWRPBase
    use_inline_resources

    def whyrun_supported?
      true
    end

    %w( base config ).each do |s|
      provides "nomad_#{s}".to_sym
    end

    %w( client server atlas ).each do |s|
      provides "nomad_#{s}_config".to_sym
    end

    %i( create delete ).each do |a|
      action a do
        r = new_resource

        directory r.path do
          not_if { r.action == :delete }
        end

        f = file ::File.join(r.path, "#{r.name}.hcl") do
          content r.to_json
          action a
        end

        new_resource.updated_by_last_action(f.updated_by_last_action?)
      end
    end
  end

  class NomadJob < Chef::Provider::LWRPBase
    use_inline_resources

    def whyrun_supported?
      true
    end

    provides :nomad_job

    %i( create delete ).each do |a|
      action a do
        r = new_resource

        directory r.path do
          not_if { r.action == :delete }
        end

        t = template ::File.join(r.path, "#{r.name}.hcl") do
          cookbook r.cookbook || r.cookbook_name
          source r.source
          variables r.variables if r.variables
          action a
          verify { |path| "nomad validate #{path}" } if Chef::VERSION.to_f >= 12
        end

        new_resource.updated_by_last_action(t.updated_by_last_action?)
      end
    end

    action :run do
      # Pending strategy for idempotency
      fail NotImplementedError
    end

    action :stop do
      # Pending strategy for idempotency
      fail NotImplementedError
    end
  end
end
