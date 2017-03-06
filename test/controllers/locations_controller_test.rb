require 'test_helper'

class LocationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @location = locations(:one)
  end

  # test "should get index" do
  #   get '/employer/locations', as: :json
  #   assert_response :success
  # end

  test "should create location" do
    param = {:job => {
      :country => "HK"
    }}
    param[:job][:region] = "Kowloon"
    location = Location.find_or_initialize_by(country: param[:job][:country])
    assert location.save
    assert location.destroy
  end

  # test "should show location" do
  #   get location_url(@location), as: :json
  #   assert_response :success
  # end

  # test "should update location" do
  #   patch location_url(@location), params: { location: { address: @location.address, city: @location.city, country: @location.country, district: @location.district, region: @location.region } }, as: :json
  #   assert_response 200
  # end

  # test "should destroy location" do
  #   assert_difference('Location.count', -1) do
  #     delete location_url(@location), as: :json
  #   end

  #   assert_response 204
  # end
end
