module TinyMCE::Rails
  class Engine < ::Rails::Engine
    config.tinymce = ActiveSupport::OrderedOptions.new

    config.tinymce.base = nil

    initializer "precompile", :group => :all do |app|
      app.config.assets.precompile << "tinymce-rails.js"
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
