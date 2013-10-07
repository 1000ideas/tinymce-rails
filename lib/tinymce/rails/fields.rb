module TinyMCE::Rails
  module Fields
    extend ActiveSupport::Concern

    def tinymce_field_type(name)
      value = self.class.tinymce_options.try :[], name.to_sym
      if TinyMCE.style_defined? value
        value
      elsif block_given?
        yield
      else
        nil
      end
    end

    module ClassMethods

      def tinymce_fields(*args)
        options = args.extract_options!
        args.each do |f|
          options[f] = :default
        end

        self.class_variable_set "@@_tinymce_options",
          options.symbolize_keys
      end

      def tinymce_options
        if self.class_variable_defined? "@@_tinymce_options"
          self.class_variable_get "@@_tinymce_options"
        end
      end

    end
  end
end
