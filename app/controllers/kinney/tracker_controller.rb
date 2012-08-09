module Kinney
class TrackerController < KinneyController
  before_filter :authenticate_admin_user!, :only => :analyze

  def track
    if request.xhr?
      data = params.dup
      data["session"] = session[:session_id]
      data.delete(:action)
      data.delete(:controller)      
      tracker = Tracker.new data
      tracker.save
      head :ok
    end
  end

  def analyze
    @clip = Clip.where(:filename => params[:video]).first
    # This is all a mess and could definitely be cleaned up!
    @uuids = Tracker.where(:video => params[:video]).pluck(:uuid).uniq    
    @all_seconds = []
    @uuids.each do |uuid|
      @all_seconds << Tracker.where(:video => params[:video], :uuid => uuid).pluck(:seconds).flatten.uniq      
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
      @temp_seconds[n] += 1
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
end