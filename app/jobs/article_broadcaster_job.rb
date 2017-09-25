class ArticleBroadcasterJob < ApplicationJob
  queue_as :default

  def perform(article)
    ActionCable.server.broadcast "articles", { article: render_article(article) }
  end

  private

  def render_article(article)
    ArticlesController.render(partial: 'article', locals: {article: article}).squish
  end
end
