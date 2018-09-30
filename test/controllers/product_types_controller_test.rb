require 'test_helper'

class ProductTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product_type = product_types(:one)
  end

  test "should get index" do
    get product_types_url
    assert_response :success
  end

  test "should get new" do
    get new_product_type_url
    assert_response :success
  end

  test "should create product_type" do
    assert_difference('ProductType.count') do
      post product_types_url, params: { product_type: { code: @product_type.code, name: @product_type.name } }
    end

    assert_redirected_to product_type_url(ProductType.last)
  end

  test "should show product_type" do
    get product_type_url(@product_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_type_url(@product_type)
    assert_response :success
  end

  test "should update product_type" do
    patch product_type_url(@product_type), params: { product_type: { code: @product_type.code, name: @product_type.name } }
    assert_redirected_to product_type_url(@product_type)
  end

  test "should destroy product_type" do
    assert_difference('ProductType.count', -1) do
      delete product_type_url(@product_type)
    end

    assert_redirected_to product_types_url
  end
end
