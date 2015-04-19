class Event < ActiveRecord::Base
  belongs_to :organizer, class_name: User

  validates_length_of :description, maximum: 100, message: :can_not_exceed_100_characters
  validates_length_of :notes, maximum: 500, allow_blank: true, message: :can_not_exceed_500_characters
  validates_presence_of :organizer, :description, :starting_at, message: :field_is_required

end