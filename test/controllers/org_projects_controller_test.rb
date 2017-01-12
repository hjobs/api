require 'test_helper'

class OrgProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @org_project = org_projects(:one)
  end

  test "should get index" do
    get org_projects_url, as: :json
    assert_response :success
  end

  test "should create org_project" do
    assert_difference('OrgProject.count') do
      post org_projects_url, params: { org_project: { org_id: @org_project.org_id, project_id: @org_project.project_id } }, as: :json
    end

    assert_response 201
  end

  test "should show org_project" do
    get org_project_url(@org_project), as: :json
    assert_response :success
  end

  test "should update org_project" do
    patch org_project_url(@org_project), params: { org_project: { org_id: @org_project.org_id, project_id: @org_project.project_id } }, as: :json
    assert_response 200
  end

  test "should destroy org_project" do
    assert_difference('OrgProject.count', -1) do
      delete org_project_url(@org_project), as: :json
    end

    assert_response 204
  end
end
