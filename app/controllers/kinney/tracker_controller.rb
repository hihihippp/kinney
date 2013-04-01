module Kinney
  class TrackerController < KinneyController

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

  end
end