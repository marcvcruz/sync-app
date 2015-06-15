module CalendarHelper
  def previous_link
    ->(*args) { link_to raw('&laquo;'), monthly_calendar_path(start_date.year, start_date.prev_month.month) }
  end

  def next_link
    ->(*args) { link_to raw('&raquo;'), monthly_calendar_path(start_date.year, start_date.next_month.month) }
  end

  def table_options
    { :class => 'calendar-body table table-bordered', 'ng-controller' => 'MonthlyCalendarController', 'ng-init' => "init('#{start_date.to_s}')", 'ng-cloak' => '' }
  end

  def td_options
    ->(start_date, current_calendar_date) {
      td_class = ['day']
      td_class << 'today'  if Date.today == current_calendar_date
      td_class << 'past'   if Date.today > current_calendar_date
      td_class << 'future' if Date.today < current_calendar_date
      td_class << 'prev-month'    if start_date.month != current_calendar_date.month && current_calendar_date < start_date
      td_class << 'next-month'    if start_date.month != current_calendar_date.month && current_calendar_date > start_date
      td_class << 'current-month' if start_date.month == current_calendar_date.month
      td_class << "wday-#{current_calendar_date.wday.to_s}"
      {
          class: td_class, 'ng-controller' => 'DayCalendarController'
      }
    }
  end
end