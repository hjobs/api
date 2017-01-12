require 'test_helper'

class OrgJobsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @org_job = org_jobs(:one)
  end

  test "should get index" do
    get org_jobs_url, as: :json
    assert_response :success
  end

  test "should create org_job" do
    assert_difference('OrgJob.count') do
      post org_jobs_url, params: { org_job: { job_id: @org_job.job_id, org_id: @org_job.org_id } }, as: :json
    end

    assert_response 201
  end

  test "should show org_job" do
    get org_job_url(@org_job), as: :json
    assert_response :success
  end

  test "should update org_job" do
    patch org_job_url(@org_job), params: { org_job: { job_id: @org_job.job_id, org_id: @org_job.org_id } }, as: :json
    assert_response 200
  end

  test "should destroy org_job" do
    assert_difference('OrgJob.count', -1) do
      delete org_job_url(@org_job), as: :json
    end

    assert_response 204
  end
end
