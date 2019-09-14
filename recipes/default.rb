#
# Cookbook:: iis_discovery
# Recipe:: default
#
# Copyright:: 2019, Steve Brown
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

# removing the out file will cause
# iis app data to be collected again
file node['iis_discovery']['out_file'] do
  action :delete
  only_if { node['iis_discovery']['remove_out_file'] }
end

remote_file node['iis_discovery']['archive_local_path'] do
  backup false
  source node['iis_discovery']['archive_url']
end

powershell_script 'extract_elam' do
  code <<-EOH
  $lp = '#{node['iis_discovery']['archive_local_path']}'
  $ed = '#{node['iis_discovery']['extract_dir']}'
  Add-Type -AssemblyName System.IO.Compression.FileSystem
  [System.IO.Compression.ZipFile]::ExtractToDirectory($lp, $ed)
  EOH
  creates node['iis_discovery']['extract_dir']
end

powershell_script 'write_result' do
  code <<-EOH
  $cmd = #{node['iis_discovery']['bin_file']} export-iis --what-if --json
  $out = '#{node['iis_discovery']['out_file']}'
  try {
    [System.IO.File]::WriteAllLines($out, $cmd)
  }
  catch {
    [System.IO.File]::WriteAllLines($out, (Write-OutPut "[]"))
  }
  EOH
  creates node['iis_discovery']['out_file']
end

ruby_block 'elam_get_result' do
  block do
    compat_apps = JSON.parse(::File.read(node['iis_discovery']['out_file']))
    node.default['iis_discovery']['discovered'] = compat_apps unless compat_apps.empty?
  end
end
