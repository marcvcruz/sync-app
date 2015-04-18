class Event < ActiveRecord::Base
  belongs_to :organizer, class_name: User

  validates_length_of :description, maximum: 100, message: :can_not_exceed_100_characters
  validates_length_of :notes, maximum: 500, allow_blank: true, message: :can_not_exceed_500_characters
  validates_presence_of :organizer, :description, :start_date, message: :field_is_required
  validates_presence_of :start_time, message: :field_is_required, if: :not_all_day?

  def not_all_day?
    not is_all_day?
  end

  def start_date=(value)
    @start_date = Date.parse(value)
  end
end