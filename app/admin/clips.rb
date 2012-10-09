ActiveAdmin.register Kinney::Clip do
  form :partial => "form"
    
  index do
    column :filename, :sortable => :filename do |clip|
      link_to clip.filename, admin_kinney_clip_path(clip)
    end
    column :title
    column :top_pick
    column :featured
    column :duration
    default_actions
  end
  
  show do |clip|
    attributes_table do
      row :filename
      row :duration
      row :title
      row :description
      row :interview_date
      row :quotes
      row :top_pick
      row :featured
      row :created_at
      row :updated_at
      row :slug
      row :video do
        div(:style => 'width:480px;height:272px') do
          render :partial => '/kinney/video', :locals => {:clip => clip}
        end
      end
    end
    active_admin_comments
  end
  
  controller do
    cache_sweeper Kinney::MetaSweeper
  end
  
end
