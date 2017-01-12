require 'test_helper'

class EmployeeJobsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @employee_job = employee_jobs(:one)
  end

  test "should get index" do
    get employee_jobs_url, as: :json
    assert_response :success
  end

  test "should create employee_job" do
    assert_difference('EmployeeJob.count') do
      post employee_jobs_url, params: { employee_job: { employee_id: @employee_job.employee_id, job_id: @employee_job.job_id, message: @employee_job.message, status: @employee_job.status } }, as: :json
    end

    assert_response 201
  end

  test "should show employee_job" do
    get employee_job_url(@employee_job), as: :json
    assert_response :success
  end

  test "should update employee_job" do
    patch employee_job_url(@employee_job), params: { employee_job: { employee_id: @employee_job.employee_id, job_id: @employee_job.job_id, message: @employee_job.message, status: @employee_job.status } }, as: :json
    assert_response 200
  end

  test "should destroy employee_job" do
    assert_difference('EmployeeJob.count', -1) do
      delete employee_job_url(@employee_job), as: :json
    end

    assert_response 204
  end
end
