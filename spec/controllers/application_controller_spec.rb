require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  login_user

  describe "#current_cart" do
    context '使用中のカートがある場合' do
      let!(:current_user) { subject.current_user }

      before do
        FactoryGirl.create(:cart, user_id: current_user.id)
        current_user.reload
      end

      it '使用中のカートを返すこと' do
        expect(subject.current_cart(create_cart_if_necessary: true)).to eq Cart.incomplete.find_by(user_id: current_user.id)
      end
    end

    context '使用中のカートがない場合' do
      context 'create_cart_if_necessaryオプションがtrueの場合' do
        it '新しいカートモデルを作成して返すこと' do
          expect do
            subject.current_cart(create_cart_if_necessary: true)
          end.to change(Cart, :count).by 1
          expect(subject.current_cart(create_cart_if_necessary: true)).to be_a Cart
        end
      end

      context 'create_cart_if_necessaryオプションがfalseの場合' do
        it 'nilを返すこと' do
          expect(subject.current_cart(create_cart_if_necessary: false)).to be_nil
        end
      end
    end
  end
end
