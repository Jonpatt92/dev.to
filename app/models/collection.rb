class Collection < ApplicationRecord
  has_many :collection_articles
  has_many :articles, through: :collection_articles
  belongs_to :user
  belongs_to :organization, optional: true

  validates :user_id, presence: true
  validates :title, presence: true
  validates :slug, presence: true, uniqueness: { scope: :user_id }

  after_touch :touch_articles
  before_validation :create_slug

  def self.find_series(slug, user)
    Collection.find_or_create_by(slug: slug, user: user)
  end

  def touch_articles
    articles.update_all(updated_at: Time.zone.now)
  end

  def create_slug
    self.slug = title_to_slug if slug.blank? && title.present?
  end

  def title_to_slug
    title.to_s.downcase.parameterize.tr("_", "") + "-" + rand(100_000).to_s(26)
  end
end
