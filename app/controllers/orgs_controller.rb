class OrgsController < ApplicationController
  skip_before_action :authenticate_request, only: [:show, :create]
  before_action :set_org, only: [:show, :update, :destroy]

  # GET /orgs
  def index
    @orgs = Org.all

    render json: @orgs, :include => [:jobs]
  end

  # GET /orgs/1
  def show
    render json: @org
  end

  # GET /orgs/showPostings
  def show_postings
    @org = @current_user.org
    if !@org
      render status: :unauthorized
      return
    end
    @jobs = @org.jobs.left_outer_joins(:periods).where("periods.id IS NULL OR periods.date >= :today", :today => Date.today).distinct
    render json: @jobs, each_serializer: JobSerializer
  end

  # GET /orgs/whoAreWe
  def who_are_we
    @org = @current_user.org
    @org_json = OrgSerializer.new(@org)
    employers = @org.employers
    render :json => {
      :me => @current_user.as_json,
      :org => @org_json,
      :employers => employers.as_json
    }
  end

  # POST /orgs
  def create
    @org = Org.new(org_params)
    
    if @org.save
      @employer = Employer.new(employer_params)
      @employer.admin = true
      @employer.org = @org
      @org.email = @employer.email
      if @employer.save && @org.save
        @command = AuthenticateUser.call('employer', @employer.email, @employer.password)
        if @command.success?
          render json: {me: @employer, org: @org, employers: @org.employers, auth_token: @command.result }, status: :created
        else
          @employer.destroy
          @org.destroy
          render json: { error: @command.errors }, status: :unauthorized
        end
      else
        @org.destroy
        render json: @employer.errors, status: :unprocessable_entity
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
    unless @org.update(org_params) && set_location
      render json: @org.errors, status: :unprocessable_entity
      return
    end
    render json: @org
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
      params.require(:org).permit(:name, :description, :country, :region, :address, :logo, :email)
    end

    def employer_params
      params.require(:org).permit(:email, :password)
    end

    def sort(jobs)
      jobs.sort_by { |j|
        if j.periods.empty?
          j.updated_at
        else
          j.periods[0].date
        end
      }.reverse
    end

    def set_location
      l_params = params.require(:org).permit(:locations => [[:id, :address, :street, :country, :region, :city, :lat, :lng, :_destroy]])
      # logger.debug "l_param.empty? || !l_param.key?(:location)"
      return true if l_params.empty?

      l_params[:locations].each do |l_param|
        if l_param[:_destroy] == true
          l = Location.find_by_id(l_param[:id])
          ol = OrgLocation.find_by(:org => @org, :location => l)
          unless l && ol && ol.destroy
            render status: :unprocessable_entity
            return false
          end
        else
          l = Location.find_by(:lat => l_param[:lat], :lng => l_param[:lng])
          l = Location.find_by(:street => l_param[:street]) if !l
          logger.debug "!l"
          logger.debug !l
          l = Location.new(l_param) if !l
          unless l.save
            render json: l.errors, status: :unprocessable_entity
            return false
          end
          ol = OrgLocation.find_or_initialize_by(:location => l, :org => @org)
          unless ol.save
            render json: ol.errors, status: :unprocessable_entity
            return false
          end
        end
      end
      true
    end
end
