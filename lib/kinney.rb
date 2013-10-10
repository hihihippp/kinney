require 'strip_attributes'
require "kinney/engine"
require 'activeadmin'
require 'friendly_id'
require 'active_admin_editor'
require 'chosen-rails'
require 'tire'
require 'jquery-tablesorter'
require 'html_truncator'
require 'httpclient'
require 'kinney/mailer_logger'



module Kinney
  module Concerns
    module Models

    end
  end
end

Dir[File.dirname(__FILE__) + "/concerns/models/*.rb"].each {|file| require file }