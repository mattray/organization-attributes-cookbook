#
# Cookbook:: organization-attributes
# Recipe:: chef-server
#

# find the organization
org_item = data_bag_item('organizations', node['organization'])

# create the new local organization  data bag from that data bag item
begin
  organization = data_bag('organization')
rescue Net::HTTPServerException
  organization = Chef::DataBag.new
  organization.name('organization')
  organization.create
end

org_item.keys.each do |key|
  next if key.eql?('id')
  item = org_item[key]
  item['id'] = key
  databag_item = Chef::DataBagItem.new
  databag_item.data_bag('organization')
  databag_item.raw_data = item
  databag_item.save
end
