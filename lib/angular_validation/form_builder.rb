require 'action_view'
require 'angular_validation/form_builder_extensions'

module AngularValidation
  class FormBuilder < ActionView::Helpers::FormBuilder
    prepend AngularValidation::FormBuilderExtensions
    include ActionView::Helpers::TagHelper

    def initialize(object_name, object, template, options)
      options[:html] ||= {}
      options[:html].reverse_merge! 'submit-on-valid' => '' , name: options[:as] || name_for(object_name), autocomplete: 'off', novalidate: ''
      options[:ng_model_name] ||= "#{object_name}"
      options[:form_name] ||= options[:html][:name]
      super
    end

    def fields_for(record_name, record_object = nil, fields_options = {}, &block)
      fields_options[:form_name] = options[:form_name]
      fields_options[:ng_model_name] = "#{options[:ng_model_name]}['#{name_for(record_name)}']"
      super
    end

    private
    def name_for(object)
      object.class.respond_to?(:model_name) ? object.class.model_name.underscore : object.to_s.underscore
    end
  end
end
