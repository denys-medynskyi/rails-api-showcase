class Post < ApplicationRecord
  belongs_to :user, optional: true
  validates :title, :body, presence: true
end

