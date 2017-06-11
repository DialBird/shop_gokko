# == Schema Information
#
# Table name: products # 商品
#
#  id         :integer          not null, primary key
#  name       :string           default(""), not null  # 商品名
#  price      :integer          default("0"), not null # 価格
#  cost       :integer          default("0"), not null # 原価
#  image      :string                                  # 商品画像
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validation' do
    let(:product) { FactoryGirl.build(:product) }

    describe '正常時' do
      it '保存されること' do
        expect(product).to be_valid
      end
    end

    describe 'name' do
      before do
        FactoryGirl.create(:product, name: 'あいう')
      end

      it 'nilは入らないこと' do
        product.name = nil
        expect(product).not_to be_valid
      end

      it '重複は入らないこと' do
        product.name = 'あいう'
        expect(product).not_to be_valid
      end
    end

    describe 'price' do
      it 'nilは入らないこと' do
        product.price = nil
        expect(product).not_to be_valid
      end

      it '少数は入らないこと' do
        product.price = 1.2
        expect(product).not_to be_valid
      end

      it '負の値は入らないこと' do
        product.price = -1
        expect(product).not_to be_valid
      end
    end

    describe 'cost' do
      it 'nilは入らないこと' do
        product.cost = nil
        expect(product).not_to be_valid
      end

      it '少数は入らないこと' do
        product.cost = 1.2
        expect(product).not_to be_valid
      end

      it '負の値は入らないこと' do
        product.cost = -1
        expect(product).not_to be_valid
      end
    end
  end
end
