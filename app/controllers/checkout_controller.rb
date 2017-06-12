class CheckoutController < ApplicationController
  def edit
    @cart = current_cart
  end

  def update
    # 戻るときはもっとスマートにやった方がいいのでは
    @cart = current_cart

    if @cart.update(cart_params)
    else
      flash.now[:danger] = '問題があります'
      @cart.back
    end

    if params.key?(:confirm)
      @cart.to_confirm
    elsif params.key?(:back)
      @cart.back
    end

    unless @cart.update(cart_params)
    end

    render :edit
  end

  private

  def cart_params
    params.require(:cart).permit(Cart::PERMITTED_ATTRIBUTES)
  end
end
