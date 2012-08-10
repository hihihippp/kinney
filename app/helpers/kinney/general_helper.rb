module Kinney
  module GeneralHelper
    def controller?(*controller)
      controller.include?(params[:controller])
    end

    def action?(*action)
      action.include?(params[:action])
    end

    def title
      title_s = ''
      title_s << "#{@title} - " if @title
      title_s << "Student Leadership Initiative"
    end

    def meta_description
      if @meta_description
        %Q{<meta name="description" content="#{@meta_description}">}.html_safe
      end
    end
  end  
end