class Kinney::Clip < ActiveRecord::Base
  include Kinney::Concerns::Models::Clip

  # TODO: This is just an example of what you can do. Please update this for how your
  # URLs ought to be determined for your video and other assets. In the test application
  # the files are just in the public directory under /media. You may want this to create the full
  # URL for the resources.
  # We use the convention that all files related to a media file are within the same directory so all
  # we need is the different
  def siskel_path(opts={})
    path_filename = opts[:filename] || filename
    path = File.join((Rails.configuration.action_controller.relative_url_root || ''), 'media', path_filename, path_filename)
    if !opts[:extension].blank?
      extension = '.' + opts[:extension] if !opts[:extension].include?('.')
      path + extension
    else
      path
    end
  end

  # In a production application this may be a HTTP request to your server for the file. Since in the test
  # application everything is under public we can just read the file in here.
  def webvtt
    filepath = File.join(Rails.root, 'public', vtt)
    file = File.read(filepath)
    Webvtt::File.new(file)
  end

end