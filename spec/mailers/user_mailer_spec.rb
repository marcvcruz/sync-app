require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'password_reset' do
    let(:user) { FactoryGirl.create :user }
    let(:mail) {
      user.create_reset_digest
      UserMailer.password_reset user
    }

    it 'renders the headers' do
      expect(mail.subject).to eq('Password reset')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['no-reply@sync-app.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match /[a-z]*[0-9]*password-resets[a-z]*[0-9]*/i
    end
  end

end
