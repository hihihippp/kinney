ActiveAdmin.register Kinney::Image do
  # to work around issue with urls in menu add menu items to
  # config/initializers/active_admin.rb
  menu false

  form do |f|
    f.inputs do
      f.input :filename
      f.input :top_pick, :label => "Top Pick?"
      f.input :people, :input_html => {:class => 'chzn-select'}
    end

    f.actions
  end

  index do
    column "Thumbnail" do |image|
      # FIXME: Have a better fallback than a placeholder image.
      if defined?(Djatoka)
        link_to(djatoka_square_image_tag(image.filename, :scale => 100), admin_kinney_image_path(image))
      else
        image_tag "http://placehold.it/100x100"
      end
    end
    column "Filename", :sortable => :filename do |image|
      link_to image.filename, admin_kinney_image_path(image)
    end
    column :top_pick
    column "People" do |image|
      if !image.people.blank?
        image.people.map{|person| person.full_name}.join(' and ')
      end
    end
    default_actions
  end

  show do
    attributes_table do
      row :filename
      row :top_pick
      row :people do
        kinney_image.people.map{|person| person.full_name}.join(' and ')
      end
      row :created_at
      row :updated_at
      div do
        kinney_image_admin_show(kinney_image)
      end
    end
    active_admin_comments
  end

  controller do
    helper ::KinneyHelper

    def permitted_params
      params.permit kinney_image: [:filename, :top_pick, {:person_ids => []}]
    end
  end

  csv do
    column :filename
    column :top_pick
    column("People"){|image| image.people.map{|person| person.full_name}.join(' and ') }
  end

end
