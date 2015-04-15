require 'i18n'
require 'action_view'
require 'active_model'

module ActionView
  module Helpers
    class FormBuilder
      def ng_messages(attribute, field_options={})
        field_options[:validators] = @object.class.validators_on(attribute)
        field_options[:form_name] = @options[:form_name]
        Tags::NgMessages.new(@object_name, attribute, self, field_options).render
      end
    end

    module Tags
      class NgMessages < Base
        attr_accessor :output_buffer

        def render
          form_name = "#{@options[:form_name]}"
          options = @options.stringify_keys
          add_default_name_and_id(options)
          ngModel = "#{form_name}['#{options.delete('name')}']"
          ngShow = @options[:show] || "#{form_name}.$submitted || #{ngModel}.$touched"

          content_tag 'ng-messages ng-cloak', for: "#{ngModel}.$error", 'ng-show' => ngShow, multiple: @options[:multiple] do
            messages = ''
            @options[:validators].each do |validator|
              if validator.localized_message
                messages += content_tag 'ng-message', validator.localized_message, when: validator.angular_directive
              end
            end

            if @options.key?(:additional_validators)
              @options[:additional_validators].each do |ng_directive, message|
                messages += content_tag 'ng-message', message, when: ng_directive.to_s.camelize(:lower)
              end
            end
            messages.html_safe
          end
        end
      end
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