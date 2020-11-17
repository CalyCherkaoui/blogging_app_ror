class AddSuperadmin < ActiveRecord::Migration[6.0]
  def change
    User.create! do |u|
      u.email     = 'admin@test.com'
      u.password  = 'foobar'
      u.password_confirmation = 'foobar'
      u.name      = 'admin'
      u.superadmin_role = true
      u.user_role = false
    end
  end
end
