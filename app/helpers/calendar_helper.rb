module CalendarHelper
  def previous_link
    ->(*args) { link_to raw('&laquo;'), monthly_calendar_path(start_date.prev_month.year, start_date.prev_month.month) }
  end

  def next_link
    ->(*args) { link_to raw('&raquo;'), monthly_calendar_path(start_date.next_month.year, start_date.next_month.month) }
  end

  def table_options
    { :class => 'calendar-body table table-bordered', 'ng-controller' => 'MonthlyCalendarController', 'ng-init' => "init(#{start_date.year}, #{start_date.month})", 'ng-cloak' => '' }
  end
end