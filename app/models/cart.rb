# == Schema Information
#
# Table name: carts # カート
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  state        :string                                 # ステータスID
#  postal_code  :string           default("")           # 郵便番号
#  address      :string           default("")           # 住所
#  completed_at :datetime                               # 取引完了日
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  accepts_nested_attributes_for :cart_items, allow_destroy: true, reject_if: :all_blank

  def any_items?
    0 < cart_items.size
  end

  def contents
    @contents ||= CartContents.new(self)
  end
end
