name             'usergroups'
maintainer       'Boye Holden'
maintainer_email 'boye.holden@hist.no'
license          'Apache 2.0'
description      'Creates users with matching groups for student collaboration'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

recipe 'usergroups::default', 'Creates users and groups (w/ members)'

%w(ubuntu debian).each do |os|
  supports os
end

suggests 'postfix'
