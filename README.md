Description
============

This cookbook creates a user and a group with the same name and UID/GID.
These usergroups is created to be used for student groups.

Requirements
============

Chef version 11.0+

## Platform

Supported platforms by platform family:

* debian (debian, ubuntu)

Attributes
==========

* `node['usergroups']['prefix']` - Prefix that is added to user and group names. Default: grp_
* `node['usergroups']['home']` - Where the home folders for the user should be stored. Default: /home/groups
* `node['usergroups']['reportaddress']` - Address to send mail for password report. Default: root

Usage
=====

## usergroups::default

The default recipe creates usergroups defined in the attributes file.
If no usergroups are defined, none are created.

Example role

    name 'myclient'
    run_list(
      'recipe[usergroups::default]'
    )
    default_attributes(
      'usergroups' => {
        'reportaddress' => 'email@addre.ss', # Report address if generated passwords
        'groups' => {
          'group1' => {                      # Group and user name, needed
            'gid' => 701,                    # Group ID, needed
            'password' => 'pass1',           # Password to log in as user
            'members' => ['user1', 'user2'], # Additional members of group
            'action' => 'remove'             # Remove if unwanted
          }
        }
      }
    )

License and Authors
===================
Author:: Boye Holden (<boye.holden@hist.no>)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
