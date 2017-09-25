require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, type: :model do

  let(:unknow_user) { create(:user) }

  describe "admin" do 
    before { unknow_user.role = Role.find_by(name: 'Admin') }
    subject(:ability){ Ability.new(unknow_user) }

    it { should be_able_to(:manage, :all) }
  end

  describe "author" do
    let(:author) { create(:user) }
   
    subject(:ability){ Ability.new(author) }

    context "can acccess his article" do
      it{ should be_able_to(:manage, Article.new) }
    end

    context "can't access other's article" do
      let(:article) { create(:article, user: unknow_user) }
      it{ should_not be_able_to(:manage, article) }
    end
  end

  describe "guest" do 
    subject(:ability){ Ability.new(nil) }

    it { should be_able_to(:read, :all) }
  end


end