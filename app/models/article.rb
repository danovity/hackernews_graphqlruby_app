class Article < ApplicationRecord
  validates :title, presence: true
  validates :author_name, presence: true
  validates :published_at, presence: true
  validates :description, presence: true
  validates :image_url, presence: true
  validates :article_url, presence: true
  validates :hackernews_article_id, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true

  scope :top_stories, -> { where(top_story: true) }
  scope :best_stories, -> { where(best_story: true) }
  scope :new_stories, -> { where(new_story: true) }
end
