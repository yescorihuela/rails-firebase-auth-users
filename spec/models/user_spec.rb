require 'rails_helper'

RSpec.describe User, type: :model do

  context 'check model validations' do
    subject { build(:user) }
    it { should have_secure_password }
    it { should validate_uniqueness_of(:email).on(:create) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password_digest) }
  end
end
