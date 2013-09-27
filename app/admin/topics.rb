ActiveAdmin.register Kinney::Topic do
  form do |f|
    f.inputs :name, :description

    f.actions
  end

  controller do

    def permitted_params
      params.permit topic: [:name, :description]
    end
  end

end
