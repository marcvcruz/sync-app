class Event < ActiveRecord::Base
  belongs_to :organizer, class_name: User

  validates_presence_of :organizer, :description, :start_date
  validates_presence_of :start_time, if: :not_all_day?

  def not_all_day?
    not is_all_day?
  end
end