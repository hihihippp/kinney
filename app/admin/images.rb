ActiveAdmin.register Kinney::Image do
  form do |f|
    f.inputs do
      f.input :filename
      f.input :top_pick, :label => "Top Pick?"
      f.input :people, :input_html => {:class => 'chzn-select'}
    end
    
    f.buttons
  end

  index do
    column "Filename" do |image|
      link_to image.filename, admin_kinney_image_path(image)
    end
    column :top_pick
    column "People" do |image|
      image.people.map{|person| person.full_name}.join(' and ')
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
    cache_sweeper Kinney::MetaSweeper
    helper ::KinneyHelper
  end
  
end
