require 'action_view'
require 'angular_validation/form_builder_extensions'

module AngularValidation
  class FormBuilder < ActionView::Helpers::FormBuilder
    prepend AngularValidation::FormBuilderExtensions

    def initialize(object_name, object, template, options, proc)
      options[:ng_model] ||= "#{object_name}"
      options[:ng_form] ||= options[:html][:name]
      super
    end

    def fields_for(record_name, record_object = nil, fields_options = {}, &block)
      fields_options[:ng_form] = options[:ng_form]
      fields_options[:ng_model] = if record_name.is_a? String
                                    "#{options[:ng_model]}['#{record_name.underscore}']"
                                  elsif record_name.class.respond_to? :model_name
                                    fields_options[:ng_model] = "#{options[:ng_model]}['#{record_name.class.model_name.underscore}']"
                                  else
                                    "#{options[:ng_model]}['#{record_name}']"
                                  end
      super
    end
  end
end
