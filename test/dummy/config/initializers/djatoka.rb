if Djatoka.respond_to? :resolver
  if Rails.env=='development'
    Djatoka.resolver="http://scrc.lib.ncsu.edu/adore-djatoka/resolver"#"http://localhost/adore-djatoka/resolver"
  else
    Djatoka.resolver="http://scrc.lib.ncsu.edu/adore-djatoka/resolver"
  end
end
