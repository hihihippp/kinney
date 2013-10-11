class Kinney::Clip < ActiveRecord::Base
  include Kinney::Concerns::Models::Clip

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

  def webvtt
    filepath = File.join(Rails.root, 'public', vtt)
    file = File.read(filepath)
    Webvtt::File.new(file)
  end

end