module ValidationHelper
  def error_exists?(model, field)
    error_messages = model.errors.messages
    error_messages.has_key? field and not error_messages[field].empty?
  end
  
  def error_message_for(model, field)
    field.to_s.humanize << ' ' << (model.errors.messages[field][0] || '') if error_exists? model, field
  end
end
