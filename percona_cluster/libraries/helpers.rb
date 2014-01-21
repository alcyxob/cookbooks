module Opscode
  module Mysql
    module Helpers
      def install_grants_cmd
        str = '/usr/bin/mysql'
        str << ' -u root '
        node['mysql_root_password'].empty? ? str = 'echo \" Nothing to do\"' : str << " -p#{node['mysql_root_password']} < /etc/mysql_grants.sql"
      end
      def assign_root_password_cmd
        str = '/usr/bin/mysqladmin'
        str << ' -u root password '
        str << node['mysql_root_password']
      end
    end
  end
end
