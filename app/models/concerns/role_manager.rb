module RoleManager 
  def self.included(base)
    if Role.table_exists?
      roles = Role.pluck(:name)
      roles.each do |role|
        define_method "#{role.downcase}?" do 
          self.role_name.eql? role 
        end
      end
    end
  end
end