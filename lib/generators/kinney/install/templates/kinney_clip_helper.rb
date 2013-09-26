module KinneyClipHelper

  # FIXME: better comment this!
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