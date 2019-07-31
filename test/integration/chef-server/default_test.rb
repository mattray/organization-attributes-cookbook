# InSpec test for recipe organization-attributes::chef-server

describe directory('/tmp/kitchen/data_bags') do
  it { should exist }
end

describe directory('/tmp/kitchen/data_bags/organization') do
  it { should exist }
end

describe file('/tmp/kitchen/data_bags/organization/attributes.json') do
  it { should exist }
end

describe file('/tmp/kitchen/data_bags/organization/nodes.json') do
  it { should exist }
end

describe file('/tmp/kitchen/data_bags/organization/profiles.json') do
  it { should exist }
end
