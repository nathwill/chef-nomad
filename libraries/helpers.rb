#
# Cookbook Name:: nomad
# Library:: Nomad::Helpers
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

module Nomad
  module Helpers
    CONFIG_ROOT ||= '/etc/nomad-conf.d'.freeze
    JOB_ROOT ||= '/etc/nomad-jobs.d'.freeze

    def hash_to_arg_string(opts = {})
      opts.map do |arg, val|
        val.nil? ? "-#{arg}" : "-#{arg}=#{val}"
      end.sort.join(' ')
    end

    def conf_keys_include_opts(ok = %w())
      {
        kind_of: Hash,
        callbacks: {
          'contains only required keys' => lambda do |spec|
            spec.keys.all? { |k| ok.include? k }
          end
        }
      }
    end

    module_function :hash_to_arg_string, :conf_keys_include_opts
  end

  module Config
    OPTIONS ||= {
      region: { kind_of: String },
      datacenter: { kind_of: String },
      data_dir: { kind_of: String },
      log_level: { kind_of: String, equal_to: %w( WARN INFO DEBUG ) },
      bind_addr: { kind_of: String },
      enable_debug: { kind_of: [TrueClass, FalseClass] },
      ports: Nomad::Helpers.conf_keys_include_opts(%w( http rpc serf )),
      addresses: Nomad::Helpers.conf_keys_include_opts(%w( http rpc serf )),
      advertise: Nomad::Helpers.conf_keys_include_opts(%w( rpc serf )),
      telemetry: Nomad::Helpers.conf_keys_include_opts(
        %w( statsite_address statsd_address disable_hostname )
      ),
      leave_on_interrupt: { kind_of: [TrueClass, FalseClass] },
      leave_on_terminate: { kind_of: [TrueClass, FalseClass] },
      enable_syslog: { kind_of: [TrueClass, FalseClass] },
      syslog_facility: { kind_of: String },
      disable_update_check: { kind_of: [TrueClass, FalseClass] },
      disable_anonymous_signature: { kind_of: [TrueClass, FalseClass] },
      http_api_response_headers: { kind_of: Hash }
    }.freeze
  end

  module ServerConfig
    OPTIONS ||= {
      enabled: { kind_of: [TrueClass, FalseClass] },
      bootstrap_expect: {
        kind_of: Integer,
        callbacks: {
          'is a positive integer' => ->(spec) { spec.abs == spec }
        }
      },
      data_dir: { kind_of: String },
      protocol_version: { kind_of: String },
      num_schedulers: {
        kind_of: Integer,
        callbacks: {
          'is a positive integer' => ->(spec) { spec.abs == spec }
        }
      },
      enabled_schedulers: { kind_of: Array },
      node_gc_threshold: {
        kind_of: String,
        callbacks: {
          'is a valid time expression' => lambda do |spec|
            spec.match(/^\d+(ns|us|µs|ms|s|m|h)$/)
          end
        }
      },
      rejoin_after_leave: { kind_of: [TrueClass, FalseClass] },
      retry_join: { kind_of: Array },
      retry_interval: { kind_of: String },
      start_join: { kind_of: Array }
    }.freeze
  end

  module ClientConfig
    OPTIONS ||= {
      enabled: { kind_of: [TrueClass, FalseClass] },
      state_dir: { kind_of: String },
      alloc_dir: { kind_of: String },
      servers: { kind_of: Array },
      node_id: { kind_of: String },
      node_class: { kind_of: String },
      meta: { kind_of: Hash },
      options: { kind_of: Hash },
      network_interface: { kind_of: String },
      network_speed: { kind_of: Integer },
      max_kill_timeout: {
        kind_of: String,
        callbacks: {
          'is a valid time-string' => lambda do |spec|
            spec.match(/^\d+(s|m|h)/)
          end
        }
      }
    }.freeze
  end

  module AtlasConfig
    OPTIONS ||= {
      infrastructure: { kind_of: String },
      token: { kind_of: String },
      join: { kind_of: [TrueClass, FalseClass] },
      endpoint: { kind_of: String }
    }.freeze
  end
end
