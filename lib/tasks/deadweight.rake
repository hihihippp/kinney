begin
  require 'deadweight'
  Deadweight::RakeTask.new do |dw|
    dw.stylesheets = ["/assets/application.css"]
    dw.pages = ["/kinney", "/kinney/videos", "/kinney/videos/pullen-fire", "/kinney/people", "/kinney/people/edward-norris-tolson", "/kinney/about"]
  end
rescue LoadError
end