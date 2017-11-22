class ChargesController < ApplicationController
  def new
    @amount = 500
    @description = @customer.stripeBillingName
  end

  def create
    # Amount in cents
    @amount = 500
    @current_customer = current_customer

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
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path

    if @charge.paid && @charge.amount == amount
      # order = Order.create()
    end
  end

  def current_customer
    @current_customer ||= Customer.find_by(id: session[:customer_id])
  end
end
