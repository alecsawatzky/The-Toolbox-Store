class ProductsController < ApplicationController
  
  before_action :initialize_session

  def index
    @products = Product.all
    @sale_items = SaleProduct.all
  end

  def show
    @product = Product.find(params[:id])
    @sale_items = SaleProduct.all
  end

  def cart
    customer_details
    @items_in_cart = Product.find(session[:cart])
    @product_id_list = session[:cart]

    @sale_items = SaleProduct.all
  end

  def checkout
    customer_details
    session[:amount] = @grand_total
  end

  def sale
    @sale_items = SaleProduct.all
  end

  def new
    @new_items = Product.where(:new => true)
    @sale_items = SaleProduct.all
  end

  def search
    if params[:filter].empty?
      redirect_to action: "index"
    else
      @search_results = Product.where("name LIKE '%#{params[:search]}%' AND category_id == '#{params[:filter]}'")
    end
  end

  def filter
    if params[:commit] == "Filter"
      @filter_results = Product.where("category_id == '#{params[:filter]}'").order(:name)
    else
      redirect_to root_url
    end
  end

   def add_to_cart
    id = params[:id].to_i;
    session[:cart] << id
    redirect_to cart_url
    flash[:notice] = "1 item added to cart"
   end

   def edit_quantity
    id = params[:id].to_i

    if params[:commit] == "+"
      session[:cart] << id
    elsif params[:commit] == "-"
      if session[:cart].count(id) > 1
        session[:cart].delete_at(session[:cart].index(id) || session[:cart].length)
      end  
    else
      session[:cart].delete(id)
    end
    redirect_to cart_url
   end

  private 

  def initialize_session
    session[:cart] ||= []
  end

  def current_customer
    @current_customer ||= Customer.find_by(id: session[:customer_id])
  end

  def customer_details
    if customer_signed_in?
      @current_customer = current_customer
      @province = @current_customer.province
      @email = @current_customer.email
      @pst = @province.pst
      @gst = @province.gst
      @hst = @province.hst
    else 
      @pst = 0
      @gst = 0
      @hst = 0
    end
    @total_items_in_cart = session[:cart].map{ |id| Product.order(:name).find(id) }
    @total_items_in_cart =  @total_items_in_cart.sort_by(&:name)
    @subtotal = @total_items_in_cart.sum(&:price) * 100
    @sales_pst = (@subtotal * @pst).round()
    @sales_gst = (@subtotal * @gst).round()
    @sales_hst = (@subtotal * @hst).round()
    @grand_total = (@subtotal + (@sales_gst + @sales_pst + @sales_hst)).round()
  end

  def customer_signed_in?
    current_customer.present?
  end
end
