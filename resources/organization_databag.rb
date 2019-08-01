resource_name :organization_databag

property :organization, String, name_property: true
property :organizations, String, default: 'organizations'
property :local_organization, String, default: 'organization'

action :create do
  org_name = new_resource.organization
  local_org_name = new_resource.local_organization

  # find the particular organization from the master data bag of all organizations
  orgs_item = data_bag_item(new_resource.organizations, org_name)

  # create the new local organization data bag
  begin
    organization = data_bag(local_org_name)
  rescue Net::HTTPServerException
    organization = Chef::DataBag.new
    organization.name(local_org_name)
    organization.create
    organization.save
  end

  orgs_item.keys.each do |key|
    next if key.eql?('id')
    item = orgs_item[key]
    item['id'] = key
    databag_item = Chef::DataBagItem.new
    databag_item.data_bag(local_org_name)
    databag_item.raw_data = item
    databag_item.save
  end
end
