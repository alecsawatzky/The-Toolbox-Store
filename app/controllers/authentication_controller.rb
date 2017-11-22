class AuthenticationController < ApplicationController
  
  skip_before_action :verify_authenticity_token
  
  def login

  end

  def authenticate
    @customer = Customer.find_by("LOWER(email) = ?", params[:email].downcase)
    
      if @customer.present? && @customer.authenticate(params[:password])
        cookies.permanent.signed[:customer_id] = @customer.id
        redirect_to root_url
      else
        render :login
      end
  end

  def sign_up
    @provinces = Province.all
  end

  def create

    @province = Province.first
   
    @customer = Customer.new(:email => params[:email],
                            # :password_digest => params[:password],
                            :province_id => @province.id)

      logger.debug("Create the customer. #{@customer.inspect}")       

    if @customer.save
      cookies.signed[:customer_id] = @customer.id
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
