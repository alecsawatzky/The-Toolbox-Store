class AuthenticationController < ApplicationController
  require 'bcrypt'
  skip_before_action :verify_authenticity_token

  def login
  end

  def authenticate
    @customer = Customer.find_by_email(params[:email])
    logger.debug("get the customer. #{@customer.inspect}")
    logger.debug("The password. #{params[:password]}")
    if @customer.present?
      if @customer.password == params[:password]
        redirect_to checkout_product_path(Product.find(session[:cart]))
        session[:customer_id] = @customer.id
        flash[:notice] = "Welcome back #{@customer.email}"
      else
        render :login
      end
    else
      render :login
    end
  end

  def sign_up
    @provinces = Province.all
  end

  def create
    province = Province.find_by_id(params[:province])
    @customer = Customer.new()
    @customer.email = params[:email]
    @customer.password = params[:password]
    @customer.province_id = province.id

    if @customer.save
      session[:customer_id] = @customer.id
      redirect_to cart_path
    else
      redirect_to authentication_sign_up_path
    end
  end
end
