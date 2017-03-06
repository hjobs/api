require 'test_helper'

class JobPeriodsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @job_period = job_periods(:one)
  end

  test "should get index" do
    get job_periods_url, as: :json
    assert_response :success
  end

  test "should create job_period" do
    assert_difference('JobPeriod.count') do
      post job_periods_url, params: { job_period: { job_id: @job_period.job_id, period_id: @job_period.period_id } }, as: :json
    end

    assert_response 201
  end

  test "should show job_period" do
    get job_period_url(@job_period), as: :json
    assert_response :success
  end

  test "should update job_period" do
    patch job_period_url(@job_period), params: { job_period: { job_id: @job_period.job_id, period_id: @job_period.period_id } }, as: :json
    assert_response 200
  end

  test "should destroy job_period" do
    assert_difference('JobPeriod.count', -1) do
      delete job_period_url(@job_period), as: :json
    end

    assert_response 204
  end
end
