class Event < ActiveRecord::Base
  attr_accessor :starting_on, :starting_at

  scope :all_happening_on, -> date { where('DATE(starting_date_time) = ?', date.to_date) }
  belongs_to :organizer, class_name: User

  before_save :convert_start_to_datetime

  validates_length_of :description, maximum: 100, message: :can_not_exceed_100_characters
  validates_length_of :notes, maximum: 500, allow_blank: true, message: :can_not_exceed_500_charactersN
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
end