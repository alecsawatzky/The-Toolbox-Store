class ChargesController < ApplicationController
  def new
    @amount = session[:amount]
    @description = @customer.stripeBillingName
  end

  def create
    # Amount in cents
    @amount = session[:amount]
    current_customer

    logger.debug("get the customer. #{current_customer.inspect}")

    if @current_customer.stripe_identifier.blank?
      @customer = Stripe::Customer.create(email: @current_customer.email,
                                          source: params[:stripeToken])

      @current_customer.stripe_identifier = @customer.id
      @current_customer.save

      @charge = Stripe::Charge.create(customer: @customer.id,
                                      amount: @amount,
                                      description: 'Rails Stripe customer',
                                      currency: 'cad')
    else
      @charge = Stripe::Charge.create(customer: @current_customer.stripe_identifier,
                                      amount: @amount,
                                      description: 'Rails Stripe customer',
                                      currency: 'cad')
    end

    if @charge.paid && @charge.amount == @amount
      cart_details
      order = create_order(@current_customer)

      @items_in_cart.each do |product|
        add_line_item(order, product, @product_id_list.count(product.id))
      end

      session[:cart] = []
    end
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  def current_customer
    @current_customer ||= Customer.find_by(id: session[:customer_id])
  end

  def create_order(customer)
    order = customer.orders.build

    order.status = "Paid"
    order.pst_rate = customer.province.pst
    order.gst_rate = customer.province.gst
    order.hst_rate = customer.province.hst
    order.save

    return order
  end

  def add_line_item(order, product, quantity)
    line_item = order.line_items.build

    line_item.product = product
    line_item.quantity = quantity
    line_item.price = product.price
    line_item.save
  end

  def cart_details
    @items_in_cart = Product.find(session[:cart])
    @product_id_list = session[:cart]
  end
end
