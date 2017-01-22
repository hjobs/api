class ProjectsController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :show, :index]
  before_action :set_project, only: [:show, :update, :destroy]

  # GET /projects
  def index
    @projects = Project.all

    render json: @projects.sort_by {|x| x.updated_at}.reverse, :include => [{:orgs => {:include => [:employers]}}]
  end

  # GET /projects/1
  def show
    render json: @project, :include => [{:org => {:include => [:employers]}}]
  end

  # POST /projects
  def create
    @project = Project.new(project_params)

    if @project.save
      render json: @project, status: :created, location: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/1
  def update
    if @project.update(project_params)
      render json: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def project_params
      params.require(:project).permit(:title, :description, :start_date, :end_date, :deadline, :reward_type, :reward_money, :reward_other)
    end
end
