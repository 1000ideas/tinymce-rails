module TinyMCE::Rails
  module Helpers

    def available_locales
      path = ::Rails.root.join('vendor', 'assets', 'javascripts', 'tinymce', 'langs', '*.js')
      Dir[path.to_s].map do |lang|
        File.basename(lang, '.js')
      end | ['en']
    end

    def config
      @config ||= Configuration.new
    end
  end
end