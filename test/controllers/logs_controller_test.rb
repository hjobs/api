require 'test_helper'

class LogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @log = logs(:one)
  end

  test "should get index" do
    get logs_url, as: :json
    assert_response :success
  end

  test "should create log" do
    assert_difference('Log.count') do
      post logs_url, params: { log: { action: @log.action, employee_id: @log.employee_id, employer_id: @log.employer_id, job_id: @log.job_id, name: @log.name, org_id: @log.org_id } }, as: :json
    end

    assert_response 201
  end

  test "should show log" do
    get log_url(@log), as: :json
    assert_response :success
  end

  test "should update log" do
    patch log_url(@log), params: { log: { action: @log.action, employee_id: @log.employee_id, employer_id: @log.employer_id, job_id: @log.job_id, name: @log.name, org_id: @log.org_id } }, as: :json
    assert_response 200
  end

  test "should destroy log" do
    assert_difference('Log.count', -1) do
      delete log_url(@log), as: :json
    end

    assert_response 204
  end
end
