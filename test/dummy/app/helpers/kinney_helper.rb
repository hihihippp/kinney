module KinneyHelper
  
  
  def kinney_small_image
    djatoka_square_image_tag @top_image.filename, :scale => 150, :itemprop => :image, :alt => @person.full_name
  end

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

  # def png
  #   siskel_path({:extension => 'png'})
  # end
  
  # def mp4
  #   siskel_path({:extension => 'mp4'})
  # end
  
  # def webm
  #   siskel_path({:extension => 'webm'})
  # end
  
  # URL to webvtt file
  # def vtt #closed_captioning vtt file
  #   siskel_path({:extension => 'vtt'})
  # end

  def kinney_image_title(image, person)
    person.full_name
  end

end