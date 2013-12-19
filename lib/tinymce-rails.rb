require 'tinymce/rails'
require "paperclip"
require "jquery-ui-rails"
require "jquery-fileupload-rails"
require "rails-i18n"

module TinyMCE
  extend Rails::Helpers


  @@authentication_method = Proc.new {|method, uploads| uploads }

  @@current_user_method_name = nil

  mattr_accessor :authentication_method, :current_user_method_name


  def self.config
    yield
  end

end