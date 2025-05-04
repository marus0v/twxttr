class User < ApplicationRecord
  has_many :posts, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id #, dependent: :destroy
  has_one_attached :avatar

  has_secure_password

  # attr_accessible :email, :password # , :password_confirmation
  # validates_uniqueness_of :email

  validates :email, uniqueness: true

  # validates :avatar_format
  # validates :avatar_size

  # private
  #  def avatar_format
  #    return unless avatar.attached?
  #    unless avatar.content_type.in?(%w[image/jpeg image/png image/gif])
  #      errors.add(:avatar, "Use JPEG, PNG or GIF")
  #    end
  #  end

  #  def avatar_size
  #    return unless avatar.attached?
  #    if avatar.byte_size > 5.megabytes
  #      errors.add(:avatar, "File size must be less than 5 Mb")
  #    end
  #  end
end
