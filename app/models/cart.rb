# == Schema Information
#
# Table name: carts # カート
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  status_id  :integer          default("1"), not null # ステータスID
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items

  validates :status_id, inclusion: { in: [1, 2] }

  scope :using, -> {
    where(status_id: 1)
  }

  def empty?
    cart_items.size == 0
  end
end
