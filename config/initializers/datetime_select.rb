module ActionView
  module Helpers
    class FormBuilder
      def datetime_select(method, options = {}, html_options = {})
        options[:class] = "#{options[:class]} input-group"
        options[:'date-time-picker'] = ''
        options[:'data-date-use-strict'] = true unless options.has_key? :'data-date-use-strict'
        options[:'data-date-use-current'] = false unless options.has_key? :'data-date-use-current'
        include_icon = options.has_key?(:include_icon) ? options.delete(:include_icon) : true
        icon_class = options.has_key?(:icon_class) ? "glyphicon #{options.delete(:icon_class)}" : 'glyphicon glyphicon-calendar'

        @template.content_tag(:div, options) do
          buffer = text_field(method, class: 'form-control', 'ng-model-options' => "{ updateOn: 'default' }" )
          buffer += @template.content_tag(:span, @template.content_tag(:span, '', class: icon_class), class: 'input-group-addon') if include_icon
          buffer
        end
      end
    end
  end
end