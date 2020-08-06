class Gossip < ApplicationRecord
  validates :title, presence: true,
    length: { minimum: 3, too_short: "%{count} characters is not enough", maximum: 14, too_long: "%{count} characters is too long" }
  validates :content, presence: true
  belongs_to :user
  has_many :join_table_tag_gossips
  has_many :tags, through: :join_table_tag_gossips
  has_many :comments
  has_many :users, through: :comments
  has_many :likes, as: :content
end
