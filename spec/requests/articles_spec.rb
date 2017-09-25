require 'rails_helper'

RSpec.describe "Articles", type: :request do
  let!(:user) { create(:user) }
  let!(:articles) { create_list(:article, 3, user: user) }
  let(:article) { articles.first }

  describe 'GET /articles with valid session' do
    before { login_as(user, :scope => :user)  }

    it 'returns status code 200' do
      get articles_path
      expect(response).to have_http_status(200)
    end

    it 'returns articles' do
      get articles_path
      expect(response).to render_template(:index)
      expect(response.body).to include(article.title)
    end
  end

  describe 'GET /articles/new with valid session' do
    before { login_as(user, :scope => :user)  }

    it 'returns status code 200' do
      get new_article_path
      expect(response).to have_http_status(200)
    end

    it 'returns new article form' do
      get new_article_path
      expect(response).to render_template(:new)
      expect(response.body).to include("New Article")
    end
  end

  describe 'POST /articles with valid session' do
    before { login_as(user, :scope => :user)  }

    describe 'when the request is valid' do
      let(:valid_attributes) { { article: attributes_for(:article, user: user) } }
      before {
        post articles_path, params: valid_attributes 
      }
      it 'creates a article and redirect to show page' do
        expect(response).to redirect_to(assigns(:article))
        follow_redirect!
        expect(response).to render_template(:show)
        expect(response.body).to include("Article was successfully created.")
      end
    end

    describe 'when the request is invalid' do
      before { post articles_path, params: invalid_attributes }

      context "when title is blank" do
        let(:invalid_attributes) { { article: attributes_for(:article, title: nil) } }

        it 'returns a validation failure message' do
          expect(response.body).to include("Title can&#39;t be blank")
        end
      end
    end
  end

  describe 'PATCH /articles/:id' do
    let(:other_auhtor) { create(:user) }

    context "with other author" do 
      before { login_as(other_auhtor, :scope => :user)  }

      describe 'when the request is valid' do
        let(:valid_attributes) { { article: attributes_for(:article, user: other_auhtor) } }
        before {
          patch article_path(article), params: valid_attributes 
        }

        it "don't allow to update the article" do
          expect(response).to redirect_to(root_path)
          follow_redirect!
          expect(response.body).to include("You are not authorized to access this page.")
        end
      end
    end

    context "with same author" do 
      before { login_as(user, :scope => :user)  }

      describe 'when the request is valid' do
        let(:valid_attributes) { { article: attributes_for(:article, user: user) } }
        before {
          patch article_path(article), params: valid_attributes 
        }

        it 'updates a article and redirect to show page' do
          expect(response).to redirect_to(assigns(:article))
          follow_redirect!
          expect(response).to render_template(:show)
          expect(response.body).to include("Article was successfully updated.")
        end
      end

      describe 'when the request is invalid' do
        let(:valid_attributes) { { article: attributes_for(:article, body: nil) } }
        before {
          patch article_path(article), params: valid_attributes 
        }
        
        it 'updates a article and redirect to show page' do
          expect(response).to render_template(:edit)
          expect(response.body).to include("Body can&#39;t be blank")
        end
      end
    end
  end

  describe 'DELETE /articles/:id' do
    let(:other_auhtor) { create(:user) }

    context "with other author" do 
      before { login_as(other_auhtor, :scope => :user)  }

      describe 'when article is present' do
        before {
          delete article_path(article.id)
        }
        
        it "don't allow to delete other's article" do
          expect(response).to redirect_to(root_path)
          follow_redirect!
          expect(response.body).to include("You are not authorized to access this page.")
        end
      end
    end

    context "with same author" do 
      before { login_as(user, :scope => :user)  }

      describe 'when article is present' do
        it 'deletes the article and redirect to index' do
          delete article_path(article.id)
          expect(response).to redirect_to(articles_path)
          follow_redirect!
          expect(response).to render_template(:index)
          expect(response.body).to include("Article was successfully destroyed.")
        end
      end
    end
  end

end
