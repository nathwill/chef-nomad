#
# Cookbook Name:: nomad
# Attributes:: install
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

default['nomad'].tap do |nomad|
  nomad['source_url'] = 'https://dl.bintray.com/mitchellh/nomad'
  nomad['package'], nomad['checksum'] =
    case node['os']
    when 'mac_os_x'
      %w(
        nomad_0.1.1_darwin_amd64.zip
        2a287a553c167d9a61caed5ba238ac0d953ffb6893aa9ef000c3cf51067a614a
      )
    when 'windows'
      %w(
        nomad_0.1.1_windows_amd64.zip
        aaa03d5ecdd511ba12f2cc2c1ba36a427599c35c903d21ced9b8352d584d0730
      )
    else
      %w(
        nomad_0.1.1_linux_amd64.zip
        01d2843616df5ddbff6f7e59703518c00198b17938cefdb3962357dc725b0856
      )
    end
end
