require 'test_helper'

class JobLocationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @job_location = job_locations(:one)
  end

  test "should get index" do
    get job_locations_url, as: :json
    assert_response :success
  end

  test "should create job_location" do
    assert_difference('JobLocation.count') do
      post job_locations_url, params: { job_location: { job_id: @job_location.job_id, location_id: @job_location.location_id } }, as: :json
    end

    assert_response 201
  end

  test "should show job_location" do
    get job_location_url(@job_location), as: :json
    assert_response :success
  end

  test "should update job_location" do
    patch job_location_url(@job_location), params: { job_location: { job_id: @job_location.job_id, location_id: @job_location.location_id } }, as: :json
    assert_response 200
  end

  test "should destroy job_location" do
    assert_difference('JobLocation.count', -1) do
      delete job_location_url(@job_location), as: :json
    end

    assert_response 204
  end
end
