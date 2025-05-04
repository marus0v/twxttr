class Post < ApplicationRecord
  include Visible

  belongs_to :author, class_name: "User"

  has_many :comments, dependent: :destroy
  has_many_attached :images, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }

  # validates :image_format
  # validates :image_size

  # private
  #  def image_format
  #    return unless image.attached?
  #    unless image.content_type.in?(%w[image/jpeg image/png image/gif])
  #      errors.add(:avatar, "Use JPEG, PNG or GIF")
  #    end
  #  end

  #  def image_size
  #    return unless image.attached?
  #    if image.byte_size > 5.megabytes
  #      errors.add(:image, "File size must be less than 5 Mb")
  #    end
  #  end
end
