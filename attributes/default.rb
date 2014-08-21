#
# Cookbook Name:: usergroups
# Attribute:: default
#
# Copyright 2013, HiST AITeL
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Prefix that is added to user and group names. Default: grp_
default[:usergroups][:prefix]         = 'grp_'

# Where the home folders for the user should be stored. Default: /home/groups
default[:usergroups][:home]           = '/home/groups'

# Default e-mail address to send password reports to
default[:usergroups][:reportaddress]  = 'root'

# Empty holder for groups, to hinder crash
default[:usergroups][:groups]         = []
