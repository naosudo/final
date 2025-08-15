class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :payment
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :day

  belongs_to :user
  has_one_attached :image

  # 必須項目
  validates :name, :image, :price, :description, :category_id, :status_id, :payment_id, :prefecture_id, :day_id, presence: true

  # 価格の範囲
  validates :price, numericality: { only_integer: true , greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }

  # ActiveHash の初期値(0)を除外
  validates :category_id, numericality: { other_than: 0 }
  validates :status_id,   numericality: { other_than: 0 }
  validates :payment_id,  numericality: { other_than: 0 }
  validates :prefecture_id, numericality: { other_than: 0 }
  validates :day_id, numericality: { other_than: 0 }
end
