class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(10)
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
end
