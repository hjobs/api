require 'test_helper'

class ExperiencesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @experience = experiences(:one)
  end

  test "should get index" do
    get experiences_url, as: :json
    assert_response :success
  end

  test "should create experience" do
    assert_difference('Experience.count') do
      post experiences_url, params: { experience: { company_name: @experience.company_name, description: @experience.description, location_id: @experience.location_id, org_id: @experience.org_id, position: @experience.position, time_end: @experience.time_end, time_start: @experience.time_start, working: @experience.working } }, as: :json
    end

    assert_response 201
  end

  test "should show experience" do
    get experience_url(@experience), as: :json
    assert_response :success
  end

  test "should update experience" do
    patch experience_url(@experience), params: { experience: { company_name: @experience.company_name, description: @experience.description, location_id: @experience.location_id, org_id: @experience.org_id, position: @experience.position, time_end: @experience.time_end, time_start: @experience.time_start, working: @experience.working } }, as: :json
    assert_response 200
  end

  test "should destroy experience" do
    assert_difference('Experience.count', -1) do
      delete experience_url(@experience), as: :json
    end

    assert_response 204
  end
end
