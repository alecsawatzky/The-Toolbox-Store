class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def category
  end

  def sale
  end
end
