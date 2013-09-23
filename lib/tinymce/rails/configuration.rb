module TinyMCE::Rails
  class Configuration
    FILENAME = "tinymce.yml"

    def initialize
      load_file File.expand_path("../../../../config/#{FILENAME}", __FILE__)
      load_file Rails.root.join("config", FILENAME)
    end

    def [](key)
      @options[key.to_sym]
    end

    def to_hash
      @options ||= { default: {theme: 'modern'} }
    end

    def to_json(*args)
      to_hash.to_json(*args)
    end

  private

    def load_file(path)
      @options ||= { default: {theme: 'modern'} }
      return unless File.exists? path
      load_yaml(path).each do |key, values|
        # print "#{key} #{values.inspect}\n"
        @options[key.to_sym] ||= {}
        @options[key.to_sym].merge!( values.symbolize_keys! )
      end
    end

    def load_yaml(path)
      ActionController::Base.helpers.instance_eval do
        YAML::load(ERB.new(IO.read(path)).result(binding))
      end
    end

  end
end