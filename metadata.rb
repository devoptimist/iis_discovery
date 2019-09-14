name 'iis_discovery'
maintainer 'Steve Brown'
maintainer_email 'sbrown@chef.io'
license 'Apache-2.0'
description 'Installs/Configures an iis application discovery tool'
long_description 'Installs/Configures an iis application discovery tool'
version '0.1.0'
chef_version '>= 13.0'

%w(windows).each do |os|
  supports os
end

#depends 'ohai'

issues_url 'https://github.com/devoptimist/iis_discovery/issues'
source_url 'https://github.com/devoptimist/iis_discovery'
