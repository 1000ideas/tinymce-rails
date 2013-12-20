module TinyMCE::Rails
  module FormHelper
    def tinymce_tag(name, content = nil, options = {})
      type = options.delete(:type) || :default
      options[:data] ||= {}
      options[:data][:tinymce] = type
      text_area_tag(name, content, options)
    end

    def self.included(base)
      ActionView::Helpers::FormBuilder.send :include, FormBuilderMethods
    end

    module FormBuilderMethods
      def tinymce(method, options = {})
        type = options.delete(:type) || if @object.respond_to? :tinymce_field_type
          @object.tinymce_field_type(method) { :default }
        else
          :default
        end
        options[:data] ||= {}
        options[:data][:tinymce] = type
        text_area(method, objectify_options(options))
      end
    end
  end
end