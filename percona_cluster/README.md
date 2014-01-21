percona_cluster Cookbook
=======================
This cookbook installs percona repository and install percona server on RHEL based servers.

Requirements
------------
Depends on openssl opscode cookbook.
Supports OS:
RHEL 6.x
CentOS 6.x
Amazon Linux

Attributes
----------
TODO: List you cookbook attributes here.

e.g.
#### percona_cluster::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['percona_cluster']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Usage
-----
#### percona_cluster::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `percona_cluster` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[percona_cluster]"
  ]
}
```

Contributing
------------
TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: TODO: List authors
