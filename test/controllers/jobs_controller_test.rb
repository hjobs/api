require 'test_helper'
require_relative 'authentication_controller_test'

class JobsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @job = jobs(:one)
  end

  test "should get index" do
    get '/employers/jobs', as: :json, headers: {Authorization: @employer_token}
    assert_response :success
  end

  test "should create job" do
    assert_difference('Job.count') do
      post '/employers/jobs', headers: { Authorization: @employer_token }, params: { job: { deadline: @job.deadline, description: @job.description, position: @job.position, salary_high: @job.salary_high, salary_low: @job.salary_low, salary_type: @job.salary_type, salary_unit: @job.salary_unit, salary_value: @job.salary_value, title: @job.title } }, as: :json
    end

    assert_response 201
  end

  test "should show job" do
    get job_url(@job), as: :json
    assert_response :success
  end

  test "should update job" do
    patch job_url(@job), params: { job: { deadline: @job.deadline, description: @job.description, position: @job.position, salary_high: @job.salary_high, salary_low: @job.salary_low, salary_type: @job.salary_type, salary_unit: @job.salary_unit, salary_value: @job.salary_value, title: @job.title } }, as: :json
    assert_response 200
  end

  test "should destroy job" do
    assert_difference('Job.count', -1) do
      delete job_url(@job), as: :json
    end

    assert_response 204
  end
end
