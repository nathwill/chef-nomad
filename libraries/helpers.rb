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
            spec.keys.all? { |k| ok.include? k.to_s }
          end
        }
      }
    end

    module_function :hash_to_arg_string, :conf_keys_include_opts
  end

  module Config
    OPTIONS ||= {
      # General Options
      addresses: Nomad::Helpers.conf_keys_include_opts(%w(http rpc serf)),
      advertise: Nomad::Helpers.conf_keys_include_opts(%w(http rpc serf)),
      bind_addr: { kind_of: String },
      datacenter: { kind_of: String },
      data_dir: { kind_of: String },
      disable_anonymous_signature: { kind_of: [TrueClass, FalseClass] },
      disable_update_check: { kind_of: [TrueClass, FalseClass] },
      enable_debug: { kind_of: [TrueClass, FalseClass] },
      enable_syslog: { kind_of: [TrueClass, FalseClass] },
      http_api_response_headers: { kind_of: Hash },
      leave_on_interrupt: { kind_of: [TrueClass, FalseClass] },
      leave_on_terminate: { kind_of: [TrueClass, FalseClass] },
      log_level: { kind_of: String, equal_to: %w(WARN INFO DEBUG) },
      ports: Nomad::Helpers.conf_keys_include_opts(%w(http rpc serf)),
      region: { kind_of: String },
      syslog_facility: { kind_of: String },
      # Sub-configuration
      atlas: { kind_of: Hash },
      client: { kind_of: Hash },
      consul: { kind_of: Hash },
      server: { kind_of: Hash },
      telemetry: { kind_of: Hash },
      tls: { kind_of: Hash },
      vault: { kind_of: Hash }
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

  module ClientConfig
    OPTIONS ||= {
      alloc_dir: { kind_of: String },
      chroot_env: { kind_of: Hash },
      enabled: { kind_of: [TrueClass, FalseClass] },
      max_kill_timeout: {
        kind_of: String,
        callbacks: {
          'is a valid time-string' => lambda do |spec|
            spec.match(/^\d+(s|m|h)/)
          end
        }
      },
      meta: { kind_of: Hash },
      network_interface: { kind_of: String },
      network_speed: { kind_of: Integer },
      cpu_total_compute: { kind_of: Integer },
      node_class: { kind_of: String },
      options: { kind_of: Hash },
      reserved: Nomad::Helpers.conf_keys_include_opts(
        %w(cpu memory disk reserved_ports)
      ),
      servers: { kind_of: Array },
      state_dir: { kind_of: String }
    }.freeze
  end

  module ConsulConfig
    OPTIONS ||= {
      address: { kind_of: String },
      auth: { kind_of: String },
      auto_advertise: { kind_of: [TrueClass, FalseClass] },
      ca_file: { kind_of: String },
      cert_file: { kind_of: String },
      checks_use_advertise: { kind_of: [TrueClass, FalseClass] },
      client_auto_join: { kind_of: [TrueClass, FalseClass] },
      client_service_name: { kind_of: String },
      key_file: { kind_of: String },
      server_service_name: { kind_of: String },
      server_auto_join: { kind_of: [TrueClass, FalseClass] },
      ssl: { kind_of: [TrueClass, FalseClass] },
      token: { kind_of: String },
      verify_ssl: { kind_of: [TrueClass, FalseClass] }
    }.freeze
  end

  module ServerConfig
    OPTIONS ||= {
      bootstrap_expect: {
        kind_of: Integer,
        callbacks: {
          'is a positive integer' => ->(spec) { spec.abs == spec }
        }
      },
      data_dir: { kind_of: String },
      enabled: { kind_of: [TrueClass, FalseClass] },
      enabled_schedulers: { kind_of: Array },
      encrypt: { kind_of: String },
      node_gc_threshold: {
        kind_of: String,
        callbacks: {
          'is a valid time expression' => lambda do |spec|
            spec.match(/^\d+(ns|us|µs|ms|s|m|h)$/)
          end
        }
      },
      job_gc_threshold: {
        kind_of: String,
        callbacks: {
          'is a valid time expression' => lambda do |spec|
            spec.match(/^\d+(ns|us|µs|ms|s|m|h)$/)
          end
        }
      },
      eval_gc_threshold: {
        kind_of: String,
        callbacks: {
          'is a valid time expression' => lambda do |spec|
            spec.match(/^\d+(ns|us|µs|ms|s|m|h)$/)
          end
        }
      },
      num_schedulers: {
        kind_of: Integer,
        callbacks: {
          'is a positive integer' => ->(spec) { spec.abs == spec }
        }
      },
      protocol_version: { kind_of: String },
      rejoin_after_leave: { kind_of: [TrueClass, FalseClass] },
      retry_join: { kind_of: Array },
      retry_interval: { kind_of: String },
      retry_max: { kind_of: Integer },
      start_join: { kind_of: Array }
    }.freeze
  end

  module VaultConfig
    OPTIONS ||= {
      address: { kind_of: String },
      allow_unauthenticated: { kind_of: [TrueClass, FalseClass] },
      enabled: { kind_of: [TrueClass, FalseClass] },
      create_from_role: { kind_of: String },
      task_token_ttl: { kind_of: String },
      ca_file: { kind_of: String },
      ca_path: { kind_of: String },
      cert_file: { kind_of: String },
      key_file: { kind_of: String },
      tls_server_name: { kind_of: String },
      tls_skip_verify: { kind_of: [TrueClass, FalseClass] },
      token: { kind_of: String }
    }.freeze
  end
end
