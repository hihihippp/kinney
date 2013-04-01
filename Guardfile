# A sample Guardfile
# More info at https://github.com/guard/guard#readme

group :tests do
  guard :test, :all_on_start => false, :all_after_pass => false do
    watch(%r{^lib/(.+)\.rb$})     { |m| "test/#{m[1]}_test.rb" }
    watch(%r{^test/.+_test\.rb$})
    watch('test/test_helper.rb')  { "test" }

    # Rails example
    watch(%r{^app/models/(.+)\.rb$})                   { |m| "test/unit/#{m[1]}_test.rb" }
    watch(%r{^app/controllers/(.+)\.rb$})              { |m| "test/functional/#{m[1]}_test.rb" }
    watch(%r{^app/views/.+\.rb$})                      { "test/integration" }
    watch('app/controllers/application_controller.rb') { ["test/functional", "test/integration"] }

  end
end

group :livereload do
  guard 'livereload' do
    watch(%r{app/views/.+\.(erb|haml|slim)})
    watch(%r{app/admin/.+\.rb})
    watch(%r{app/helpers/.+\.rb})
    watch(%r{public/.+\.(css|js|html)})
    watch(%r{config/locales/.+\.yml})
    # Rails Assets Pipeline
    watch(%r{(app|vendor)/assets/\w+/(.+\.(css|js|html|erb|scss)).*})  #{ |m| "/assets/#{m[2]}" }

    watch(%r{app/controllers/.+\.rb})
  end
end

