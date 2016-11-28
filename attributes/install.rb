#
# Cookbook Name:: nomad
# Attributes:: install
#
# Copyright 2015-2016, Nathan Williams <nath.e.will@gmail.com>
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

default['nomad'].tap do |nomad|
  nomad['source_url'] = 'https://releases.hashicorp.com/nomad'
  nomad['package'], nomad['checksum'] =
    case node['os']
    when 'mac_os_x'
      %w(
        0.5.0/nomad_0.5.0_darwin_amd64.zip
        a063a1d1af7012da32dfe11ca8b02324e83e242ff8e8bd27dc00553f1b1a0499
      )
    when 'windows'
      %w(
        0.5.0/nomad_0.5.0_windows_amd64.zip
        92d8c84b4cacfdfbe73b902ea3527eb3104d642e851e1776022f9e09e965f03a
      )
    else
      %w(
        0.5.0/nomad_0.5.0_linux_amd64.zip
        7f7b9af2b1ff3e2c6b837b6e95968415237bb304e1e82802bc42abf6f8645a43
      )
    end
end
