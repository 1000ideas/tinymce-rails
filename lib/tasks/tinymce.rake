module TinyMCE
  module Task
    URL = "http://www.tinymce.com/i18n/download.php"

    def self.get_language_pack(lang)
      filename = "tmp/#{lang}-lang.zip"
      url = "#{URL}?download=#{lang}"
      `wget #{url} --quiet -O #{filename}`
      raise "Install 'wget' to download language pack" unless $?.success?
      raise "No '#{lang}' language pack exists" if File.read(filename, 5).match(/error/i)
      output = ::Rails.root.join('vendor', 'assets', 'javascripts', 'tinymce')
      `unzip -qo #{filename} -d #{output.to_s}`
      raise "Install 'unzip' to unpack language pack" unless $?.success?
    rescue ::Exception => ex
      puts ex
    ensure
      FileUtils.rm_f filename
    end

  end
end

namespace :tinymce do
  namespace :lang do
    desc "Get all available langs"
    task all: :environment do
      (I18n.available_locales | [I18n.default_locale]).each do |lang|
        TinyMCE::Task.get_language_pack lang
      end
    end

    desc "Get lang from variable LANG"
    task get: :environment do
      lang = ENV['LANG']
      TinyMCE::Task.get_language_pack lang      
    end
  end
end