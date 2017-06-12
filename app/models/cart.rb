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
  PERMITTED_ATTRIBUTES = %i(state postal_code address).freeze

  belongs_to :user
  has_many :cart_items, dependent: :destroy

  accepts_nested_attributes_for :cart_items, allow_destroy: true, reject_if: :all_blank

  validates :state, presence: true
  validates :postal_code, format: { with: /\A\d{7}\z/, allow_blank: true }

  state_machine :state, initial: :address do
    state :address
    state :confirm

    event :to_confirm do
      transition :address => :confirm
    end

    event :back do
      transition :confirm => :address
    end

    event :finish do
      transition :confirm => :complete
    end

    after_transition to: :complete, do: :set_completed_at
  end

  scope :incomplete, -> {
    where(completed_at: nil)
  }

  def any_items?
    0 < cart_items.size
  end

  def contents
    @contents ||= CartContents.new(self)
  end

  def set_completed_at
    update(completed_at: DateTime.current)
  end
end
