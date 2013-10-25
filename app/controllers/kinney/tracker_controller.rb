module Kinney
  class TrackerController < KinneyController

    def track
      if request.xhr?
        data = params["tracker"].dup
        data["session"] = session[:session_id]
        tracker = Tracker.new data.permit(params_permitted)
        tracker.save
        head :ok
      end
    end

    private

    def params_permitted
      [{:seconds => [:start, :end]}, :session, :sessioned, :site, :time, :uuid, :video]
    end

  end
end