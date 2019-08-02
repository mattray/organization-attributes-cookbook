resource_name :organization_profiles

property :organization, String, name_property: true
property :id, String, default: 'profiles'
property :environment, String

action :create do
  org = new_resource.organization
  id = new_resource.id
  environment = new_resource.environment

  # get the organization profiles item
  profiles = data_bag_item(org, id)
  profiles = profiles[environment] if environment

  # iterate over the node's attributes in audit profiles
  if node['audit'] && node['audit']['profiles']
    node['audit']['profiles'].keys.each do |node_profile|
      # merge in any matched profiles
      if profiles[node_profile]
        node.override['audit']['profiles'][node_profile].merge!(profiles[node_profile])
      end
    end
  end
end
