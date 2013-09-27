ActiveAdmin.register Kinney::Topic do
  form do |f|
    f.inputs :name, :description

    f.actions
  end

  controller do
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
  end

end
