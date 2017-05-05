class EmployeesController < ApplicationController
  skip_before_action :authenticate_request, only: :create
  before_action :set_employee, only: [:show, :update, :destroy]

  # GET /employees
  def index
    @employees = Employee.all

    render json: @employees
  end

  # GET /employees/1
  def show
    render json: @employee
  end

  # GET /get_employee/
  def get_employee
    @current_user
    is_employee = params[:iam] == 'employee' && @current_user == Employee.find(@current_user.id)
    render json: @current_user
  end

  # POST /employees
  def create
    @employee = Employee.find_by(:email => params[:employee][:email])

    unless !@employee
      logger.debug "User already exists"
      logger.debug @employee
      render json: {:error => "User already exists"}, status: :unprocessable_entity
      return
    end

    @employee = Employee.new(employee_params)

    if @employee.save
      @command = AuthenticateUser.call(@iam, params[:employee][:email], params[:employee][:password])
      if @command.success?
        render json: {
          :employee => EmployeeSerializer.new(@employee),
          :auth_token => @command.result
        }, status: :created
      else
        render json: @command.errors, status: :unprocessable_entity
      end
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  # PATCH /employees/1
  def update
    if @employee.update(employee_params)
      render json: @employee
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  # DELETE /employees/1
  def destroy
    @employee.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def employee_params
      params.require(:employee).permit(:email, :password, :name, :phone, :description, :first_name, :last_name, :image)
    end

    def set_location
      location_param = params[:employee][:location]
      return true if !location_param

      location_object = get_location_from_street(location_param)
      return nil if !location_object

      l = Location.find_or_initialize_by({
        :lng => location_object[:results][:geometry][:location][:lng],
        :lat => location_object[:results][:geometry][:location][:lat]
      })
      
      location_object[:results][:address_components].each do |address_component|
        street_number = address_component[:long_name] if address_component[:types].include?("street_number")
        street_name = address_component[:long_name] if address_component[:types].include?("route")
        region = address_component[:long_name] if address_component[:types].include?("administrative_area_level_1")
        area = address_component[:long_name] if address_component[:types].include?("neighborhood")
        country = address_component[:long_name] if address_component[:types].include?("country")
      end
      l.street = (!!street_number && !!street_name) ? (street_number + street_name) : location_param
      l.country = country
      l.area = area
      l.region = region

      return true if l.save

      render json: l.errors, status: :unprocessable_entity
      return false
    end

    def get_location_from_street(street)
      street.gsub(" ", "+")
      url = "https://maps.googleapis.com/maps/api/geocode/" +
            "json?key=AIzaSyDqDJTU7suCklbnStTcieulgVHci8myzcQ" +
            "&region=hk"
            "&street=" + street
      response = RestClient.get url
      logger.debug response
      logger.debug response.body
      return nil if response.code != 200 && response.body[:status] != "OK"
      return response.body
    end
end
