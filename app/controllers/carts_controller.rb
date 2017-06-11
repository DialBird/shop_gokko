class CartsController < ApplicationController
  def edit
    @cart = current_cart || Cart.using.find_or_initialize_by(user_id: current_user.id, status_id: 1)
  end

  def populate
    @cart = current_cart(create_cart_if_necessary: true)
    quantity = params[:quantity].to_i
    product_id = params[:product_id].to_i

    if !quantity.between?(1, 2_147_483_647)
      @cart.errors.add(:base, '1以上の有効な数量を入力してください')
    end

    @cart.contents.add(product_id, quantity)

  rescue ActiveRecord::RecordInvalid => e
    @cart.errors.add(:base, e.record.errors.full_messages.join(','))
  ensure
    if @cart.errors.any?
      flash[:error] = @cart.errors.full_messages.join(',')
      redirect_back(fall_back_location: root_path)
    else
      redirect_to cart_path
    end
  end

  def update
    redirect_to root_path unless @cart = current_cart

    unless @cart.contents.update_cart(cart_params)
      flash.now[:danger] = '更新に失敗しました'
    end

    redirect_to cart_path
  end

  private

  def cart_params
    return unless params[:cart]
    params.require(:cart).permit(cart_items_attributes: CartItem::PERMITTED_ATTRIBUTES)
  end
end
