class CheckoutController < ApplicationController
  before_action :authenticate_user!
  before_action :setup_current_cart
  skip_before_action :back_to_address

  def edit
    @cart = current_cart
  end

  def update
    # 戻るときはもっとスマートにやった方がいいのでは
    @cart = current_cart

    if params.key?(:confirm)
      if postal_code_and_address_included? and @cart.update(cart_params)
        @cart.to_confirm
      else
        flash.now[:danger] = '問題があります'
      end
    elsif params.key?(:back)
      @cart.back
    elsif params.key?(:complete)
      @cart.finish
    end

    render :edit
  end

  private

  def cart_params
    params.require(:cart).permit(Cart::PERMITTED_ATTRIBUTES)
  end

  def postal_code_and_address_included?
    return true if cart_params[:postal_code].present? and cart_params[:address].present?
    false
  end

  def setup_current_cart
    Cart.incomplete
        .find_by(guest_token: cookies.signed[:guest_token])
        .update(user_id: current_user.id)
  end
end
