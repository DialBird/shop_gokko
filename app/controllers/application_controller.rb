class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  helper_method :current_cart

  def current_cart
    return unless user_signed_in?
    # 必要か？
    return @current_cart if @current_cart
    
    if current_user.using_cart
      @current_cart = current_user.using_cart
    else
      @current_cart = Cart.create(user_id: current_user.id, status_id: 1)
    end
  end
end
