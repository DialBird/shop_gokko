require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  login_user

  describe "GET #index" do
    it 'ビューを表示すること' do
      get :index
      expect(response.status).to eq 200
      expect(response).to render_template :index
    end
  end
end
