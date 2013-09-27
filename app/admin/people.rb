ActiveAdmin.register Kinney::Person do
  index do
    column :first_name
    column :last_name
    default_actions
  end

  form do |f|
    f.inputs :first_name, :middle_name, :last_name, :name_suffix, :nickname, :graduating_class, :location
    f.inputs do
      f.input :biography, :as => :ckeditor
      f.input :accomplishments, :as => :ckeditor
      f.input :activities, :as => :ckeditor
      f.input :currently, :as => :ckeditor
      f.input :citations, :as => :ckeditor
      f.input :term, :as => :ckeditor
      f.input :term_date_ranges, :as => :ckeditor
    end

    f.actions
  end

  controller do
    def permitted_params
      params.permit person: [:accomplishments, :activities, :biography, :citations,
      :currently, :first_name, :graduating_class, :last_name, :middle_name,
      :nickname, :term, :term_date_ranges, :name_suffix, :location]
    end
    # to make this work with friendly_id
    def resource
      if FriendlyId === self.class.resource_class
        get_resource_ivar || set_resource_ivar(end_of_association_chain.friendly.find(params[:id]))
      else
        super
      end
    end
  end

end
