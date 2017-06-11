require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  describe "GET #index" do
    login_user

    before { FactoryGirl.create_list(:product, 3) }

    it 'ビューを表示すること' do
      get :index
      expect(response.status).to eq 200
      expect(response).to render_template :index
    end

    it 'インスタンス変数が格納されていること' do
      get :index
      expect(assigns[:products]).to be_present
      expect(assigns[:products].size).to eq 3
    end
  end
end
