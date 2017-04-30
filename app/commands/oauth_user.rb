class OauthUser < AuthenticationController
  prepend SimpleCommand

  def initialize(iam, id)
		@iam = iam
    @id = id
  end

  def call
    logger.debug @iam
    logger.debug @id
		# logger.debug ['inside authenticateuser.call, @iam is ' + @iam + ", @email = " + @email + ", @password = " + @password]
		if @iam == 'employee'
      JsonWebToken.encode(employee_id: employee.id) if employee
		elsif @iam == 'employer'
      JsonWebToken.encode(employer_id: employer.id) if employer
		end
  end

  private

  attr_accessor :email, :id, :api

  def employee
    employee = Employee.find(@id)
    return employee if employee

    errors.add :employer_authentication, 'invalid credentials'
    nil
  end

	def employer
		employer = Employer.find(@id)
		return employer if employer

		errors.add :employer_authentication, 'invalid credentials'
		nil
	end
end
