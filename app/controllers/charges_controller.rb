class ChargesController < ApplicationController
  def new
    @amount = 500
    @description = @customer.stripeBillingName
  end

  def create
    # Amount in cents
    @amount = 500

    if Customer.where(:email =>  params[:stripeEmail]).empty?
      @customer = Stripe::Customer.create(email: params[:stripeEmail],
                                          name: params[:stripeBillingName],
                                          source: params[:stripeToken])

      @charge = Stripe::Charge.create(customer: @customer.id,
                                      amount: @amount,
                                      description: 'Rails Stripe customer',
                                      currency: 'cad')

      logger.debug("Create the customer. #{@customer.inspect}")

      new_customer =  Customer.create(:stripe_identifier => @customer.id,
                                      # :name  => @customer.name,
                                      :email =>  @customer.email,
                                      :province_id => session[:province])

      logger.debug("Create the customer. #{new_customer.errors.messages.inspect}")
    else
      @customer = Customer.where(:email =>  params[:stripeEmail]).first

      @charge = Stripe::Charge.create(customer: @customer.stripe_identifier,
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
end
