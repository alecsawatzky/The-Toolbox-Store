require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get products_index_url
    assert_response :success
  end

  test "should get category" do
    get products_category_url
    assert_response :success
  end

  test "should get sale" do
    get products_sale_url
    assert_response :success
  end

end
