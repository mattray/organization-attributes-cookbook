name 'chef-server'

default_source :supermarket

cookbook 'organization-attributes', path: '../..'

run_list 'organization-attributes::chef-server'

default['organization'] = 'data_center1'
