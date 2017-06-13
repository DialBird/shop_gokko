class CartsController < ApplicationController
  def edit
    @cart = current_cart || Cart.incomplete.find_or_initialize_by(user_id: current_user.id)
    @cart = @cart.decorate
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
      redirect_back(fallback_location: root_path)
    else
      redirect_to cart_path
    end
  end

  def update
    redirect_to root_path unless @cart = current_cart
    @cart.contents.update_cart(cart_params)
    if params.key?(:checkout)
      redirect_to checkout_path
    else
      redirect_to cart_path
    end
  end

  private

  def cart_params
    return unless params[:cart]
    params.require(:cart).permit(cart_items_attributes: CartItem::PERMITTED_ATTRIBUTES)
  end
end
