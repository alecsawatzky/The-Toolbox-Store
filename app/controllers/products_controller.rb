class ProductsController < ApplicationController
  
  before_action :initialize_session

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def cart
    @items_in_cart = Product.find(session[:cart])
    @product_id_list = session[:cart]
  end

  def sale
    @sale_items = SaleProduct.all
  end

  def new
    @new_items = Product.where(:new => true)
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
    end
  end

   def add_to_cart
    id = params[:id].to_i;
    session[:cart] << id
    redirect_to root_url
   end

  private 

  def initialize_session
    session[:cart] ||= []
  end
end
