module Kinney
  class TrackerController < KinneyController

    def track
      if request.xhr?
        data = params.dup
        data["session"] = session[:session_id]
        data.delete(:action)
        data.delete(:controller)
        tracker = Tracker.new data.permit(params_permitted)
        tracker.save
        head :ok
      end
    end

    private

    def permitted_params
      params.permit tracker: params_permitted
    end

    def params_permitted
      [:seconds, :session, :sessioned, :site, :time, :uuid, :video]
    end

  end
end