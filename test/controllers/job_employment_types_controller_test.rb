require 'test_helper'

class JobEmploymentTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @job_employment_type = job_employment_types(:one)
  end

  test "should get index" do
    get job_employment_types_url, as: :json
    assert_response :success
  end

  test "should create job_employment_type" do
    assert_difference('JobEmploymentType.count') do
      post job_employment_types_url, params: { job_employment_type: { employment_type_id: @job_employment_type.employment_type_id, job_id: @job_employment_type.job_id } }, as: :json
    end

    assert_response 201
  end

  test "should show job_employment_type" do
    get job_employment_type_url(@job_employment_type), as: :json
    assert_response :success
  end

  test "should update job_employment_type" do
    patch job_employment_type_url(@job_employment_type), params: { job_employment_type: { employment_type_id: @job_employment_type.employment_type_id, job_id: @job_employment_type.job_id } }, as: :json
    assert_response 200
  end

  test "should destroy job_employment_type" do
    assert_difference('JobEmploymentType.count', -1) do
      delete job_employment_type_url(@job_employment_type), as: :json
    end

    assert_response 204
  end
end
