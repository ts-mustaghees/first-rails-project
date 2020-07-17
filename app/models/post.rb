class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :comments

  mount_uploader :picture, PictureUploader

  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, length: { minimum: 3 }
  validates :body, length: { maximum: 150 }, presence: true
  validate :picture_size

  private
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5 MB")
      end
    end
end
