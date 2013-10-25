ActiveAdmin.register Kinney::Topic do
  # to work around issue with urls in menu add menu items to
  # config/initializers/active_admin.rb
  menu false

  form do |f|
    f.inputs :name, :description

    f.actions
  end

  controller do
    before_filter :slugger, only: :update
    def resource
      if FriendlyId === self.class.resource_class
        get_resource_ivar || set_resource_ivar(end_of_association_chain.friendly.find(params[:id]))
      else
        super
      end
    end
    def permitted_params
      params.permit kinney_topic: [:name, :description]
    end
    def slugger
      resource.slug = nil
    end
  end

end
