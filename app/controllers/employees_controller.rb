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
    if @iam == "employee"
      render json: @employee
    elsif @iam == "employer"
      has_permission = false
      @employee.jobs.each do |j|
        has_permission = true if j.org == @employee.org
      end
      if has_permission
        render json: @employee
      else
        render status: :unauthorized
      end
    end
  end

  # GET /get_employee/
  def get_employee
    if @iam == "employer"
      render status: :unauthorized
      return
    end
    is_employee = params[:iam] == 'employee' && @current_user == Employee.find(@current_user.id)
    logger.debug "is_employee"
    logger.debug is_employee == true
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
    return unless set_location && set_language && set_job_exps

    if @employee.update(employee_params)
      render json: @employee
    else
      logger.debug @employee.errors.to_json
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
      params.require(:employee).permit(:email, :password, :name, :phone, :description, :first_name, :last_name, :image, :cv)
    end

    def set_location
      l_param = params.require(:employee).permit(:location => [:address, :street, :country, :region, :city, :lat, :lng, :delete])
      # logger.debug "l_param.empty? || !l_param.key?(:location)"
      return true if l_param.empty? || !l_param.key?(:location)
      
      logger.debug "l_param[:location].empty?"
      logger.debug l_param[:location].empty?
      if l_param[:location].empty?
        @employee.location = nil
        unless @employee.save
          render @employee.errors, status: :unprocessable_entity
          return false
        end
        return true
      end

      l = Location.find_by(:lat => l_param[:location][:lat], :lng => l_param[:location][:lng])
      l = Location.find_by(:street => l_param[:location][:street]) if !l
      l = Location.new(l_param[:location]) if !l
      unless l.save
        render json: l.errors, status: :unprocessable_entity
        return false
      end

      @employee.location = l
      unless @employee.save
        render json: @employee.errors, status: :unprocessable_entity
        return false
      end
      true
    end

    def set_language
      lang_arr = params.require(:employee).permit(:lang_qs => [[:lang_code, :level, :id, :_destroy]])
      return true if lang_arr.empty? || !lang_arr.key?(:lang_qs)

      logger.debug "lang_arr"
      logger.debug lang_arr
      lang_arr[:lang_qs].each do |obj|
        if obj.key?("id")
          lang_q = LangQ.find_by_id(obj[:id])
          if obj.key?("_destroy") && obj[:_destroy] == true
            unless lang_q && lang_q.destroy
              render lang_q.errors, status: :unprocessable_entity
              return false
            end
          else
            lang = Lang.find_by_code(obj[:lang_code])
            if !lang || !lang_q
              render lang.errors || lang_q.errors, status: :unprocessable_entity
              return false
            end
            lang_q.update(
              :lang => lang,
              :level => obj[:level]
            )
            unless lang_q.save
              render lang_q.errors, status: :unprocessable_entity
              return false
            end
          end
        else
          lang = Lang.find_by_code(obj[:lang_code])
          if !lang
            render json: lang.errors, status: :unprocessable_entity
            return false
          end
          lang_q = LangQ.new(:lang => lang, :level => obj[:level], :employee => @current_user)
          unless lang_q.save
            render json: lang_q.errors, status: :unprocessable_entity
            return false
          end
        end
      end
      true
    end

    def set_job_exps
      logger.debug "inside set_job_exps"
      job_exps_params = params.require(:employee).permit(:job_exps =>
        [
          :id, :_destroy, :time_from, :time_to, :position, :description, :working, :company_name, :org_id,
          :location_attributes => [
            :address, :street, :country, :region, :city, :lat, :lng
          ]
        ]
      )
      # job_exps_params = params.require(:employee).permit(:job_exps => [])
      return true if job_exps_params.empty? || !job_exps_params.key?(:job_exps) || job_exps_params[:job_exps].empty?
      logger.debug "permited params and didn't return default true, gonna log params[:job_exps]"
      logger.debug job_exps_params[:job_exps]

      job_exps_params[:job_exps].each do |j_e_obj|
        if j_e_obj[:_destroy] == true
          j_e = JobExp.find(j_e_obj[:id])
          j_e.destroy
        else # not destroying
          j_e_obj[:employee] = @current_user if @iam == "employee"
          if j_e_obj.key?(:id) # is edit
            j_e = JobExp.find_by_id(j_e_obj[:id])
            if !j_e || !j_e.update(j_e_obj)
              render json: j_e.errors, status: :unprocessable_entity
              return false
            end
          else # is create
            j_e = JobExp.new(j_e_obj)
            if !j_e || !j_e.save
              logger.debug j_e.errors.to_json
              render json: j_e.errors, status: :unprocessable_entity
              return false
            end
          end
        end # not destroying ends
      end #job_exps_params loop ends
    end
end
