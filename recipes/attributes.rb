#
# Cookbook:: organization-attributes
# Recipe:: client-attributes
#

attributes = data_bag_item('organization', 'attributes')

attributes.delete('id')
node.override_attrs.merge!(attributes)
