ActiveAdmin.register Kinney::Topic do
  form do |f|
    f.inputs :name, :description

    f.actions
  end

  controller do
    cache_sweeper Kinney::MetaSweeper
    def permitted_params
      params.permit topic: [:name, :description]
    end
  end

end
