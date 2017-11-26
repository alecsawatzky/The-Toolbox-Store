class ProductsController < ApplicationController

  before_action :initialize_session, :intialize_variables

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def cart
    customer_details
    @items_in_cart = Product.find(session[:cart])
    @product_id_list = session[:cart]
  end

  def checkout
    customer_details
    session[:amount] = @grand_total
  end

  def sale
  end

  def new
    @new_items = Product.where(:new => true)
  end

  def search
    if params[:category].empty? && params[:search].empty?
      redirect_to action: "index"
    elsif params[:category].empty?
      @search_results = Product.where("name LIKE '%#{params[:search]}%'")
    else
      @search_results = Product.where("name LIKE '%#{params[:search]}%' AND category_id == '#{params[:category]}'")
    end
  end

  def filter
    if params[:commit] == "Filter"
      @category = Category.find(params[:filter])
      @filter_results = Product.where("category_id == '#{params[:filter]}'").order(:name)
    else
      redirect_to root_url
    end
  end

  def add_to_cart
    id = params[:id].to_i
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

  def intialize_variables
    @sale_items = SaleProduct.all
  end

  def current_customer
    @current_customer ||= Customer.find_by(id: session[:customer_id])
  end

  def customer_details
    @total_items_in_cart = session[:cart].map{ |id| Product.order(:name).find(id) }
    @total_items_in_cart =  @total_items_in_cart.sort_by(&:name)
    @total = @total_items_in_cart.sum(&:price) * 100
    @subtotal = 0
    @amount_saved = 0

    @total_items_in_cart.each do |product|
      price = product.price
      if SaleProduct.find_by_id(product.id).present?
        discount_decimal = (SaleProduct.find(product.id).discount_percent / 100) * price
        price = price - discount_decimal
        @amount_saved += discount_decimal
      end
      @subtotal += price
    end

    @subtotal = @subtotal * 100

    if customer_signed_in?
      @current_customer = current_customer
      @province = @current_customer.province
      @email = @current_customer.email
      @pst = @province.pst
      @gst = @province.gst
      @hst = @province.hst

      @sales_pst = (@subtotal * @pst).round()
      @sales_gst = (@subtotal * @gst).round()
      @sales_hst = (@subtotal * @hst).round()
      @grand_total = (@subtotal + (@sales_gst + @sales_pst + @sales_hst)).round()
    else
      @pst = 0
      @gst = 0
      @hst = 0
      @grand_total = 0
    end
  end

  def customer_signed_in?
    current_customer.present?
  end
end
