# InSpec test for recipe organization-attributes::profiles

describe json('/tmp/kitchen/nodes/profiles-centos-7.json') do
  its(['default','audit', 'profiles', 'linux-patch-baseline', 'url']) { should eq 'https://github.com/dev-sec/linux-patch-baseline' }
  its(['override','audit', 'profiles', 'linux-patch-baseline', 'version']) { should eq '0.5.0' }
end
