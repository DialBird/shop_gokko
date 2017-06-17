class ApplicationController < ActionController::Base
  include Auth

  protect_from_forgery with: :exception
  before_action :back_to_address

  helper_method :current_cart

  def back_to_address
    current_cart.try!(:back) if current_cart.try!(:can_back?)
  end

  def current_cart(options = {})
    options[:create_cart_if_necessary] ||= false
    options.merge!(guest_token: cookies.signed[:guest_token])

    return @current_cart if @current_cart

    @current_cart = find_cart_by_token_or_user(current_cart_params)

    if @current_cart.blank? and options[:create_cart_if_necessary]
      @current_cart = Cart.create(current_cart_params)
    end
    @current_cart
  end

  private

  def find_cart_by_token_or_user(options = {})
    Cart.incomplete.find_by(current_cart_params)
  end

  def current_cart_params
    { guest_token: cookies.signed[:guest_token],
      user_id: current_user.try!(:id) }
  end
end
