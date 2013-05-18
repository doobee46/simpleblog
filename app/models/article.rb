class Article < ActiveRecord::Base
  attr_accessible :body, :excerpt, :location, :published_at, :title

  validates :title, :presence => true
  validates :body, :presence => true

  belongs_to :user
  has_many   :comments
  has_and_belongs_to_many :categories

  scope :published, where("articles.published_at IS NOT NULL")
  scope :draft, where("articles.published_at IS NULL")
  scope :recent, lambda{published.where("articles.published_at > ?", 1.week.ago.to_date).order("published_at Desc").limit(5)}
  scope :where_title, lambda {|term| where("articles.title LIKE ?", "%#{term}%")}

  def long_title
  	"#{title}" + " " + datereg.to_s 
  end

  def datereg
    published_at.to_formatted_s(:short)
  end

  def published?
  	published_at.present?
  end 
  

 
end
