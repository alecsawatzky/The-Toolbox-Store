class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
 
  before_action :load_categories
  
  private
  def load_categories
     @category_list = Category.all
  end

  protect_from_forgery with: :exception
  
    helper_method :account_signed_in?, :current_account
  
    protected
  
    def authenticate_account
      cookies.delete(:account_id) && redirect_to(root_url) if current_account.blank?
    end
  
    def current_account
      @current_account ||= Account.find_by(id: cookies.signed[:account_id])
    end
  
    def account_signed_in?
      current_account.present?
    end

end
