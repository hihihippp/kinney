module Kinney
  class TrackerController < KinneyController

    def track
      require 'pry-rails'
      if request.xhr?
        data = params["tracker"].dup
        data["session"] = session[:session_id]
        tracker = Tracker.new data.permit(params_permitted)
        tracker.save
        head :ok
      end
    end

    private

    # def permitted_params
    #   params.permit tracker: params_permitted
    # end

    def params_permitted
      [{:seconds => [:start, :end]}, :session, :sessioned, :site, :time, :uuid, :video]
    end

  end
end