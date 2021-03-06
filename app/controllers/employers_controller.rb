class EmployersController < ApplicationController
  skip_before_action :authenticate_request
  before_action :set_employer, only: [:show, :update, :destroy]

  # GET /employers
  def index
    @employers = Employer.all

    render json: @employers
  end

  # GET /employers/1
  def show
    render json: @employer
  end

  # POST /employers
  def create
    @employer = Employer.new(employer_params)
    logger.debug @employer
    logger.debug @employer.org.id
    if @employer.save
      render json: @employer, status: :created
    else
      render json: @employer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /employers/1
  def update
    if @employer.update(employer_params)
      render json: @employer
    else
      render json: @employer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /employers/1
  def destroy
    @employer.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employer
      if params[:id]
        @employer = Employer.find(params[:id])
      elsif params[:email]
        @employers = Employer.find_by(:email => params[:email])
      end
    end

    # Only allow a trusted parameter "white list" through.
    def employer_params
      params.require(:employer).permit(:email, :password, :name, :admin, :description, :org_id)
    end
end
