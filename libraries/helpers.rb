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
    CONFIG_ROOT ||= '/etc/nomad-conf.d'.freeze
    JOB_ROOT ||= '/etc/nomad-jobs.d'.freeze

    def hash_to_arg_string(opts = {})
      opts.map do |arg, val|
        val.nil? ? "-#{arg}" : "-#{arg}=#{val}"
      end.sort.join(' ')
    end

    def conf_keys_include_opts(ok = %w[])
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
end
