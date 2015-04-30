class CalendarController < ApplicationController

  def show
  end

  helper_method def events_on(date)
    Event.all_happening_on(date).order(starting_at: :desc)
  end
end
