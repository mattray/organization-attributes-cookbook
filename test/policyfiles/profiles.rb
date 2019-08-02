name 'profiles'

default_source :supermarket

cookbook 'organization-attributes', path: '../..'

run_list 'organization-attributes::profiles'

default['audit']['profiles']['linux-patch-baseline']['url'] = 'https://github.com/dev-sec/linux-patch-baseline'
