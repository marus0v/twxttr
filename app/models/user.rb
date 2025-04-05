class User < ApplicationRecord
  has_many :posts, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id, dependent: :destroy

  has_secure_password

  # attr_accessible :email, :password # , :password_confirmation
  # validates_uniqueness_of :email

  validates :email, uniqueness: true
end
