name 'client-attributes'

default_source :supermarket

cookbook 'organization-attributes', path: '../..'

run_list 'organization-attributes::attributes'

default['ntp']['foo'] = 'bar'
default['audit']['profiles'] = 'windows-2016'
