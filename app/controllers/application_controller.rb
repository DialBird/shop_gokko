class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :back_to_address

  helper_method :current_cart

  def current_cart(options = {})
    # guest tokenを作るまではこれで我慢
    return unless user_signed_in?
    # 必要か？
    return @current_cart if @current_cart

    @current_cart = Cart.incomplete.find_by(user_id: current_user.id)
    options[:create_cart_if_necessary] ||= false
    if @current_cart.blank? and options[:create_cart_if_necessary]
      @current_cart = Cart.create(user_id: current_user.id)
    end
    @current_cart
  end

  def back_to_address
    current_cart.try!(:back) if current_cart.can_back?
  end
end
