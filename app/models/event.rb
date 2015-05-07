class Event < ActiveRecord::Base
  scope :all_happening_on, -> date { where('DATE(starting_date_time) = ?', date.to_date) }
  belongs_to :organizer, class_name: User

  validates_length_of :description, maximum: 100, message: :can_not_exceed_100_characters
  validates_length_of :notes, maximum: 500, allow_blank: true, message: :can_not_exceed_500_characters
  validates_presence_of :organizer, :description, :starting_date_time, message: :field_is_required

  def starting_on
   starting_date_time.to_date
  end

  def starting_at
    starting_date_time.to_time unless self.is_all_day?
  end
end