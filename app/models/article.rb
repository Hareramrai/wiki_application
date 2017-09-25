class Article < ApplicationRecord
  include PgSearch

  has_many :taggings
  has_many :tags, through: :taggings
  belongs_to :user

  validates :title, :language, :body, presence: true

  scope :published, -> { where(status: 'published') }

  scope :recently_published, -> { published.order(updated_at: :desc) }

  delegate :email, :gravatar_url, to: :user, prefix: true 

  pg_search_scope :search_for, against: %i(title language body),
    using: { tsearch: { dictionary: "english" } },
    associated_against: { user: :email, tags: [:name] }

  before_create :set_default_status

  after_create_commit { ArticleBroadcasterJob.perform_later(self) }

  def categories=(names)
    self.tags = names.split(",").map do |name|
      Tag.where("lower(name) = ?", name.downcase.strip).first_or_create!(name: name)
    end
  end

  def categories
    self.tags.map(&:name).join(', ')
  end

  def self.filter params
    relation = self.includes(:tags, :user)
    relation = relation.search_for(params[:query]) if params[:query].present?
    relation.recently_published
  end

  private
  def set_default_status
    self.status = 'published'
  end
end
