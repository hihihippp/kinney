xml.instruct!
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9", "xmlns:video" => "http://www.google.com/schemas/sitemap-video/1.1" do
  xml.url do
    xml.loc root_url
    xml.priority("0.5")
  end
  @people.each do |person|
    xml.url do
      xml.loc person_url(person)
      xml.changefreq("monthly")
      xml.priority("0.7")
      if person.updated_at.blank?
        xml.lastmod(person.created_at.strftime("%Y-%m-%d"))
      else
        xml.lastmod(person.updated_at.strftime("%Y-%m-%d"))
      end
    end
  end
  @clips.each do |clip|
    xml.url do
      xml.loc clip_url(clip)
      xml.priority("1.0")
      if clip.updated_at.blank?
        xml.lastmod(clip.created_at.strftime("%Y-%m-%d"))
      else
        xml.lastmod(clip.updated_at.strftime("%Y-%m-%d"))
      end
      xml.video :video do |video|
        xml.video :thumbnail_loc, clip.png
        xml.video :title, clip.people_with_title
        xml.video :description, clip.description
        xml.video :content_loc, clip.mp4
        xml.video :duration, clip.duration
        xml.video :publication_date, clip.created_at.to_date
        xml.video :category, "Oral History"
      end
    end
  end
end