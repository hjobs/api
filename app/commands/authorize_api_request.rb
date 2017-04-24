class AuthorizeApiRequest < AuthenticationController
  prepend SimpleCommand

  def initialize(headers = {},iam)
    @headers = headers
    @iam = iam
    logger.debug @iam
  end

  def call
    user
  end

  private

  attr_reader :headers

  def user
    if decoded_auth_token
      if @iam == 'employee'
        @user ||= Employee.find(decoded_auth_token[:employee_id]) if decoded_auth_token["employee_id"]
      elsif @iam == 'employer'
        @user ||= Employer.find(decoded_auth_token[:employer_id]) if decoded_auth_token["employer_id"]
      else
        @user || errors.add(:iam, 'Invalid user type') && nil
      end
    end
    !!@user || errors.add(:token, 'Invalid token') && false
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    logger.debug 'authroisation loggin at authroize api request'
    logger.debug headers['Authorization']
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    else
      errors.add(:token, 'Missing token')
    end
    nil
  end
end
