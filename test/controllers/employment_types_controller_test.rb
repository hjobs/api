require 'test_helper'

class EmploymentTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @employment_type = employment_types(:one)
  end

  test "should get index" do
    get employment_types_url, as: :json
    assert_response :success
  end

  test "should create employment_type" do
    assert_difference('EmploymentType.count') do
      post employment_types_url, params: { employment_type: { name: @employment_type.name } }, as: :json
    end

    assert_response 201
  end

  test "should show employment_type" do
    get employment_type_url(@employment_type), as: :json
    assert_response :success
  end

  test "should update employment_type" do
    patch employment_type_url(@employment_type), params: { employment_type: { name: @employment_type.name } }, as: :json
    assert_response 200
  end

  test "should destroy employment_type" do
    assert_difference('EmploymentType.count', -1) do
      delete employment_type_url(@employment_type), as: :json
    end

    assert_response 204
  end
end
