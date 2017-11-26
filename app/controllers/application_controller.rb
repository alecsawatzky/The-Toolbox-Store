class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :load_categories

  private

  def load_categories
    @category_list = Category.all
  end

  protect_from_forgery with: :exception

  helper_method :customer_signed_in?, :current_customer

  protected

  def authenticate_customer
    cookies.delete(:customer_id) && redirect_to(root_url) if current_customer.blank?
  end

  def current_customer
    @current_customer ||= Customer.find_by(id: session[:customer_id])
  end

  def customer_signed_in?
    current_customer.present?
  end

end
