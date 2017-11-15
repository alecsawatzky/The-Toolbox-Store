class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def category
  end

  def sale
    @sale_items = SaleProduct.all
  end

  def search
    @search_results = Product.where("name LIKE '%#{params[:search]}%'")
  end

  def filter
    if params[:commit] == "Filter"
      @filter_results = Product.where("category_id == '#{params[:filter]}'")
    else
      @filter_results = Product.all
    end
  end
end
