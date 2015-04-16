require 'active_model'

module ActiveModel
  module Validations

    class NumericalityValidator
      def html_annotations(model, model_name, method_name, options)
        { 'pattern' => '^\d*$' }
      end

      def angular_directive
        'pattern'
      end
    end

    class FormatValidator
      def html_annotations(model, model_name, method_name, options)
        with_regex = @options[:with]
        if with_regex.respond_to?(:call)
          { 'pattern' => with_regex.call(model).source.sub('\\A', '').sub('\\z', '') }
        else
          { 'pattern' => with_regex.source.sub('\\A', '').sub('\\z', '') }
        end
      end

      def angular_directive
        'pattern'
      end
    end

    class PresenceValidator
      def html_annotations(model, model_name, method_name, options)
        { 'required' => 'required' }
      end

      def angular_directive
        'required'
      end
    end

    class LengthValidator
      def html_annotations(model, model_name, method_name, options)
        {
            'minlength' => @options[:minimum],
            'maxlength' => @options[:maximum]
        }
      end

      def angular_directive
        'minlength'
      end
    end

    class ConfirmationValidator
      def html_annotations(model, model_name, method_name, options)
        { 'confirmed-by' => "#{model_name}_#{method_name}_confirmation" }
      end

      def angular_directive
        'confirmedBy'
      end
    end

    class InclusionValidator
      def html_annotations(model, model_name, method_name, options)
        { 'included-in' => @options[:in].join(',') }
      end

      def angular_directive
        'includedIn'
      end
    end
  end
end
