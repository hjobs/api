class EmploymentTypesController < ApplicationController
  before_action :set_employment_type, only: [:show, :update, :destroy]

  # GET /employment_types
  def index
    @employment_types = EmploymentType.all

    render json: @employment_types
  end

  # GET /employment_types/1
  def show
    render json: @employment_type
  end

  # POST /employment_types
  def create
    @employment_type = EmploymentType.new(employment_type_params)

    if @employment_type.save
      render json: @employment_type, status: :created, location: @employment_type
    else
      render json: @employment_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /employment_types/1
  def update
    if @employment_type.update(employment_type_params)
      render json: @employment_type
    else
      render json: @employment_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /employment_types/1
  def destroy
    @employment_type.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employment_type
      @employment_type = EmploymentType.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def employment_type_params
      params.require(:employment_type).permit(:name)
    end
end
