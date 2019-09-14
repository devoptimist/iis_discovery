default['iis_discovery']['archive_url'] = ''
default['iis_discovery']['archive_local_path'] = "#{Chef::Config[:file_cache_path]}\\elam-cli.zip"
default['iis_discovery']['extract_dir'] = "#{Chef::Config[:file_cache_path]}\\elam"
default['iis_discovery']['bin_file'] = "#{node['iis_discovery']['extract_dir']}\\elam-cli.exe" 
default['iis_discovery']['out_file'] = "#{node['iis_discovery']['extract_dir']}\\elam_out.json"
default['iis_discovery']['remove_out_file'] = false
