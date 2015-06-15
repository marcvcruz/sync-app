class EventSerializer < ActiveModel::Serializer
  attributes :id, :description, :isAllDay, :startingDate, :startingTime

  def isAllDay
    object.is_all_day
  end

  def startingDate
    object.starting_on
  end

  def startingTime
    object.starting_at
  end
end
