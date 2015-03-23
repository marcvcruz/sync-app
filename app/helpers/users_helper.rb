module UsersHelper
  def error_exists?(field)
    error_messages = @user.errors.messages
    error_messages.has_key? field and not error_messages[field].empty?
  end
  
  def error_message_for(field)
    field.to_s.humanize << ' ' << (@user.errors.messages[field][0] || '')
  end
end
