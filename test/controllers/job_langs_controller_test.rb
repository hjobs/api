require 'test_helper'

class JobLangsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @job_lang = job_langs(:one)
  end

  test "should get index" do
    get job_langs_url, as: :json
    assert_response :success
  end

  test "should create job_lang" do
    assert_difference('JobLang.count') do
      post job_langs_url, params: { job_lang: { job_id: @job_lang.job_id, lang_id: @job_lang.lang_id } }, as: :json
    end

    assert_response 201
  end

  test "should show job_lang" do
    get job_lang_url(@job_lang), as: :json
    assert_response :success
  end

  test "should update job_lang" do
    patch job_lang_url(@job_lang), params: { job_lang: { job_id: @job_lang.job_id, lang_id: @job_lang.lang_id } }, as: :json
    assert_response 200
  end

  test "should destroy job_lang" do
    assert_difference('JobLang.count', -1) do
      delete job_lang_url(@job_lang), as: :json
    end

    assert_response 204
  end
end
