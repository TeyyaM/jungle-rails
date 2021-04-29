class Product < ActiveRecord::Base
  monetize :price_cents, numericality: true
  mount_uploader :image, ProductImageUploader

  has_many :orders, :through => :line_items
  has_many :line_items
  belongs_to :category

  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :category, presence: true
end
