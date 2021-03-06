ActiveAdmin.register Kinney::AdminUser do
  # to work around issue with urls in menu add menu items to
  # config/initializers/active_admin.rb
  menu false

  index do
    column :email
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    default_actions
  end

  filter :email

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  controller do
    def permitted_params
      params.permit kinney_admin_user: [:email, :password, :password_confirmation]
    end
  end

end
