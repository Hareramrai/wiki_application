require 'rails_helper'

RSpec.describe Tag, type: :model do
  let(:tag) { create(:tag, name: 'MySQL') }
  let(:article) { create(:article) }

  describe 'associations' do
    it { should have_many(:taggings) }
    it { should have_many(:articles) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).ignoring_case_sensitivity }
  end

  describe ".articles_count" do 
    before { 
      article.tags = [ tag ]
    }

    it 'returns the tag with number of article associated with it' do
      expect(Tag.articles_count).to be_present
    end
  end
end
