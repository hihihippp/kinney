# A sample Guardfile
# More info at https://github.com/guard/guard#readme

group :tests do
  guard :minitest, :all_on_start => false, :all_after_pass => false do
    watch(%r{^lib/(.+)\.rb$})     { |m| "test/#{m[1]}_test.rb" }
    watch(%r{^test/.+_test\.rb$})
    watch('test/test_helper.rb')  { "test" }

    # Rails example
    watch(%r{^app/models/kinney/(.+)\.rb$})             { |m| "test/models/#{m[1]}_test.rb" }
    watch(%r{^lib/concerns/models/(.+)\.rb$})           { |m| "test/models/#{m[1]}_test.rb" }
    watch(%r{^app/controllers/kinney/(.+)\.rb$})        { |m| "test/controllers/#{m[1]}_test.rb" }
    watch(%r{^app/views/kinney/.+\.erb$})               { "test/integration" }
    watch(%r{^admin/.+\.rb$})                           {"test/integration"}


    callback(:run_on_change_begin) {puts "\n\n=============================================================\n\n"}

  end
end

group :livereload do
  guard 'livereload' do
    watch(%r{app/views/.+\.(erb|haml|slim)})
    watch(%r{app/admin/.+\.rb})
    watch(%r{app/helpers/.+\.rb})
    watch(%r{public/.+\.(css|js|html)})
    watch(%r{app/controllers/.+\.rb})
    # Rails Assets Pipeline
    watch(%r{(app|vendor)/assets/\w+/(.+\.(css|js|html|erb|scss)).*})  #{ |m| "/assets/#{m[2]}" }
  end
end

