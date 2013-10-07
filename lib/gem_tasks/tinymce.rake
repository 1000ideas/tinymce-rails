require 'net/http'

module TinyMCE
  class Downloader
    @@files = %{jquery.tinymce.min.js tinymce.js license.txt plugins skins themes}
    attr_reader :version

    def self.files
      @@files
    end

    def initialize
      links = Net::HTTP.get('www.tinymce.com', '/download/download.php')
        .scan(/href="(.*?tinymce_(4\.\d+\.\d+)(?:_(.*))?.zip)"/)

      @version = links.first[1]
      @links = Hash[links.map {|l| [l.last.to_sym || :prod, l.first]}]
    end

    def get(type = :dev)
      link = @links[type]
      if link
        `wget #{link} --quiet -O .tinymce.pkg.zip`
        `unzip -oqq .tinymce.pkg.zip tinymce/js/tinymce/* -x *.less -d .tinymce-dir`
        `cp -Rf .tinymce-dir/tinymce/js/tinymce/{#{self.class.files.join(',')}} vendor/assets/javascripts/tinymce`
        `rm -rf .tinymce-dir .tinymce.pkg.zip`
      end
    end

  end
end

namespace :tinymce do
  desc "Update tinymce version"
  task :update do
    begin
      print "Updating..."
      d = TinyMCE::Downloader.new
      d.get(:dev)
      print "done!\n"
      print "Current TinyMCE version: #{d.version}\n"
    rescue
      print "error!\n"
    end
  end  
end