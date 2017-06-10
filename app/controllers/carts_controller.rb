class CartsController < ApplicationController
  def edit
    @cart = current_cart || Cart.using.find_or_initialize_by(user_id: current_user.id, status_id: 1)
  end
end
