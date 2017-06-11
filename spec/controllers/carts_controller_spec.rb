require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  login_user

  describe "GET #edit" do
    it 'ビューを表示すること' do
      get :edit
      expect(response.status).to eq 200
      expect(response).to render_template :edit
    end

    describe 'カートインスタンスについて' do
      context '使用中のカートが存在していない場合' do
        it '新しいカートインスタンスを返すこと' do
          expect { get :edit }.not_to change(Cart, :count)
          expect(assigns[:cart]).to be_a Cart
          expect(assigns[:cart].new_record?).to be_truthy
        end
      end

      context '使用中のカートがすでに存在している場合' do
        let!(:current_user) { subject.current_user }

        before do
          FactoryGirl.create(:cart, user_id: current_user.id)
          current_user.reload
        end

        it '使用中のカートインスタンスを返すこと' do
          get :edit
          expect(assigns[:cart]).to eq Cart.incomplete.find_by(user_id: current_user.id)
        end
      end
    end
  end

  describe 'PUT #populate' do
    before do
      FactoryGirl.create(:product)
    end

    it 'カート詳細画面にリダイレクトすること' do
      put :populate, params: { quantity: 1, product_id: 1 }
      expect(response.status).to eq 302
      expect(response).to redirect_to cart_path
    end

    context '使用中のカートが存在していない場合' do
      it '新しいカートを作成して、インスタンスに格納すること' do
        expect do
          put :populate, params: { quantity: 1, product_id: 1 }
        end.to change(Cart, :count).by(1)
        expect(assigns[:cart]).to be_present
      end
    end

    context '使用中のカートが存在している場合' do
      let!(:current_user) { subject.current_user }

      before do
        FactoryGirl.create(:cart, user_id: current_user.id)
        current_user.reload
      end

      it '使用中のカートをインスタンス変数に格納すること' do
        expect do
          put :populate, params: { quantity: 1, product_id: 1 }
        end.not_to change(Cart, :count)
        expect(assigns[:cart]).to eq Cart.incomplete.find_by(user_id: current_user.id)
      end
    end
  end
end
