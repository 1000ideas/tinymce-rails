module TinyMCE::Rails
  module FormHelper
    def tinymce_tag(name, content = nil, options = {})
      type = options.delete(:type) || :default
      options[:data] ||= {}
      options[:data][:tinymce] = type
      _id = options[:id] || sanitize_to_id(name)
      [ text_area_tag(name, content, options), javascript_tag("window.tinyMCELoader.init('#{_id}');") ].join.html_safe
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

        sanitized_object_name = @object_name.to_s.gsub(/\]\[|[^-a-zA-Z0-9:.]/, "_").sub(/_$/, "")
        sanitized_method_name = method.to_s.sub(/\?$/,"")

        _id = options.fetch("id") do
          if options.has_key?("index")
            "#{sanitized_object_name}_#{options['index']}_#{sanitized_method_name}"
          elsif defined?(@auto_index)
            "#{sanitized_object_name}_#{@auto_index}_#{sanitized_method_name}"
          else
            "#{sanitized_object_name}_#{sanitized_method_name}"
          end
        end

        _id = [options.fetch('namespace', nil), _id].compact.join("_").presence

        [ text_area(method, objectify_options(options)), @template.javascript_tag("window.tinyMCELoader.init('#{_id}');") ].join.html_safe
      end
    end
  end
end
