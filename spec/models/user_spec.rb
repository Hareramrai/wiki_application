require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe 'associations' do
    it { should have_many(:articles) }
    it { should have_one(:user_role) }
    it { should have_one(:role) }
  end

  context 'set default role' do 
    it 'has the default role' do 
      new_user = User.new 
      new_user.run_callbacks :create
      expect(new_user.role).to be_present
    end
  end

  it 'returns the role name' do 
    expect(user.role_name).to eq('Author')
  end

  describe 'role_manager' do

    it 'respond to admin?' do
      expect(user.admin?).to be_falsy
    end

    it 'respond to author?' do
      expect(user.author?).to be_truthy
    end

    it 'respond to moderator?' do
      expect(user.moderator?).to be_falsy
    end

  end

end
