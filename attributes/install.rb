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
        0.3.0/nomad_0.3.0_darwin_amd64.zip
        dd2d769ccceb532849072c4e088ebd1f338a0e60916cfe4317a2661716803894
      )
    when 'windows'
      %w(
        0.3.0/nomad_0.3.0_windows_amd64.zip
        393494c33b98f8f270d114ab8954d45d2db775fa7bb9541695c27bc37637c1c3
      )
    else
      %w(
        0.3.0/nomad_0.3.0_linux_amd64.zip
        530e5177cecd65d36102953099db19ecdbfa62b3acf20a0c48e20753a597f28e
      )
    end
end
