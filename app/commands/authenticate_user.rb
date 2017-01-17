class AuthenticateUser < AuthenticationController
  prepend SimpleCommand

  def initialize(iam, email, password)
		@iam = iam
    @email = email
    @password = password
  end

  def call
    logger.debug @iam
    logger.debug @email
    logger.debug @password
		logger.debug ['inside authenticateuser.call, @iam is ' + @iam + ", @email = " + @email + ", @password = " + @password]
		if @iam == 'employee'
      JsonWebToken.encode(employee_id: employee.id) if employee
		elsif @iam == 'employer'
      JsonWebToken.encode(employer_id: employer.id) if employer
		end
  end

  private

  attr_accessor :email, :password, :api

  def employee
    employee = Employee.find_by_email(@email)
    return employee if employee && employee.authenticate(@password)

    errors.add :employer_authentication, 'invalid credentials'
    nil
  end

	def employer
		employer = Employer.find_by_email(@email)
		return employer if employer && employer.authenticate(@password)

		errors.add :employer_authentication, 'invalid credentials'
		nil
	end
end
