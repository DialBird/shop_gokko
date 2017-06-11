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

FactoryGirl.define do
  factory :cart do
    state "address"
    postal_code "1234567"
    address "somewhere"

    after :build do |cart|
      if cart.user.blank?
        cart.user = User.find_by(id: 1) || FactoryGirl.create(:user)
      end
    end
  end
end
