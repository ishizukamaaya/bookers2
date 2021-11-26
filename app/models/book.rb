class Book < ApplicationRecord
  validates :title, presence: true
  validates :body, length: { in: 1..200 }

  belongs_to :user
  has_many :book_comments, dependent: :destroy
end
