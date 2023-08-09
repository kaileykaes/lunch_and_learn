require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password}
    it { should validate_confirmation_of(:password) }
    it { should have_secure_password }
    it { should have_many :favorites }
  end

  describe 'methods' do 
    it 'substantiates api key' do 
      user = User.create!({
        name: 'Jeremonoly', 
        email: 'jer@jer.com', 
        password: 'test', 
        password_confirmation: 'test'        
      })
      expect(user.name).to eq('Jeremonoly')
      expect(user.email).to eq('jer@jer.com')
      expect(user.password).to eq('test')
      expect(user.api_key).to be_a String
    end
  end
end