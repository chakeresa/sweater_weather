class Image < ApplicationRecord
  validates :title, uniqueness: { case_sensitive: false }, presence: true

  before_save { self.title = self.title.to_s.downcase }
end
