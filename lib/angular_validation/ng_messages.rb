require 'i18n'
require 'action_view'
require 'active_model'

module ActionView
  module Helpers
    #InstanceTag is rails 3.x only...need to do something else for 4.x support

    class FormBuilder
      def ng_messages(attribute, show: nil, multiple: false, additional_validators: {})
        validators = @object.class.validators_on(attribute)
        ng_model = "#{@options[:ng_model]}[#{attribute}]".gsub(/'/, '')
        ng_form = @options[:ng_form]
        InstanceTag.new(ng_form, ng_model, self, options.delete(:object))
            .to_ng_messages_tag(validators, show: show, multiple: multiple, additional_validators: additional_validators)
      end
    end

    class InstanceTag
      def to_ng_messages_tag(validators, show: nil, multiple: false, additional_validators: {})
        ngModel = "#{object_name}['#{method_name}']"
        form = "#{object_name}"
        ngShow = show || "#{form}.$submitted || #{ngModel}.$touched"

        content_tag 'ng-messages ng-cloak', for: "#{ngModel}.$error", 'ng-show' => ngShow, multiple: multiple do
          messages = ''
          validators.each do |validator|
            if validator.localized_message
              messages += content_tag 'ng-message', validator.localized_message, when: validator.angular_directive
            end
          end
          additional_validators.each do |ng_directive, message|
            messages += content_tag 'ng-message', message, when: ng_directive.to_s.camelize(:lower)
          end
          messages.html_safe
        end
      end

      attr_accessor :output_buffer
    end
  end
end

module ActiveModel
  class Validator
    def localized_message
      message = options[:message]
      message.is_a?(Symbol) ? I18n.t(message, scope: %i(errors messages)) : message
    end

    def angular_directive
      kind
    end
  end
end