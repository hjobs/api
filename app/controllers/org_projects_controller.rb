class OrgProjectsController < ApplicationController
  before_action :set_org_project, only: [:show, :update, :destroy]

  # GET /org_projects
  def index
    @org_projects = OrgProject.all

    render json: @org_projects
  end

  # GET /org_projects/1
  def show
    render json: @org_project
  end

  # POST /org_projects
  def create
    @org_project = OrgProject.new(org_project_params)

    if @org_project.save
      render json: @org_project, status: :created, location: @org_project
    else
      render json: @org_project.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /org_projects/1
  def update
    if @org_project.update(org_project_params)
      render json: @org_project
    else
      render json: @org_project.errors, status: :unprocessable_entity
    end
  end

  # DELETE /org_projects/1
  def destroy
    @org_project.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_org_project
      @org_project = OrgProject.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def org_project_params
      params.require(:org_project).permit(:org_id, :project_id)
    end
end
