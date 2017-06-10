require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  login_user

  describe "GET #edit" do
    it "ステータス200を返す" do
      get :edit
      expect(response.status).to eq 200
    end

    it 'ビューを表示する' do
      get :edit
      expect(response).to render_template :edit
    end

    it 'cartインスタンス変数が存在していること' do
      get :edit
      expect(assigns(:cart)).to be_present
    end
  end
end
