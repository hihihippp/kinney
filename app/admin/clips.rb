ActiveAdmin.register Kinney::Clip do
  # to work around issue with urls in menu add menu items to
  # config/initializers/active_admin.rb
  menu false

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
      row :interview_place
      row :people do
        clip.people.map{|person| person.full_name}.join('|')
      end
      row :interviewers do
        clip.interviewers.map{|person| person.full_name}.join('|')
      end
      row :quotes
      row :top_pick
      row :featured
      row :created_at
      row :updated_at
      row :slug
      row :media_type
      row :transcript_text
      row :transcript_pdf
      row :video do
        div do
          render :partial => '/kinney/video', :locals => {:clip => clip}
        end
      end
    end
    active_admin_comments
  end

  action_item :only => [:show, :edit] do
    link_to 'Video Analytics', analyze_tracker_admin_kinney_clip_path(kinney_clip.filename)
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
      params.permit kinney_clip: [:filename, :quotes, :title, :top_pick, {:topic_ids => []}, {:person_ids => []},
        :duration, :interview_date, :description, :featured, :interview_place, :slug, :media_type_id,
        {:interviewer_ids => []}, :transcript_text, :transcript_pdf]
    end
    def slugger
      resource.slug = nil
    end
  end

  collection_action :quotes do
    @clips = Kinney::Clip.where('quotes IS NOT NULL')
  end

  member_action :analyze_tracker, :method => :get do
    @clip = Kinney::Clip.find_by_filename(params[:id])
    @kinney_clip = @clip
    # This is all a mess and could definitely be cleaned up!
    @uuids = Kinney::Tracker.where(:video => params[:id]).pluck(:uuid).uniq
    @all_seconds = []
    @uuids.each do |uuid|
      @all_seconds << Kinney::Tracker.where(:video => params[:id], :uuid => uuid).pluck(:seconds).flatten.uniq
    end
    @all_seconds.flatten!
    @all_seconds = @all_seconds.map{|second| second.to_i}

    @highest_value = 0

    # @seconds should be a hash like this {'second' => 1, 'value' => 2}
    # We start off with a hash which is the length of the duration of the clip, and
    # then for every unique occurrence of that second in a tracker we increment the
    # value by 1.
    @temp_seconds = Hash[(0..@clip.duration).map{|num| [num, 0]}]

    @all_seconds.each do |n|
      @temp_seconds[n] += 1 if @temp_seconds[n]
    end
    @seconds = @temp_seconds.map do |k,v|
      if v > @highest_value
        @highest_value = v
      end
      {'second' => k,
        'value' => v}
    end.sort_by{|second| second["second"]}

  end



end
