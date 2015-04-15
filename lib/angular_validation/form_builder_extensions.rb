require 'angular_validation/validators'

module AngularValidation
  module FormBuilderExtensions

    # def check_box(method, options = {}, checked_value = "1", unchecked_value = "0")
    #   add_options method, options
    #   checked = options[:checked]
    #   init_model_value checked_value, options if checked
    #   super
    # end
    #
    # def radio_button(method, tag_value, options={})
    #   add_options method, options
    #   checked = options[:checked]
    #   options['value'] = tag_value
    #   init_model_value tag_value, options if checked
    #   super
    # end
    #
    def password_field(method, options = {})
      add_options method, options
      add_model_options options
      super
    end
    #
    # def text_area(method, options = {})
    #   add_options method, options
    #   value = @object.send method
    #   init_model_value value, options if value
    #   super
    # end

    def text_field(method, options = {})
      add_options method, options
      add_model_options options
      value = @object.send method
      init_model_value value, options unless value.blank?
      super
    end

    # def select(method, choices, options = {}, html_options = {})
    #   add_options method, html_options
    #   selected = options[:selected] || @object.send(method)
    #   init_model_value selected, html_options if selected
    #   super method, choices, options, html_options
    # end
    #
    # def collection_select(method, collection, value_method, text_method, options = {}, html_options = {})
    #   add_options method, html_options
    #   selected = options[:selected] || @object.send(method)
    #   init_model_value selected, html_options if selected
    #   super method, collection, value_method, text_method, options, html_options
    # end

    private

    def init_model_value(value, options)
      ng_model = options['ng-model']
      options['ng-init'] ||= "#{ng_model} = '#{value}'"
    end

    def add_options(method, options)
      add_ng_model method, options
      add_validation_attributes method, options
    end

    def add_model_options(field_options)
      field_options['ng-model-options'] ||= "{ updateOn: 'default blur', debounce: { default: 500, blur: 0 } }"
    end

    def add_ng_model(method, field_options)
      field_options['ng-model'] ||= "#{options[:ng_model_name]}['#{method.to_s.camelize(:lower)}']"
    end

    def add_validation_attributes(attribute, options)
      validators = @object.class.validators_on(attribute) # the list of all validators assigned to attribute
      validators.each do |validator|
        next if skip_validation?(@object, validator.options)

        if validator.respond_to?(:html_annotations)
          options.merge!(validator.html_annotations(@object, object_name, attribute, options))
        end
      end

      options.delete(:validate)
    end

    def skip_validation?(object, voptions)
      if voptions[:if].present?
        return true if voptions[:if].is_a?(Proc)   && voptions[:if].call(object) == false
        return true if voptions[:if].is_a?(Symbol) && object.send(voptions[:if]) == false
      end

      if voptions[:unless].present?
        return true if voptions[:unless].is_a?(Proc)   && voptions[:unless].call(object) == true
        return true if voptions[:unless].is_a?(Symbol) && object.send(voptions[:unless]) == true
      end

      false
    end
  end
end
