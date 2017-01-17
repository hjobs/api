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
		# logger.debug ["inside authorize_api_request.rb --> user"]
		# logger.debug ['Helper.find(decoded_auth_token[:helper_id])',Helper.find(decoded_auth_token[:helper_id])]
		# logger.debug ["decoded_auth_token",decoded_auth_token]
    # logger.debug 'decoded_auth_token[:helper_id]'
    if decoded_auth_token
      if @iam == 'employee'
        @user ||= User.find(decoded_auth_token[:employee_id]) if decoded_auth_token["employee_id"]
      elsif @iam == 'employer'
        @user ||= Helper.find(decoded_auth_token[:employer_id]) if decoded_auth_token["employer_id"]
      else
        @user || errors.add(:iam, 'Invalid user type') && nil
      end
    end
    @user || errors.add(:token, 'Invalid token') && nil
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    else
      errors.add(:token, 'Missing token')
    end
    nil
  end
end
