require 'test_helper'

class EmployeeProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @employee_project = employee_projects(:one)
  end

  test "should get index" do
    get employee_projects_url, as: :json
    assert_response :success
  end

  test "should create employee_project" do
    assert_difference('EmployeeProject.count') do
      post employee_projects_url, params: { employee_project: { employee_id: @employee_project.employee_id, message: @employee_project.message, project_id: @employee_project.project_id, status: @employee_project.status } }, as: :json
    end

    assert_response 201
  end

  test "should show employee_project" do
    get employee_project_url(@employee_project), as: :json
    assert_response :success
  end

  test "should update employee_project" do
    patch employee_project_url(@employee_project), params: { employee_project: { employee_id: @employee_project.employee_id, message: @employee_project.message, project_id: @employee_project.project_id, status: @employee_project.status } }, as: :json
    assert_response 200
  end

  test "should destroy employee_project" do
    assert_difference('EmployeeProject.count', -1) do
      delete employee_project_url(@employee_project), as: :json
    end

    assert_response 204
  end
end
