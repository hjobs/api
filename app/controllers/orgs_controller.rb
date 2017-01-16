class OrgsController < ApplicationController
  before_action :set_org, only: [:show, :update, :destroy]

  # GET /orgs
  def index
    @orgs = Org.all

    render json: @orgs
  end

  # GET /orgs/1
  def show
    render json: @org
  end

  # POST /orgs
  def create
    @org = Org.new(org_params)

    if @org.save
      @employer = Employer.new(employer_params)
      @employer.org = @org
      if @employer.save
        @command = AuthenticateUser.call('employer', params.require(:org).permit(:email), params.require(:org).permit(:password))
        if @command.success?
          render json: {employer: @employer, org: @org, auth_token: @command.result }, status: :created, location: @org
        else
          @org.destroy
          @employer.destroy
          render json: { error: @command.errors }, status: :unauthorized
        end
      else
        ender json: @employer.errors, status: :unprocessable_entity
      end
    else
      render json: @org.errors, status: :unprocessable_entity
    end
  end

  # # POST /orgs
  # def create
  #   @org = Org.new(org_params)

  #   if @org.save
  #     render json: @org, status: :created, location: @org
  #   else
  #     render json: @org.errors, status: :unprocessable_entity
  #   end
  # end

  # PATCH/PUT /orgs/1
  def update
    if @org.update(org_params)
      render json: @org
    else
      render json: @org.errors, status: :unprocessable_entity
    end
  end

  # DELETE /orgs/1
  def destroy
    @org.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_org
      @org = Org.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def org_params
      params.require(:org).permit(:name, :description, :country, :region, :address, :logo)
    end

    def employer_params
      params.require(:org).permit(:email, :password, :description)
    end
end
