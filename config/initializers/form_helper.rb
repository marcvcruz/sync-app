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
        existing_time = @object.send(method) unless @object.nil?
        options[:value] ||= existing_time.to_time.strftime('%F %I:%M %p') if existing_time.present?

        @template.content_tag(:div, id: "#{object_name}_#{method}_container", class: 'input-group', 'date-time-picker' => '', format: options[:format], value: options[:value], 'ng-init' => options[:ng_init]) do
          text_field(method, class: 'form-control') +
              @template.content_tag(:span, @template.content_tag(:span, '', class: 'glyphicon glyphicon-calendar') ,class: 'input-group-addon')
        end
      end
    end
  end
end