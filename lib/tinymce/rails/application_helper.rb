module TinyMCE::Rails
  module ApplicationHelper
    def tinymce_init_styles
      render("tiny_mce/init_styles")
    end
  end
end
