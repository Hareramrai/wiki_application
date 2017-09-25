class Tag < ApplicationRecord
  has_many :taggings
  has_many :articles, through: :taggings

  validates :name, presence: true 
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  class << self
    def articles_count
      select('tags.*, count(taggings.tag_id) as count').left_joins(:taggings).group('tags.id, tags.name').order('count desc')
    end
  end
end
