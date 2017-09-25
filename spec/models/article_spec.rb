require 'rails_helper'

RSpec.describe Article, type: :model do

  let(:article) { build(:article) }
 
 describe 'associations' do
    it { should have_many(:taggings) }
    it { should have_many(:tags) }
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:language) }
    it { should validate_presence_of(:body) }
  end


  context 'set default status' do 
    it 'has the default status as published' do 
      new_article = build(:article)
      new_article.run_callbacks :create
      expect(new_article.status).to eq('published')
    end
  end

  describe 'categories' do
    context 'set categories' do
      it 'allow to set categories' do 
        expect { article.categories= 'Ruby,Java' }.not_to raise_error
      end
    end

    context 'get categories' do
      before { article.categories= 'Ruby,Java' }
      it 'allow to get categories' do 
        expect(article.categories).to eq('Ruby, Java')
      end
    end
  end

  describe 'filter' do
    before { article.save }

    it 'filter based on title' do 
      expect(Article.filter(query: article.title)).to be_present
    end

    it 'filter based on language' do 
      expect(Article.filter(query: article.language)).to be_present
    end

    it 'filter based on body' do 
      expect(Article.filter(query: article.body.split(' ').first)).to be_present
    end
  end
end
