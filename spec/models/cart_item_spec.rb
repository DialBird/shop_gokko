# == Schema Information
#
# Table name: cart_items # カート商品
#
#  id         :integer          not null, primary key
#  product_id :integer
#  cart_id    :integer
#  quantity   :integer          default("0"), not null # 量
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe CartItem, type: :model do
  describe 'validation' do
    let!(:product) { FactoryGirl.create(:product) }
    let!(:cart) { FactoryGirl.create(:cart) }
    let(:cart_item) { FactoryGirl.build(:cart_item, product: product, cart: cart) }

    describe '正常時' do
      it '保存されること' do
        expect(cart_item).to be_valid
      end
    end

    describe 'quantity' do
      it '負の値は入らないこと' do
        cart_item.quantity = -1
        expect(cart_item).not_to be_valid
      end

      it '少数は入らないこと' do
        cart_item.quantity = 1.2
        expect(cart_item).not_to be_valid
      end
    end
  end

  describe '#display_total' do
    let!(:product) { FactoryGirl.create(:product, price: 100) }
    let!(:cart) { FactoryGirl.create(:cart) }
    let(:cart_item) { FactoryGirl.build(:cart_item, product: product, cart: cart, quantity: 2) }

    it '特定の商品の合計額を返すこと' do
      expect(cart_item.display_total).to eq 100 * 2      
    end
  end
end
