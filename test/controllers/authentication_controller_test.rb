require 'test_helper'

class AuthenticationControllerTest < ActionDispatch::IntegrationTest
  setup do
    authenticate 'employer', 'asdf', 'asdf'
    @employer_token = response.parsed_body["auth_token"]
    authenticate "employee", 'asdf', 'asdf'
    @employee_token = response.parsed_body["auth_token"]
  end

  test "should authenticate employer" do 
    authenticate 'employer', 'asdf', 'asdf'
  end

  test "should authenticate employee" do
    authenticate "employee", 'asdf', 'asdf'
  end

  def authenticate iam, email, pw
    post '/' + iam + '/authenticate/', :params => {email: email, password: pw}, as: :json
    assert_response :success
  end
  
end