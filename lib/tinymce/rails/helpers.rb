module TinyMCE::Rails
  module Helpers

    def available_locales
      path = ::Rails.root.join('vendor', 'assets', 'javascripts', 'tinymce', 'langs', '*.js')
      Dir[path.to_s].map do |lang|
        File.basename(lang, '.js')
      end | ['en']
    end

    def styles
      @styles = Configuration.new
    end

    def style_defined? (name)
      styles.to_hash.has_key?(name)
    end
  end
end