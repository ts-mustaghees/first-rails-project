class Post < ApplicationRecord
  belongs_to :user
  validates :body, length: { maximum: 150 }, presence: true
end
