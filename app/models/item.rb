class Item < ApplicationRecord
  validates :name, :text, :status, :price, presence: true
  # belongs_to :user
  belongs_to :seller, class_name: "User"
  has_one :delivery

  has_many_attached :images
end
