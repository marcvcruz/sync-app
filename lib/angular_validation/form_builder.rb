require 'action_view'
require 'angular_validation/form_builder_extensions'

module AngularValidation
  class FormBuilder < ActionView::Helpers::FormBuilder
    prepend AngularValidation::FormBuilderExtensions

    def initialize(object_name, object, template, options)
      options[:ng_model_name] ||= "#{object_name}"
      options[:form_name] ||= options[:html][:name]
      options[:html].reverse_merge! 'submit-on-valid' => '' , autocomplete: 'off', novalidate: '', 'submit-on-valid' => ''
      super
    end

    def fields_for(record_name, record_object = nil, fields_options = {}, &block)
      fields_options[:form_name] = options[:form_name]

      attribute_name = record_name.class.respond_to?(:model_name) ? record_name.class.model_name.underscore : record_name.to_s.underscore
      fields_options[:ng_model_name] = "#{options[:ng_model_name]}['#{attribute_name}']"
      super
    end
  end
end
