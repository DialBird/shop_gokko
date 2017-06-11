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

require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe 'validation' do
    let(:cart) { FactoryGirl.build(:cart) }

    describe '正常時' do
      it '保存されること' do
        expect(cart).to be_valid
      end
    end

    describe 'status_id' do
      it '1..3しか入らないこと' do
        cart.status_id = 3
        expect(cart).to be_valid
        cart.status_id = 4
        expect(cart).not_to be_valid
      end
    end
  end

  describe 'scope' do
    describe '#using' do
      let!(:using_cart) { FactoryGirl.create(:cart, status_id: 1) }
      let!(:not_using_cart) { FactoryGirl.create(:cart, status_id: 2) }

      it '使用中のものだけ返すこと' do
        expect(Cart.using).to match_array [using_cart]
      end
    end
  end

  describe '#any_items?' do
    context 'cart_itemsが１以上ある時' do
      let(:cart) do
        FactoryGirl.build(:cart) do |cart|
          FactoryGirl.create(:cart_item, cart: cart, quantity: 1)
        end
      end
      it 'trueを返すこと' do
        expect(cart.any_items?).to be_truthy
      end
    end

    context 'cart_itemsが０以下の時' do
      let(:cart) { FactoryGirl.build(:cart) }
      it 'falseを返すこと' do
        expect(cart.any_items?).to be_falsy
      end
    end
  end
end
