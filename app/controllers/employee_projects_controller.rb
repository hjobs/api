class EmployeeProjectsController < ApplicationController
  before_action :set_employee_project, only: [:show, :update, :destroy]

  # GET /employee_projects
  def index
    @employee_projects = EmployeeProject.all

    render json: @employee_projects
  end

  # GET /employee_projects/1
  def show
    render json: @employee_project
  end

  # POST /employee_projects
  def create
    @employee_project = EmployeeProject.new(employee_project_params)

    if @employee_project.save
      render json: @employee_project, status: :created, location: @employee_project
    else
      render json: @employee_project.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /employee_projects/1
  def update
    if @employee_project.update(employee_project_params)
      render json: @employee_project
    else
      render json: @employee_project.errors, status: :unprocessable_entity
    end
  end

  # DELETE /employee_projects/1
  def destroy
    @employee_project.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee_project
      @employee_project = EmployeeProject.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def employee_project_params
      params.require(:employee_project).permit(:status, :message, :project_id, :employee_id)
    end
end
