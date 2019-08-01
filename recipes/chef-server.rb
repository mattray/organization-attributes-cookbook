#
# Cookbook:: organization-attributes
# Recipe:: chef-server
#

organization_databag node['organization'] do
  organizations 'organizations'
end
