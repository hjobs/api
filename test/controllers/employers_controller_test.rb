require 'test_helper'

class EmployersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @employer = employers(:one)
  end

  test "should get index" do
    get employers_url, as: :json
    assert_response :success
  end

  test "should create employer" do
    assert_difference('Employer.count') do
      post employers_url, params: { employer: { description: @employer.description, email: @employer.email, name: @employer.name, org_id: @employer.org_id, password: @employer.password } }, as: :json
    end

    assert_response 201
  end

  test "should show employer" do
    get employer_url(@employer), as: :json
    assert_response :success
  end

  test "should update employer" do
    patch employer_url(@employer), params: { employer: { description: @employer.description, email: @employer.email, name: @employer.name, org_id: @employer.org_id, password: @employer.password } }, as: :json
    assert_response 200
  end

  test "should destroy employer" do
    assert_difference('Employer.count', -1) do
      delete employer_url(@employer), as: :json
    end

    assert_response 204
  end
end
