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
        redirect_to cart_url
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
    @province = Province.first

    @customer = Customer.new()

    @customer.email = params[:email]
    @customer.password = params[:password]
    @customer.province_id = @province.id

    logger.debug("Create the customer. #{@customer.inspect}")

    if @customer.save
      session[:customer_id] = @customer.id
      redirect_to cart_path
    else
      render :sign_up
    end
  end

  def destroy
    cookies.delete(:customer_id)
    redirect_to root_url
  end

end
