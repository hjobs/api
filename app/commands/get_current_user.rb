class GetCurrentUser < AuthenticationController
  prepend SimpleCommand

  def initialize(headers = {},iam)
    @headers = headers
    @iam = iam
  end

  def call
    user
  end

  private

  attr_reader :headers

  def user
    token = decoded_auth_token
    if token
      if @iam == 'employee'
        @current_user ||= Employee.find(token[:employee_id]) if token["employee_id"]
      elsif @iam == 'employer'
        @current_user ||= Employer.find(token[:employer_id]) if token["employer_id"]
      else
        @current_user = nil
      end
    end
    logger.debug "@current_user"
    logger.debug @current_user
    @current_user
  end

  def decoded_auth_token
    header = http_auth_header
    return JsonWebToken.decode(http_auth_header) if (header)
    nil
  end

  def http_auth_header
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    end
    nil
  end
end
