module TinyMCE::Rails
  class Configuration
    FILENAME = "tinymce.yml"

    def initialize
      @options ||= { default: {theme: TinyMCE.default_theme, skin: TinyMCE.default_skin} }

      load_file File.expand_path("../../../../config/#{FILENAME}", __FILE__)
      load_file Rails.root.join("config", FILENAME)
    end

    def [](key)
      @options[key.to_sym]
    end

    def to_hash
      @options
    end

    def to_json(*args)
      to_hash.to_json(*args)
    end

  private

    def load_file(path)
      return unless File.exists? path

      load_yaml(path).each do |key, values|
        @options[key.to_sym] ||= {}
        @options[key.to_sym].merge!( values.symbolize_keys! )
        @options[key.to_sym][:theme] ||= TinyMCE.default_theme
        @options[key.to_sym][:skin] ||= TinyMCE.default_skin
      end
    end

    def load_yaml(path)
      ActionController::Base.helpers.instance_eval do
        YAML::load(ERB.new(IO.read(path)).result(binding))
      end
    end

  end
end
