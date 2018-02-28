#
# Cookbook Name:: nomad
# Library:: NomadCookbook::Helpers
#
# Copyright 2015-2018, Nathan Williams <nath.e.will@gmail.com>
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

module NomadCookbook
  module Helpers
    CONFIG_ROOT ||= '/etc/nomad.conf.d'.freeze
    JOB_ROOT ||= '/etc/nomad.jobs.d'.freeze

    module_function

    def conf_keys_include_opts(ok = %w())
      {
        kind_of: Hash,
        callbacks: {
          'contains only required keys' => lambda do |spec|
            spec.keys.all? { |k| ok.include? k.to_s }
          end,
        },
      }
    end

    def property_hash(res, options = {})
      result = {}

      conf = options.reject do |opt, _|
        res.send(opt).nil?
      end

      conf.each_pair do |opt, _val|
        result[opt] = res.send(opt)
      end

      result
    end

    def systemd?
      File.exist?('/proc/1/comm') && IO.read('/proc/1/comm').chomp == 'systemd'
    end

    def upstart?
      File.executable?('/sbin/initctl')
    end
  end
end

class Hash
  def to_args
    map { |arg, val| val.nil? ? "-#{arg}" : "-#{arg}=#{val}" }
      .sort
      .join(' ')
  end
end
