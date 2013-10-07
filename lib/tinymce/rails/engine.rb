# require 'app/tinymce'

module TinyMCE::Rails
  class Engine < ::Rails::Engine
    isolate_namespace TinyMCE

    config.tinymce = ActiveSupport::OrderedOptions.new

    config.tinymce.base = nil

    initializer "precompile", :group => :all do |app|
      app.config.assets.precompile << "tinymce-rails-plugin.js"
      app.config.assets.precompile << "tinymce-content.css"
    end

    initializer "helpers" do |app|
      ActiveSupport.on_load(:action_view) do
        include FormHelper
      end
    end

    initializer "model" do |app|
      ActiveSupport.on_load(:active_record) do
        include Fields
      end
    end

    def self.base
      config.tinymce.base || default_base
    end

    def self.default_base
      File.join(relative_url_root || "", Rails.application.config.assets.prefix || "/", "tinymce")
    end
    
    def self.relative_url_root
      config = Rails.application.config
      
      if config.respond_to?(:relative_url_root)
        config.relative_url_root
      else
        config.action_controller.relative_url_root
      end
    end

  end
end
