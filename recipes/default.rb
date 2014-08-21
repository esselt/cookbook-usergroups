#
# Cookbook Name:: usergroups
# Recipe:: default
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

# Define home dir
home = node[:usergroups][:home]

# Create group dir if not exist
directory node[:usergroups][:home] do
  owner 'root'
  group 'root'
  mode 0771
  recursive true
  not_if { ::File.directory?(home) }
end

# Loop through all groups
node[:usergroups][:groups].each do |prename, group|
  
  # Name must be adjusted
  name = "#{node[:usergroups][:prefix]}#{prename}"
  
  # Remove if action is remove
  if group['action'] == 'remove'
    user name do
      action :remove
    end
    
    group name do
      action :remove
    end
    
    directory "#{home}/#{name}" do
      recursive true
      action :delete
    end
  else
    
    # Get all existing members
    users = []
    group['members'].each do |member|
      users << member if node[:etc][:passwd].has_key?(member)
    end
    
    # Create password if non exist
    if group['password'].nil?
      pass = Array.new(10){[*'0'..'9', *'a'..'z', *'A'..'Z'].sample}.join
      node.set[:usergroups][:groups][prename]['password'] = pass
      
      # Send e-mailreport if user does not exist
      bash "email-password-#{name}" do
        code <<-EOF
          echo 'Password report from #{node[:fqdn]}
          
          Usergroup: #{name}
          Password:  #{pass}
          
          Created:   #{::Time.now}' | mail -s 'Usergroups: Password for #{name}' #{node[:usergroups][:reportaddress]}
        EOF
        
        only_if { node.recipe?('postfix') }
      end
    else
      pass = group['password']
    end
    
    # Create group with existing members
    group name do
      gid group['gid']
      members users
    end
    
    # Create the user
    user name do
      uid group['gid']
      gid group['gid']
      password pass
      shell '/bin/bash'
      comment "Members #{users.join(', ')}"
      home "#{home}/#{name}"
      supports :manage_home => true
    end
    
    # Manage home dir
    directory "#{home}/#{name}" do
      owner name
      group name
      mode 0771
    end
  end
end
