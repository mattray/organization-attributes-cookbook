# InSpec test for recipe organization-attributes::attributes

describe directory('/tmp/kitchen/nodes') do
  it { should exist }
end

describe json('/tmp/kitchen/nodes/attributes-centos-7.json') do
  its(['override','ntp', 'servers', 0]) { should eq '0.au.pool.ntp.org' }
  its(['override','ntp', 'servers', 1]) { should eq '1.au.pool.ntp.org' }
  its(['override','ntp', 'servers', 2]) { should eq '2.au.pool.ntp.org' }
  its(['override','ntp', 'servers', 3]) { should eq '3.au.pool.ntp.org' }
  its(['override','audit', 'profiles', 'uptime', 'url']) { should eq 'https://github.com/mattray/uptime-profile' }
end

describe ntp_conf do
  its('server') { should eq [
    '0.au.pool.ntp.org iburst minpoll 6 maxpoll 10',
    '1.au.pool.ntp.org iburst minpoll 6 maxpoll 10',
    '2.au.pool.ntp.org iburst minpoll 6 maxpoll 10',
    '3.au.pool.ntp.org iburst minpoll 6 maxpoll 10'
  ] }
end
