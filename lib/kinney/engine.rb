module Kinney
  class Engine < ::Rails::Engine
    isolate_namespace Kinney
    # initializer 'kinney.action_controller' do |app|
    #   ActiveSupport.on_load :action_controller do
    #     helper KinneyHelper
    #   end
    # end
    initializer "kinney.asset_pipeline" do |app|
      app.config.assets.precompile << 'kinney.js'
    end
    config.to_prepare do
      ApplicationController.helper(GeneralHelper)
      Dir.glob(Rails.root + "app/decorators/**/*_decorator*.rb").each do |c|
        require_dependency(c)
      end
    end
  end
end
