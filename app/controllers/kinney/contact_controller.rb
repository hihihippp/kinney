module Kinney
  class ContactController < KinneyController

    def create
      @message = ContactMessage.new(params[:contact_message])
      
      if @message.valid?
        MAILER_LOGGER.info(Time.now)
        MAILER_LOGGER.info(@message.to_json)
        AddYourStoryMailer.new_message(@message).deliver
        redirect_to(root_path, :notice => "Message was successfully sent.")
      else
        flash.now.alert = "Please fill all fields."
        render :template => "kinney/pages/add_your_story"
      end
    end

  end
end