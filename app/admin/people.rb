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
    
    f.buttons
  end
  
  controller do
    cache_sweeper Kinney::MetaSweeper
  end
  
end
