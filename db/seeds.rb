%w[audio video].each do |media_type|
  Kinney::MediaType.find_or_create_by(name: media_type)
end