class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :comments

  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :body, length: { maximum: 150 }, presence: true
end
