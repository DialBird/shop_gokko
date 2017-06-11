class CheckoutController < ApplicationController
  before_action :setup_for_current_state, only: [:edit, :update]

  private

  def setup_for_current_state
    @cart = current_cart
    method_name = :"before_#{@cart.state}"
    send(method_name) if respond_to?(method_name, true)
  end

  def before_address
    @cart = current_cart
  end
end
