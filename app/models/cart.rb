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
  has_many :cart_items, dependent: :destroy

  accepts_nested_attributes_for :cart_items, allow_destroy: true, reject_if: :all_blank

  validates :status_id, inclusion: { in: [1, 2] }

  # 近いうちにhas_oneに変更する
  scope :using, -> {
    where(status_id: 1)
  }

  def any_items?
    0 < cart_items.size
  end

  def contents
    @contents ||= CartContents.new(self)
  end
end
