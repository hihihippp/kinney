ActiveAdmin.register Kinney::Topic do
  form do |f|
    f.inputs :name, :description
        
    f.actions
  end
  
  controller do
    cache_sweeper Kinney::MetaSweeper
  end
  
end
