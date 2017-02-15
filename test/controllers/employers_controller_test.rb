require 'test_helper'
require_relative 'authentication_controller_test'

class EmployersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @employer = employers(:admin)
  end

  test "should get index" do
    get '/employer/employers', as: :json
    assert_response :success
  end

  test "should create employer" do
    assert_difference('Employer.count') do
      post '/employer/employers',
            params: { employer: { description: @employer.description, email: 'whatever', name: "whatever", org_id: @employer.org_id, password: 'whatever'} },
            as: :json,
            headers: {Authorization: @employer_token}
    end

    assert_response 201
  end

  test "should show employer" do
    get '/employer/employers/1', as: :json
    assert_response :success
  end

  test "should update employer" do
    patch '/employer/employers/1', params: {iam: 'employer', employer: { description: 'test description'} }, as: :json
    assert_response 200
  end

  test "should destroy employer" do
    assert_difference('Employer.count', -1) do
      delete '/employer/employers/1', params: {iam: 'employer'}, as: :json
    end

    assert_response 204
  end
end
