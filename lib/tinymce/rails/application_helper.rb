module TinyMCE::Rails
  module ApplicationHelper
    def tinymce_init_styles
      javascript_tag render( partial: "tiny_mce/init_styles", formats: [:js] )
    end
  end
end
