module ActionView
  module Helpers
    class FormBuilder
      def date_select(method, options = {}, html_options = {})
        existing_date = @object.send(method)
        formatted_date = existing_date.to_date.strftime('%F') if existing_date.present?
        @template.content_tag(:div, class: 'input-group') do
          text_field(method, value: formatted_date, class: 'form-control datepicker', :'data-date-format' => 'YYYY-MM-DD') +
              @template.content_tag(:span, @template.content_tag(:span, '', class: 'glyphicon glyphicon-calendar') , class: 'input-group-addon')
        end
      end

      def datetime_select(method, options = {}, html_options = {})
        options[:class] = "#{options[:class]} input-group"
        options[:'date-time-picker'] = ''
        @template.content_tag(:div, options) do
          text_field(method, class: 'form-control', 'ng-init' => 'angular.noop()', 'ng-model-options' => "{ updateOn: 'default' }" ) +
              @template.content_tag(:span, @template.content_tag(:span, '', class: 'glyphicon glyphicon-calendar') ,class: 'input-group-addon')
        end
      end
    end
  end
end