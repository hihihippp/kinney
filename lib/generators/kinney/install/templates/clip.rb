class Kinney::Clip < ActiveRecord::Base
  include Kinney::Concerns::Models::Clip

  # TODO: This is just an example of what you can do. Please update this for how your
  # URLs ought to be determined for your video and other assets.
  def siskel_path(opts={})
    path_filename = opts[:filename] || filename
    url = 'http://siskel.lib.ncsu.edu/SLI'
    name = path_filename.split('-').first
    url = File.join(url, name, path_filename, path_filename)
    if !opts[:extension].blank?
      extension = '.' + opts[:extension] if !opts[:extension].include?('.')
      url + extension
    else
      url
    end
  end
end