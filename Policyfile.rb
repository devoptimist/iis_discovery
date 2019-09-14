# Policyfile.rb - Describe how you want Chef Infra Client to build your system.
#
# For more information on the Policyfile feature, visit
# https://docs.chef.io/policyfile.html

# A name that describes what the system you're building with Chef does.
name 'iis_discovery'

# Where to find external cookbooks:
default_source :supermarket

run_list 'iis_discovery'
named_run_list :without_iis, 'iis_discovery'
named_run_list :with_iis, 'webapp', 'iis_discovery'

cookbook 'iis_discovery', path: '.'
cookbook 'webapp', path: './test/fixtures/cookbooks/webapp'
