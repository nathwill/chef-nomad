
require 'socket'

module Nomad
  module Helpers
    CONFIG_ROOT ||= '/etc/nomad.d'
  end

  module Config
    OPTIONS ||= {
      region: { kind_of: String },
      datacenter: { kind_of: String },
      data_dir: { kind_of: String },
      log_level: { kind_of: String, equal_to: %w( WARN INFO DEBUG ) },
      bind_addr: { kind_of: String },
      enable_debug: { kind_of: [TrueClass, FalseClass] },
      ports: { kind_of: Hash },
      addresses: { kind_of: Hash },
      advertise: { kind_of: Hash },
      telemetry: { kind_of: Hash },
      leave_on_interrupt: { kind_of: [TrueClass, FalseClass] },
      leave_on_terminate: { kind_of: [TrueClass, FalseClass] },
      enable_syslog: { kind_of: [TrueClass, FalseClass] },
      syslog_facility: { kind_of: String },
      disable_update_check: { kind_of: [TrueClass, FalseClass] },
      disable_anonymous_signature: { kind_of: [TrueClass, FalseClass] },
    }
  end

  module ServerConfig
    OPTIONS ||= {
      enabled: { kind_of: [TrueClass, FalseClass] },
      bootstrap_expect: { kind_of: Integer },
      data_dir: { kind_of: String },
      protocol_version: { kind_of: String },
      num_schedulers: { kind_of: Integer },
      enabled_schedulers: { kind_of: Array },
    }
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
    }
  end

  module AtlasConfig
    OPTIONS ||= {
      infrastructure: { kind_of: String },
      token: { kind_of: String },
      join: { kind_of: [TrueClass, FalseClass] },
      endpoint: { kind_of: String },
    }
  end
end
