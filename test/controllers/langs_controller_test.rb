require 'test_helper'

class LangsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lang = langs(:one)
  end

  test "should get index" do
    get langs_url, as: :json
    assert_response :success
  end

  test "should create lang" do
    assert_difference('Lang.count') do
      post langs_url, params: { lang: { country: @lang.country, name: @lang.name } }, as: :json
    end

    assert_response 201
  end

  test "should show lang" do
    get lang_url(@lang), as: :json
    assert_response :success
  end

  test "should update lang" do
    patch lang_url(@lang), params: { lang: { country: @lang.country, name: @lang.name } }, as: :json
    assert_response 200
  end

  test "should destroy lang" do
    assert_difference('Lang.count', -1) do
      delete lang_url(@lang), as: :json
    end

    assert_response 204
  end
end
