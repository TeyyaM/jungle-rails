class User < ActiveRecord::Base
  has_many :orders
  has_secure_password
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true, length: { minimum: 3 }, confirmation: true
  validates :password_confirmation, presence: true
  validates_confirmation_of :password

end
