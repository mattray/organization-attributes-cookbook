resource_name :organization_attributes

property :organization, String, name_property: true
property :id, String, default: 'attributes'
property :environment, String

action :create do
  org = new_resource.organization
  id = new_resource.id
  environment = new_resource.environment

  attributes = data_bag_item(org, id)
  attributes.delete('id')

  if environment
    node.override_attrs.merge!(attributes[environment])
  else
    node.override_attrs.merge!(attributes)
  end
end
