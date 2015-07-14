class EventSummarySerializer < ActiveModel::Serializer
  attributes :id, :description, :isAllDay, :startingOn, :startingAt

  def isAllDay
    object.is_all_day
  end

  def startingOn
    object.starting_on
  end

  def startingAt
    object.starting_at
  end
end
