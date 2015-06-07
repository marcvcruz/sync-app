class Event < ActiveRecord::Base
  attr_accessor :starting_on, :starting_at

  scope :occurs_in, -> date { where('starting_date_time BETWEEN ? AND ?', date.beginning_of_month.beginning_of_week.beginning_of_day.utc, date.end_of_month.end_of_week.end_of_day.utc).all }
  belongs_to :organizer, class_name: User

  before_save :convert_start_to_datetime

  validates_length_of :description, maximum: 100, message: :can_not_exceed_100_characters
  validates_length_of :notes, maximum: 500, allow_blank: true, message: :can_not_exceed_500_characters
  validates_presence_of :organizer, :description, :starting_on, :starting_at, message: :field_is_required

  def starting_on
    @starting_on ||= (starting_date_time.to_s :date_input_field if self.starting_date_time?)
  end

  def starting_at
    @starting_at ||= (starting_date_time.to_s :time_input_field if self.starting_date_time?)
  end

  def is_all_day=(value)
    write_attribute(:is_all_day, value)
    self.starting_at = '12:00 AM' if value
  end

  private def convert_start_to_datetime
    self.starting_date_time = convert_to_date_time self.starting_on, self.starting_at
  end

  private def convert_to_date_time(date, time)
    Time.strptime date + ' ' + time, Date::DATE_FORMATS[:datetime_input_field]
  end

  def self.occurring_same_month_as(date)
    Event.occurs_in(date).group_by { |ev| ev.starting_date_time.to_date.to_s }
  end
end