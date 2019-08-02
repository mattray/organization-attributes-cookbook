# organization-attributes

Managing organization-wide settings can be problematic in organizations where you have large numbers of policyfiles or environments and want to update an attribute across all nodes. If you want to update something simple like the server providing NTP access you might be required to recompile all of your policyfiles for example. The purpose of this cookbook is to provide organization-wide attributes that may be updated in a data bag without requiring rebuilding policyfiles. A service discovery tool like Consul or etcd would work as well, but the Chef Server already has data bags available for its nodes.

Nodes will have access to a local `organization` data bag that adds overridden global attributes without updating their policies.

## organizations data bag

A global `organizations` data bag may be used with a data bag item to manage each organization. An example [data_center1.json](test/data_bags/organizations/data_center1.json) data bag item is provided as an example. The format is essentially:
```
{
  "id": "data_center1",
  "attributes": {
    "ntp": {
      "servers": [
        "0.au.pool.ntp.org",
        "1.au.pool.ntp.org"
      ]
    },
    "audit": {
      "profiles": {
        "uptime": {
          "url": "https://github.com/mattray/uptime-profile"
        }
      }
    }
  },
  "profiles": {
    "linux-patch-baseline": {
      "version": "0.5.0"
    },
    "uptime": {
      "version": "0.2.0"
    }
  },
  "nodes": {
    "node-centos-7": {
      "attributes": {
        "ntp": {
          "servers": [
            "0.sg.pool.ntp.org",
            "1.sg.pool.ntp.org"
          ]
        }
      }
    }
  }
}
```

# recipes

## chef-server

This recipe accesses the `organizations` data bag and creates a local `organization` data bag within the organization it serves. The Chef server will need to set the node['organization'] attribute or reimplement this recipe of multiple organizations are to be served.

## attributes

The `attributes` recipe is applied by nodes so they may access the `organization` data bag and have those attributes applied directly to them.

## profiles

The `profiles` recipe is used by nodes using the `audit` or [audit-artifactory](https://github.com/mattray/audit-artifactory-cookbook) cookbooks so they may provide organization-wide profile versions without requiring the versions to be set with every policy that utilizes those compliance profiles.

# Custom Resources

## organizations_databag

This resource reads the `organizations` data bag and copies the data bag item specified by the `organization` property into the local `organization` data bag. You may override the `organizations` and `local_organizations` properties if you wish, they default to `organizations` and `organization` respectively.

## organizations_attributes

This custom resource reads the local `organization` data bag and copies the `attributes` data bag items into override attributes on the node. You may override the `id` of the data bag item (default is `attributes`) and change the `environment` within the data bag if you have nested environments within the data bag item (the default is not to use them).

## organizations_profiles

This custom resource reads the local `organization` data bag `profiles` data bag item and compares it with the profiles assigned to the node['audit']['profiles']. If there are matching profiles, organization-wide settings for the profiles may be assigned to the node itself (ie. 'url' or 'version'). You may override the `id` of the data bag item (default is `attributes`) and change the `environment` within the data bag if you have nested environments within the data bag item (the default is not to use them).

# License and Authors

- Author: Matt Ray [matt@chef.io](mailto:matt@chef.io)
- Copyright 2019-present, Chef Software, Inc

```text
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
