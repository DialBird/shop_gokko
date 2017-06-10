class CartContents
  attr_accessor :cart

  def initialize(cart)
    @cart = cart
  end

  def add(product_id, quantity = 1)
    cart_item = add_to_cart_item(product_id, quantity)
  end

  private

  def add_to_cart_item(product_id, quantity)
    params = { cart_id: cart.id, product_id: product_id }
    cart_item = CartItem.find_by(params)
    cart_item ||= cart.cart_items.new(params.merge(quantity: 0))

    cart_item.quantity += quantity
    cart_item.save!
    cart_item
  end
end
