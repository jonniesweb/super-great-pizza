# typed: false
require "application_system_test_case"

class ProductTypesTest < ApplicationSystemTestCase
  setup do
    @product_type = product_types(:one)
  end

  test "visiting the index" do
    visit product_types_url
    assert_selector "h1", text: "Product Types"
  end

  test "creating a Product type" do
    visit product_types_url
    click_on "New Product Type"

    fill_in "Code", with: @product_type.code
    fill_in "Name", with: @product_type.name
    click_on "Create Product type"

    assert_text "Product type was successfully created"
    click_on "Back"
  end

  test "updating a Product type" do
    visit product_types_url
    click_on "Edit", match: :first

    fill_in "Code", with: @product_type.code
    fill_in "Name", with: @product_type.name
    click_on "Update Product type"

    assert_text "Product type was successfully updated"
    click_on "Back"
  end

  test "destroying a Product type" do
    visit product_types_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Product type was successfully destroyed"
  end
end
