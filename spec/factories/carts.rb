# == Schema Information
#
# Table name: carts # カート
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  status_id   :integer          default("1"), not null # ステータスID
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  postal_code :string           default("")            # 郵便番号
#  address     :string           default("")            # 住所
#

FactoryGirl.define do
  factory :cart do
    status_id 1

    after :build do |cart|
      if cart.user.blank?
        cart.user = User.find_by(id: 1) || FactoryGirl.create(:user)
      end
    end
  end
end
