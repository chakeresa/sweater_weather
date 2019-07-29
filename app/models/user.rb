class User < ApplicationRecord
  validates :email, uniqueness: { case_sensitive: false }, presence: true  

  has_secure_password
end
